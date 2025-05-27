#!/usr/bin/env bash

export LC_ALL=en_US.UTF-8

current_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$current_dir/utils.sh"


function trackStatus() {
	local active_player
	local browser_track_info

	active_player=$(osascript -e "
	property playerList : {\"Spotify\", \"Music\", \"Tidal\", \"Safari\", \"Google Chrome\", \"Firefox\", \"Core\" }
	property nativePlayerList : { \"Spotify\", \"Music\", \"Tidal\" }

	on detectPlayer()
	repeat with appName in playerList
		set currentApp to contents of appName
		tell application \"System Events\"
			if (exists process currentApp) then
				if currentApp is not in nativePlayerList then
					return browserPlayer(currentApp)
				return currentApp
				end if
			end if
		end tell
	end repeat
	end detectPlayer

	on browserPlayer(browserName)
		tell application \"browserName\"
			if browserName is \"Safari\" then 
				set currentTab to front document
			else if browserName is \"Google Chrome\"
				set currentTab to currentTab to active tab of front window
			else
				return \"not supported\"
			end if

			set currentURL to URL of currentTab
			set pageTitle to title of currentTab
		end tell
			-- Check if it's a YouTube video page
		if currentURL contains \"youtube.com/watch\" then
			-- YouTube video titles usually follow this format: \"Artist - Track Name\"
			set AppleScript's text item delimiters to \" - \"
			set titleParts to text items of pageTitle
	
			if (count of titleParts) ≥ 2 then
				set artistName to item 1 of titleParts
				set trackName to item 2 of titleParts
				display dialog \"Artist: \" & artistName & return & \"Track: \" & trackName
			else
				display dialog \"Could not parse artist and trackjk from: \" & pageTitle
			end if
		else
			display dialog \"The active tab is not a YouTube video.\"
		end if
	end browserPlayer


	detectPlayer()
	")

	browser_track_info=$(osascript -e "
		tell application \"Safari\"
			--- safari
			set currentTab to front document
			--- Google chrome: set currentTab to active tab of front window
			set currentURL to URL of currentTab
			set pageTitle to title of currentTab
		end tell

		-- Check if it's a YouTube video page
		if currentURL contains \"youtube.com/watch\" then
			-- YouTube video titles usually follow this format: \"Artist - Track Name\"
			set AppleScript's text item delimiters to \" - \"
			set titleParts to text items of pageTitle
	
			if (count of titleParts) ≥ 2 then
				set artistName to item 1 of titleParts
				set trackName to item 2 of titleParts
				display dialog \"Artist: \" & artistName & return & \"Track: \" & trackName
			else
				display dialog \"Could not parse artist and trackjk from: \" & pageTitle
			end if
		else
			display dialog \"The active tab is not a YouTube video.\"
		end if
	")


case "$browser_track_info" in
		"not running") echo "Music not running" ;;
		"stopped") echo "Music stopped" ;;
		*) echo "$browser_track_info" ;;
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




main() {
  # save buffer to prevent lag
	local cache_file="/tmp/tmux_mac_player_cache"

	RATE=$(get_tmux_option "@dracula-refresh-rate" 2)

  MAX_LENGTH=$(get_tmux_option "@dracula-amp-length" 25)

  # os checker
  if [[ "$OSTYPE" != "darwin"* ]]; then
    echo ""
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
    trackStatus > "$cache_file"
    sliceTrack "$(cat $cache_file)" "$MAX_LENGTH" > "$cache_file"
  fi

	cat "$cache_file"
}

main
