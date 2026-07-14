#!/bin/bash

DEVICE="/dev/video2"
SAVE_DIR="$HOME/photos"

mkdir -p "$SAVE_DIR"

for i in 3 2 1
do
    echo "$i"
    sleep 1
done

FILENAME="$SAVE_DIR/photo_$(date +%Y%m%d_%H%M%S).jpg"

ffmpeg \
-f v4l2 \
-input_format mjpeg \
-video_size 960x720 \
-framerate 30 \
-i "$DEVICE" \
-frames:v 1 \
-q:v 2 \
-y "$FILENAME"

echo "?? ?? ??: $FILENAME"
