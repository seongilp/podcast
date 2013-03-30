#!/bin/bash

DATE=`date +%Y%m%d`
EBSURL="mms://211.218.209.124/L-FM_300k"
FPATH="$HOME/EBS"
FNAME="$1_$DATE"
RECTIME=$2
ASXFNAME="$FPATH/$FNAME.asx"
WAVFNAME="$FPATH/$FNAME.wav"
MP3FNAME="$FPATH/$FNAME.mp3"
MIMMS="/usr/bin/mimms"
MPLAYER="/usr/bin/mplayer"
LAME="/usr/bin/lame"

$MIMMS -q -t $RECTIME $EBSURL $ASXFNAME
if [ ! -f $ASXFNAME ];
then
	$MIMMS -q -t $RECTIME $EBSURL $ASXFNAME
	echo "ERROR...!!" >> a.txt
fi

$MPLAYER -quiet -ao pcm:file=$WAVFNAME $ASXFNAME
$LAME --quiet -h $WAVFNAME $MP3FNAME

/home/zihado/shell/dropbox_uploader.sh upload $MP3FNAME /public/EBS/$FNAME.mp3

cp $MP3FNAME /share/Dropbox/

rm -f $ASXFNAME
rm -f $WAVFNAME
