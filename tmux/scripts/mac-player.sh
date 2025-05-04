#!/usr/bin/env bash
# Spotify status for Dracula tmux
# Displays current track with play/pause status (macOS only)

export LC_ALL=en_US.UTF-8

current_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$current_dir/utils.sh" || { echo "❌ utils.sh missing"; exit 1; }

if [[ "$OSTYPE" != "darwin"* ]]; then
    echo "⏭️ Spotify (macOS only)"
    exit 0
fi

function slice_loop() {

	local str="$1"
	local start="$2"
	local how_many="$3"
	local len=${#str}

	local result=""

	for ((i = 0; i < how_many; i++)); do
		local index=$(((start + i) % len))
		local char="${str:index:1}"
		result="$result$char"
	done

	echo "$result"

}

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
    local rate=$(get_tmux_option "@dracula-refresh-rate" 5)

    if [ ! -f "$cache_file" ] || [ $(($(date +%s) - $(stat -f%c "$cache_file"))) -ge "$rate" ]; then
        get_spotify_status > "$cache_file"
    fi
    # cat "$cache_file"


    spotify_status=$(get_spotify_status)
    start=0
    len=${#spotify_status}
    terminal_width=25

      if [[ $len == 1 ]]; then
        exit
      fi

      scrolling_text=""

      for ((start = 0; start <= len; start++)); do
        scrolling_text=$(slice_loop "$spotify_status" "$start" "$terminal_width")
        echo -ne "\r"
        echo "$scrolling_text "
        echo -ne "\r"

        sleep 0.08
      done

      echo -ne "\r"
      echo "$scrolling_text "
      echo -ne "\r"
}

main "$@"
