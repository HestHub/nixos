#!/bin/bash

prev_playing=""
/opt/homebrew/bin/media-control stream |
  while IFS= read -r line; do
    if [ "$(jq '.payload | length == 0' <<<"$line")" = "true" ]; then
      /etc/profiles/per-user/hest/bin/sketchybar --trigger media_app_inactive
    else
      diff=$(jq -r '.diff' <<<"$line")

      if [ "$diff" = "false" ]; then
        title=$(jq -r '.payload.title' <<<"$line")
        artist=$(jq -r '.payload.artist' <<<"$line")
        playing=$(jq -r '.payload.playing' <<<"$line")
        /etc/profiles/per-user/hest/bin/sketchybar --trigger media_stream_changed title="$title" artist="$artist" playing="$playing"
        prev_playing=$playing
      elif echo "$line" | jq -e '.payload | has("playing")' >/dev/null; then
        playing=$(jq -r '.payload.playing' <<<"$line")
        if [ "$playing" != "$prev_playing" ]; then
          /etc/profiles/per-user/hest/bin/sketchybar --trigger media_stream_changed playing="$playing"
          prev_playing=$playing
        fi
      fi
    fi
  done
