#!/usr/bin/env fish

set -l runtime_base $XDG_RUNTIME_DIR
if test -z "$runtime_base"
    set runtime_base /tmp/dictation-(id -u)
end

set -l runtime_dir $runtime_base/dictation
set -l ready_file $runtime_dir/ready

mkdir -p -m 700 $runtime_dir

set -l worker_state (systemctl --user show dictation-worker.service --property ActiveState --value 2>/dev/null)
switch $worker_state
    case active activating
        systemctl --user stop --no-block dictation-worker.service
        notify-send "Dictation stopping" "Finishing the current phrase"
        exit 0
    case deactivating
        notify-send "Dictation stopping" "Finishing the current phrase"
        exit 0
end

if not command -q pw-record; or not command -q curl; or not command -q wtype
    notify-send --urgency critical "Dictation unavailable" "Missing pw-record, curl, or wtype"
    exit 1
end

if not systemctl --user start whisper-dictation.service
    notify-send --urgency critical "Dictation unavailable" "Could not start whisper-dictation.service"
    exit 1
end

set -l server_ready false
for attempt in (seq 1 100)
    if curl --silent --fail --output /dev/null --max-time 0.2 http://127.0.0.1:8178/
        set server_ready true
        break
    end
    sleep 0.1
end

if test $server_ready != true
    notify-send --urgency critical "Dictation unavailable" "Whisper server did not become ready"
    exit 1
end

rm -f $ready_file
if not systemctl --user start dictation-worker.service
    notify-send --urgency critical "Dictation unavailable" "Audio capture did not start; check journalctl --user -u dictation-worker"
    exit 1
end

set -l capture_ready false
for attempt in (seq 1 50)
    if test -e $ready_file
        set capture_ready true
        break
    end

    set worker_state (systemctl --user show dictation-worker.service --property ActiveState --value 2>/dev/null)
    if test "$worker_state" = failed; or test "$worker_state" = inactive
        break
    end
    sleep 0.1
end

if test $capture_ready != true
    systemctl --user stop --no-block dictation-worker.service
    notify-send --urgency critical "Dictation unavailable" "Microphone capture did not become ready; check journalctl --user -u dictation-worker"
    exit 1
end

notify-send "Dictation on" "Speak normally; pause to insert text"
