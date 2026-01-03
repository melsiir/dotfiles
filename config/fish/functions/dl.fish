function dl
    set -l aria2_config "$HOME/.config/aria2"
    set -l session_file "$aria2_config/session.txt"
    set -l log_file "$aria2_config/aria2.log"
    set -l download_dir "$HOME/Downloads"

    mkdir -p "$aria2_config" "$download_dir"

    set -l args
    set args $args --continue=true
    set args $args --split=8
    set args $args --max-connection-per-server=8
    set args $args --min-split-size=1M
    set args $args --file-allocation=none
    set args $args --check-certificate=true
    set args $args --remote-time=true
    set args $args --auto-file-renaming=true
    set args $args --allow-overwrite=false
    set args $args --dir="$download_dir"
    set args $args --max-tries=5
    set args $args --timeout=30
    set args $args --lowest-speed-limit=1K
    set args $args --disable-ipv6=true
    set args $args --console-log-level=notice # ← Less verbose
    set args $args --summary-interval=1 # ← Update every 1 sec
    set args $args --log="$log_file"

    if test -s "$session_file"
        set args $args --input-file="$session_file"
        set args $args --save-session="$session_file"
        set args $args --save-session-interval=10
    end

    aria2c $args $argv
end
