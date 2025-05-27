#!/usr/bin/env bash

export LC_ALL=en_US.UTF-8

current_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$current_dir/utils.sh"


function trackStatus() {
  local pause_icon="$1"
  local play_icon="$2"
	local track_info

	track_info=$(osascript -e "
	tell application \"System Events\"
		if not (exists process \"Spotify\") then return \"not running\"
	end tell
	tell application \"Spotify\"
		if player state is stopped then return \"stopped\"
		set trackArtist to artist of current track
		set trackName to name of current track
		if player state is paused then
			return \"$pause_icon \" & trackArtist & \" - \" & trackName
		else
			return \"$play_icon \" & trackArtist & \" - \" & trackName
		end if
	end tell
")

case "$track_info" in
		"not running") echo "Spotify not running" ;;
		"stopped") echo "Spotify stopped" ;;
		*) echo "$track_info" ;;
	esac

}

function sliceTrack()
{
  local str="$1"
  local std="$2"
  local len=${#str}

  local result=""

  if [[ $len > $std ]]; then
    result="${str:0:std}"
    result+="..."
  else
    result=$str
  fi

  echo "$result"
}


function remoteControl() {
  toggle_button="$1"
  back_button="$2"
  next_button="$3"

  toggle="osascript -e 'tell application \"Spotify\" to playpause'"
  back="osascript -e 'tell application \"Spotify\" to back track'"
  next="osascript -e 'tell application \"Spotify\" to play next track'"


  tmux bind-key "$toggle_button" run-shell "$toggle"
  tmux bind-key "$back_button" run-shell "$back"
  tmux bind-key "$next_button" run-shell "$next"

}

main() {
  # save buffer to prevent lag
	local cache_file="/tmp/tmux_shpotify_cache"

	RATE=$(get_tmux_option "@dracula-refresh-rate" 2)

  MAX_LENGTH=$(get_tmux_option "@dracula-shpotify-length" 25)

  # Remote Control checker
  REMOTE_ACCESS=$(get_tmux_option "@dracula-shpotify-remote" false)

  PLAY_ICON=$(get_tmux_option "@dracula-shpotify-remote-play-icon" "♪")
  PAUSE_ICON=$(get_tmux_option "@dracula-shpotify-remote-pause" "❚❚ ")

  # Remote Control Buttons Customizations
  PLAY_PAUSE_BUTTON=$(get_tmux_option "@dracula-shpotify-remote-pp" "P")
  BACK_BUTTON=$(get_tmux_option "@dracula-shpotify-remote-back" "R")
  NEXT_BUTTON=$(get_tmux_option "@dracula-shpotify-remote-next" "N")


  # os checker
  if [[ "$OSTYPE" != "darwin"* ]]; then
    echo "macOS only"
    exit 1
  fi

  # Remote Access
  if [[ "$REMOTE_ACCESS" == true ]]; then
    remoteControl "$PLAY_PAUSE_BUTTON" "$BACK_BUTTON" "$NEXT_BUTTON"
  else
    tmux unbind-key "$PLAY_PAUSE_BUTTON"
    tmux unbind-key "$BACK_BUTTON"
    tmux unbind-key "$NEXT_BUTTON"
  fi

  if [ ! -f "$cache_file" ] || [ $(($(date +%s) - $(stat -f%c "$cache_file"))) -ge "$RATE" ]; then
    trackStatus "$PAUSE_ICON" "$PLAY_ICON" > "$cache_file"
    sliceTrack "$(cat $cache_file)" "$MAX_LENGTH" > "$cache_file"
  fi

	cat "$cache_file"
}

main
