#!/bin/bash

prev_playing=""
media-control stream |
  while IFS= read -r line; do
    diff=$(jq -r '.diff' <<<"$line")

    if [ "$diff" = "false" ]; then
      title=$(jq -r '.payload.title' <<<"$line")
      artist=$(jq -r '.payload.artist' <<<"$line")
      playing=$(jq -r '.payload.playing' <<<"$line")
      sketchybar --trigger media_stream_changed title="$title" artist="$artist" playing="$playing"
      prev_playing=$playing
    elif echo "$line" | jq -e '.payload | has("playing")' >/dev/null; then
      playing=$(jq -r '.payload.playing' <<<"$line")
      if [ "$playing" != "$prev_playing" ]; then
        sketchybar --trigger media_stream_changed playing="$playing"
        prev_playing=$playing
      fi
    fi
  done
