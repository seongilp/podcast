#!/bin/bash

DATE=`date +%Y%m%d`
PUBDATE=`date -R`
#PUBDATE=`date "+%a, %d %b %Y %H:%M:%S %Z"`
FNAME="$1_$DATE"
RECTIME=$2
PODMP3="$FNAME.mp3"

vi -c "%g/<\/channel>/d" -c "wq" /var/www/ebs/ebs.xml
vi -c "%g/<\/rss>/d" -c "wq" /var/www/ebs/ebs.xml

echo "" >> /var/www/ebs/ebs.xml
echo "<item><title>"$1 $DATE"</title>" >> /var/www/ebs/ebs.xml
echo "<itunes:author>EBS</itunes:author>" >> /var/www/ebs/ebs.xml	
echo "<itunes:subtitle>EBS Radio</itunes:subtitle>" >> /var/www/ebs/ebs.xml
echo "<itunes:summary>EBS Radio</itunes:summary>" >> /var/www/ebs/ebs.xml
echo "<enclosure url=\"http://zihado.com/ebs/$PODMP3\" length=\"102400\" type=\"audio/mpeg\" />" >> /var/www/ebs/ebs.xml
echo "<guid>http://zihado.com/ebs/"$PODMP3"</guid>" >> /var/www/ebs/ebs.xml
echo "<pubDate>"$PUBDATE"</pubDate>" >> /var/www/ebs/ebs.xml
echo "<itunes:duration>$2:00</itunes:duration>" >> /var/www/ebs/ebs.xml
echo "<itunes:explicit>no</itunes:explicit>" >> /var/www/ebs/ebs.xml
echo "</item>" >> /var/www/ebs/ebs.xml
echo "" >> /var/www/ebs/ebs.xml
echo "</channel>" >> /var/www/ebs/ebs.xml
echo "</rss>" >> /var/www/ebs/ebs.xml
echo "" >> /var/www/ebs/ebs.xml
