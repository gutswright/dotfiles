#!/usr/bin/env python3
"""Capture microphone audio, transcribe completed phrases, and type them."""

from __future__ import annotations

import argparse
import array
import collections
import json
import math
import os
import queue
import signal
import statistics
import subprocess
import sys
import threading
import wave
from pathlib import Path


SAMPLE_RATE = 16_000
FRAME_MS = 20
FRAME_SAMPLES = SAMPLE_RATE * FRAME_MS // 1000
FRAME_BYTES = FRAME_SAMPLES * 2

PRE_ROLL_MS = 250
CALIBRATION_MS = 500
MIN_SPEECH_MS = 250
END_SILENCE_MS = 900
TRAILING_PAD_MS = 100
MAX_UTTERANCE_MS = 20_000

MIN_ENERGY_THRESHOLD = 150.0
NOISE_MULTIPLIER = 2.0
NOISE_SMOOTHING = 0.05


class DictationWorker:
    def __init__(self, runtime_dir: Path, endpoint: str, audio_source: str | None) -> None:
        self.runtime_dir = runtime_dir
        self.ready_path = runtime_dir / "ready"
        self.endpoint = endpoint
        self.audio_source = audio_source
        self.stopping = threading.Event()
        self.phrases: queue.Queue[bytes | None] = queue.Queue()
        self.capture: subprocess.Popen[bytes] | None = None
        self.transcriber = threading.Thread(target=self.transcribe_phrases, daemon=False)

    @staticmethod
    def notify(summary: str, body: str = "", urgency: str = "normal") -> None:
        command = ["notify-send", "--urgency", urgency, summary]
        if body:
            command.append(body)
        subprocess.run(command, check=False)

    @staticmethod
    def frame_rms(frame: bytes) -> float:
        samples = array.array("h")
        samples.frombytes(frame)
        if not samples:
            return 0.0
        return math.sqrt(sum(sample * sample for sample in samples) / len(samples))

    def request_stop(self, _signum: int, _frame: object) -> None:
        self.stopping.set()

    @staticmethod
    def log(message: str) -> None:
        print(message, file=sys.stderr, flush=True)

    def write_wav(self, pcm: bytes, path: Path) -> None:
        with wave.open(str(path), "wb") as output:
            output.setnchannels(1)
            output.setsampwidth(2)
            output.setframerate(SAMPLE_RATE)
            output.writeframes(pcm)

    def transcribe(self, pcm: bytes, sequence: int) -> str:
        audio_path = self.runtime_dir / f"utterance-{os.getpid()}-{sequence}.wav"
        self.write_wav(pcm, audio_path)
        try:
            result = subprocess.run(
                [
                    "curl",
                    "--silent",
                    "--show-error",
                    "--fail",
                    "--max-time",
                    "120",
                    self.endpoint,
                    "-F",
                    f"file=@{audio_path}",
                    "-F",
                    "response_format=json",
                    "-F",
                    "temperature=0.0",
                    "-F",
                    "temperature_inc=0.0",
                ],
                check=True,
                capture_output=True,
                text=True,
            )
            response = json.loads(result.stdout)
            return " ".join(response.get("text", "").split())
        finally:
            audio_path.unlink(missing_ok=True)

    def type_text(self, text: str) -> None:
        subprocess.run(
            ["wtype", "-d", "1", "-"],
            input=f"{text} ",
            check=True,
            text=True,
        )

    def transcribe_phrases(self) -> None:
        sequence = 0
        while True:
            pcm = self.phrases.get()
            try:
                if pcm is None:
                    return
                sequence += 1
                text = self.transcribe(pcm, sequence)
                if text:
                    self.type_text(text)
            except (OSError, subprocess.SubprocessError, json.JSONDecodeError) as error:
                self.notify("Dictation error", str(error), "critical")
            finally:
                self.phrases.task_done()

    def enqueue_utterance(self, frames: list[bytes], silent_frames: int = 0) -> None:
        trailing_pad = TRAILING_PAD_MS // FRAME_MS
        trim_count = max(0, silent_frames - trailing_pad)
        if trim_count:
            frames = frames[:-trim_count]
        if frames:
            self.phrases.put(b"".join(frames))

    def capture_phrases(self) -> None:
        pre_roll_frames = max(1, PRE_ROLL_MS // FRAME_MS)
        calibration_frames = max(1, CALIBRATION_MS // FRAME_MS)
        minimum_voice_frames = max(1, MIN_SPEECH_MS // FRAME_MS)
        end_silence_frames = max(1, END_SILENCE_MS // FRAME_MS)
        maximum_frames = max(1, MAX_UTTERANCE_MS // FRAME_MS)

        pre_roll: collections.deque[bytes] = collections.deque(maxlen=pre_roll_frames)
        utterance: list[bytes] = []
        voice_frames = 0
        silent_frames = 0
        speaking = False
        noise_floor = 0.0

        capture_command = [
            "pw-record",
            "--verbose",
            "--raw",
            f"--rate={SAMPLE_RATE}",
            "--channels=1",
            "--format=s16",
        ]
        if self.audio_source:
            capture_command.append(f"--target={self.audio_source}")
        capture_command.append("-")

        self.log(f"starting microphone capture: source={self.audio_source or 'default'}")
        self.capture = subprocess.Popen(
            capture_command,
            stdout=subprocess.PIPE,
        )
        assert self.capture.stdout is not None

        calibration_energies: list[float] = []
        while len(calibration_energies) < calibration_frames and not self.stopping.is_set():
            frame = self.capture.stdout.read(FRAME_BYTES)
            if len(frame) != FRAME_BYTES:
                if self.capture.poll() is not None:
                    raise RuntimeError("pw-record stopped during microphone calibration")
                continue
            pre_roll.append(frame)
            calibration_energies.append(self.frame_rms(frame))

        if self.stopping.is_set():
            return

        if max(calibration_energies, default=0.0) == 0.0:
            raise RuntimeError(
                f"microphone source {self.audio_source or 'default'} produced only silence"
            )

        noise_floor = statistics.median(calibration_energies)
        threshold = max(MIN_ENERGY_THRESHOLD, noise_floor * NOISE_MULTIPLIER)
        self.log(f"microphone ready: noise floor={noise_floor:.1f}, voice threshold={threshold:.1f}")
        self.ready_path.touch(mode=0o600)

        while not self.stopping.is_set():
            frame = self.capture.stdout.read(FRAME_BYTES)
            if len(frame) != FRAME_BYTES:
                if self.capture.poll() is not None:
                    raise RuntimeError("pw-record stopped unexpectedly")
                continue

            energy = self.frame_rms(frame)
            threshold = max(MIN_ENERGY_THRESHOLD, noise_floor * NOISE_MULTIPLIER)
            has_voice = energy >= threshold

            if not speaking:
                pre_roll.append(frame)
                if has_voice:
                    speaking = True
                    utterance = list(pre_roll)
                    voice_frames = 1
                    silent_frames = 0
                else:
                    noise_floor += NOISE_SMOOTHING * (energy - noise_floor)
                continue

            utterance.append(frame)
            if has_voice:
                voice_frames += 1
                silent_frames = 0
            else:
                silent_frames += 1

            if silent_frames >= end_silence_frames:
                if voice_frames >= minimum_voice_frames:
                    self.enqueue_utterance(utterance, silent_frames)
                pre_roll.clear()
                pre_roll.extend(utterance[-pre_roll_frames:])
                utterance = []
                voice_frames = 0
                silent_frames = 0
                speaking = False
            elif len(utterance) >= maximum_frames:
                if voice_frames >= minimum_voice_frames:
                    self.enqueue_utterance(utterance)
                pre_roll.clear()
                utterance = []
                voice_frames = 0
                silent_frames = 0
                speaking = False

        if speaking and voice_frames >= minimum_voice_frames:
            self.enqueue_utterance(utterance, silent_frames)

    def stop_capture(self) -> None:
        if self.capture is not None and self.capture.poll() is None:
            self.capture.terminate()
            try:
                self.capture.wait(timeout=2)
            except subprocess.TimeoutExpired:
                self.capture.kill()
                self.capture.wait()

    def run(self) -> int:
        signal.signal(signal.SIGINT, self.request_stop)
        signal.signal(signal.SIGTERM, self.request_stop)
        self.ready_path.unlink(missing_ok=True)
        self.transcriber.start()
        exit_code = 0
        try:
            self.capture_phrases()
        except (OSError, RuntimeError) as error:
            exit_code = 1
            self.notify("Dictation stopped", str(error), "critical")
        finally:
            self.ready_path.unlink(missing_ok=True)
            self.stop_capture()
            self.phrases.put(None)
            self.transcriber.join()
            self.notify("Dictation off")
        return exit_code


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser()
    parser.add_argument("--runtime-dir", required=True, type=Path)
    parser.add_argument(
        "--endpoint",
        default="http://127.0.0.1:8178/inference",
    )
    parser.add_argument(
        "--audio-source",
        default=os.getenv("DICTATION_AUDIO_SOURCE"),
        help="PipeWire source node name; defaults to PipeWire's configured source",
    )
    return parser.parse_args()


def main() -> int:
    args = parse_args()
    args.runtime_dir.mkdir(mode=0o700, parents=True, exist_ok=True)
    return DictationWorker(args.runtime_dir, args.endpoint, args.audio_source).run()


if __name__ == "__main__":
    raise SystemExit(main())
