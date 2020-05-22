#!/bin/bash

LIVE_PATH=/mnt/live/
VOD_PATH=/mnt/vod/
for STREAMKEY in `ls $LIVE_PATH*.m3u8 | cut -d'/' -f4 | cut -d'.' -f1`; do
	FILENAME=`ls $LIVE_PATH$STREAMKEY-* | sort -n -t - -k 6 | tail -1`
	ffmpeg -i $FILENAME -vcodec png -vframes 1 -an -f rawvideo -s 360x200 -ss 00:00:01 -y $LIVE_PATH$STREAMKEY.png -v quiet

done

for STREAMKEY in `ls $VOD_PATH*.m3u8 | cut -d'/' -f4 | cut -d'.' -f1`; do

        FILENAME=`ls $VOD_PATH$STREAMKEY-* | sort -n -t - -k 6 | tail -1`
        ffmpeg -i $FILENAME -vcodec png -vframes 1 -an -f rawvideo -s 360x200 -ss 00:00:01 -y $VOD_PATH$STREAMKEY.png -v quiet

done
