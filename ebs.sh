#!/bin/bash

DATE=`date +%Y%m%d`
PUBDATE=`date -R`
#PUBDATE=`date "+%a, %d %b %Y %H:%M:%S %Z"`
#EBSURL="mms://211.218.209.124/L-FM_300k"
EBSURL="mms://ebslive.nefficient.com/ebswmslive"
FPATH="$HOME/EBS"
FNAME="$1_$DATE"
RECTIME=$2
ASXFNAME="$FPATH/$FNAME.asx"
WAVFNAME="$FPATH/$FNAME.wav"
MP3FNAME="$FPATH/$FNAME.mp3"
PODMP3="$FNAME.mp3"
MIMMS="/usr/bin/mimms"
MPLAYER="/usr/bin/mplayer"
LAME="/usr/bin/lame"

$MIMMS -q -t $RECTIME $EBSURL $ASXFNAME
if [ ! -f $ASXFNAME ];
then
	$MIMMS -q -t $RECTIME $EBSURL $ASXFNAME
	echo "ERROR...!!" >> a.txt
fi

$MPLAYER -quiet -vo null -ao pcm:file=$WAVFNAME $ASXFNAME &
PID=$!
sleep $(($2*60))
kill ${PID}

$LAME --quiet --ta EBS  -h $WAVFNAME $MP3FNAME

PODLEN=`stat -c %s $MP3FNAME`


cp $MP3FNAME /share/EBS/
cp $MP3FNAME /var/www/ebs/

vi -c "%g/<\/channel>/d" -c "wq" /var/www/ebs/ebs.xml
vi -c "%g/<\/rss>/d" -c "wq" /var/www/ebs/ebs.xml

echo "" >> /var/www/ebs/ebs.xml
echo "<item><title>"$1 $DATE"</title>" >> /var/www/ebs/ebs.xml
echo "<itunes:author>EBS</itunes:author>" >> /var/www/ebs/ebs.xml	
echo "<itunes:subtitle>EBS Radio</itunes:subtitle>" >> /var/www/ebs/ebs.xml
echo "<itunes:summary>EBS Radio</itunes:summary>" >> /var/www/ebs/ebs.xml
echo "<enclosure url=\"http://zihado.com/ebs/$PODMP3\" length=\"$PODLEN\" type=\"audio/mpeg\" />" >> /var/www/ebs/ebs.xml
echo "<guid>http://zihado.com/ebs/"$PODMP3"</guid>" >> /var/www/ebs/ebs.xml
echo "<pubDate>"$PUBDATE"</pubDate>" >> /var/www/ebs/ebs.xml
echo "<itunes:duration>"$2":00</itunes:duration>" >> /var/www/ebs/ebs.xml
echo "<itunes:explicit>no</itunes:explicit>" >> /var/www/ebs/ebs.xml
echo "</item>" >> /var/www/ebs/ebs.xml
echo "</channel>" >> /var/www/ebs/ebs.xml
echo "</rss>" >> /var/www/ebs/ebs.xml
echo "" >> /var/www/ebs/ebs.xml

/home/zihado/shell/dropbox_uploader.sh upload $MP3FNAME /public/EBS/$FNAME.mp3

rm -rf $ASXFNAME
rm -rf $WAVFNAME
