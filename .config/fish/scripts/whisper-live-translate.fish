#!/usr/bin/env fish

set root $HOME/.local/opt/whisper.cpp
set data_home $XDG_DATA_HOME
test -n "$data_home"; or set data_home $HOME/.local/share
set models $data_home/whisper
set -g pidfile /tmp/whisper-live-translate.pid
set typing_disabled /tmp/whisper-live-translate.no-wtype

if test -s $pidfile
    set running_pid (string trim <$pidfile)
    if kill -0 $running_pid 2>/dev/null
        kill -TERM $running_pid
        exit
    end
end

echo $fish_pid >$pidfile
rm -f $typing_disabled

set output /tmp/whisper-translation-(date +%Y%m%d-%H%M%S)-$fish_pid.txt
set -q DICTATION_OUTPUT; and set output $DICTATION_OUTPUT

set result (mktemp /tmp/whisper-live.XXXXXX)
touch $output

set -g recorder_pid
set -g whisper_pid
set -g stopping false

function stop_recording --on-signal INT --on-signal TERM
    if test $stopping = false
        set -g stopping true
        echo 'Stopping recording; finishing captured audio...' >&2
        command -q notify-send; and notify-send "Voice recording stopped" "Transcribing captured audio"
        test -n "$recorder_pid"; and kill -TERM $recorder_pid 2>/dev/null
    end
end

function stop_on_exit --on-event fish_exit
    test -n "$recorder_pid"; and kill -TERM $recorder_pid 2>/dev/null
    if test -s $pidfile
        test (string trim <$pidfile) = $fish_pid; and rm -f $pidfile
    end
    rm -f $result
end

set input -f pulse -i default
set -q DICTATION_INPUT; and set input -re -i $DICTATION_INPUT

echo "Appending transcription to $output" >&2

ffmpeg \
    -hide_banner -loglevel warning \
    $input \
    -af 'highpass=f=80,dynaudnorm=f=150:g=15:p=0.9' \
    -ar 16000 -ac 1 -c:a pcm_s16le \
    -f wav pipe:1 \
    | setsid $root/build/bin/whisper-cli \
    -m $models/ggml-base.bin \
    -f - \
    --language auto \
    --translate \
    --no-timestamps \
    --no-prints \
    --output-txt \
    --vad \
    --vad-model $models/for-tests-silero-v6.2.0-ggml.bin \
    --vad-threshold 0.20 \
    --vad-min-speech-duration-ms 80 >$result &
set -g whisper_pid $last_pid
set pipeline_pids (jobs -lp)
set -g recorder_pid $pipeline_pids[1]

if test (count $pipeline_pids) -ne 2
    echo 'FFmpeg did not start.' >&2
    kill -TERM $whisper_pid 2>/dev/null
    wait $whisper_pid 2>/dev/null
    exit 1
end

if test $stopping = false
    command -q notify-send; and notify-send "Voice recording started" "Speak now"
end

test $stopping = true; and kill -TERM $recorder_pid 2>/dev/null

set whisper_status 1
while true
    wait $whisper_pid
    set whisper_status $status
    if not kill -0 $whisper_pid 2>/dev/null
        break
    end
end
set -g whisper_pid
set -g recorder_pid

if test $whisper_status -eq 0
    set text (string collect <$result)
    set text (string replace -a '[BLANK_AUDIO]' '' -- "$text")
    set text (string trim -- "$text")
    if test -n "$text"
        echo $text >&2
        echo $text >>$output
        set typed_text (string replace -ar '\s*\n\s*' ' ' -- "$text")
        printf '%s' "$typed_text" | wl-copy
        if not test -e $typing_disabled
            printf '%s' "$typed_text" | wtype -d 1 -
        end
    end
else
    echo 'Whisper transcription failed.' >&2
end

test $stopping = true; and test $whisper_status -eq 0; and echo 'All captured audio has been translated.' >&2
test $whisper_status -eq 0
