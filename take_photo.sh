#!/bin/bash

DEVICE="/dev/video0"
SAVE_DIR="$HOME/photos"
FILENAME="$SAVE_DIR/photo_$(date +%Y%m%d_%H%M%S).jpg"
FONT="/usr/share/fonts/truetype/dejavu/DejaVuSans-Bold.ttf"

mkdir -p "$SAVE_DIR"

echo "10? ?? ????? ?????."

# ??? ?? ??? 10? ????? ??
ffplay \
-loglevel error \
-f v4l2 \
-input_format mjpeg \
-video_size 960x720 \
-framerate 30 \
-vf "drawtext=fontfile=${FONT}:text='%{eif\\:ceil(10-t)\\:d}':fontcolor=white:fontsize=120:box=1:boxcolor=black@0.5:boxborderw=25:x=(w-text_w)/2:y=(h-text_h)/2" \
-window_title "10? ? ?? ??" \
-t 10 \
-autoexit \
"$DEVICE"

# ???? ?? ? ???? ??? ??? ?? ??
sleep 0.5

echo "??? ?????."

ffmpeg \
-loglevel error \
-f v4l2 \
-input_format mjpeg \
-video_size 960x720 \
-framerate 30 \
-i "$DEVICE" \
-frames:v 1 \
-q:v 2 \
-y "$FILENAME"

if [ -s "$FILENAME" ]; then
    echo "?? ?? ??: $FILENAME"

    # ??? ?? ???? ??
    xdg-open "$FILENAME" >/dev/null 2>&1 &
else
    echo "?? ??? ??????."
    exit 1
fi
