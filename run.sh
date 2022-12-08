#!/bin/bash

set -eu

cd $(dirname $0)

rm -f videos.list.txt

ls -1 | grep MP4 | xargs -I {} bash -c "echo \"file '{}'\" >> videos.list.txt"

rm -f combined.mp4

ffmpeg -f concat -safe 0 -i videos.list.txt -c copy combined.mp4

rm -f final.mp4

ffmpeg -i combined.mp4 -i overlay.png -filter_complex '[0:v][1:v] overlay=0:0' -c:v h264_videotoolbox -b:v 15M -c:a copy final.mp4

rm -f combined.mp4
