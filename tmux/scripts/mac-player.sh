#!/usr/bin/env bash
# Spotify status for Dracula tmux
# Displays current track with play/pause status (macOS only)

export LC_ALL=en_US.UTF-8

current_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source $current_dir/utils.sh

if [[ "$OSTYPE" != "darwin"* ]]; then
    echo "⏭️ Spotify (macOS only)"
    exit 1
fi

get_spotify_status() {
    local spotify_data
    spotify_data=$(osascript <<'END'
        tell application "System Events"
            if not (exists process "Spotify") then return "not_running"
        end tell
        tell application "Spotify"
            if player state is stopped then return "stopped"
            set t to "♪ " & artist of current track & " - " & name of current track
            if player state is paused then set t to "❚❚ " & artist of current track & " - " & name of current track
            return t
        end tell
END
    )
    case "$spotify_data" in
        "not_running") echo "Spotify not running" ;;
        "stopped")     echo "Spotify stopped" ;;
        *)             echo "$spotify_data" ;;
    esac
}

main() {
    local cache_file="/tmp/tmux_spotify_cache"
    RATE=$(get_tmux_option "@dracula-refresh-rate" 5)

    if [ ! -f "$cache_file" ] || [ $(($(date +%s) - $(stat -f%c "$cache_file"))) -ge "$RATE" ]; then
        get_spotify_status > "$cache_file"
    fi
    cat "$cache_file"


}

main "$@"
