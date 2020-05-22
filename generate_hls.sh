#!/bin/bash

NAME=$1
VOD_PATH=/mnt/vod/
LIVE_PATH=/mnt/live/
PLAYLIST=$VOD_PATH$NAME.m3u8

echo "#EXTM3U" > $PLAYLIST
echo "#EXT-X-PLAYLIST-TYPE:VOD" >> $PLAYLIST
echo "#EXT-X-TARGETDURATION:10" >> $PLAYLIST
echo "#EXT-X-VERSION:4" >> $PLAYLIST
echo "#EXT-X-MEDIA-SEQUENCE:0" >> $PLAYLIST

ls $LIVE_PATH$NAME-* | sort -n -t - -k 6 | while read file; do

	FILENAME=`echo $file | cut -d'/' -f4`
	DURATION=`ffprobe -show_entries format=duration -v quiet -of csv="p=0" $file`
	
#	echo $FILENAME
#	echo $DURATION	

	mv $file $VOD_PATH
	echo "#EXTINF:$DURATION," >> $PLAYLIST
	echo $FILENAME >> $PLAYLIST

done

echo "#EXT-X-ENDLIST" >> $PLAYLIST

mv $LIVE_PATH$NAME.png $VOD_PATH
rm -f $LIVE_PATH$NAME.m3u8
