#!/bin/bash

DATE=`date +%Y%m%d`
EBSURL="mms://ebslive.nefficient.com/ebswmslive"

echo "<item><title>Business English" $DATE "</title>" >> a.xml
echo "<itunes:author>EBS</itunes:author>" >> a.xml
echo "<itunes:subtitle>Busines English</itunes:subtitle>" >> a.xml
echo "<itunes:summary>Manager Kim</itunes:summary>">> a.xml
echo "<enclosure url=\"http://zihado.com/ebs/BizEnglish_"$DATE".mp3\" length=\"102400\" type=\"audio/mpeg\" />" >> a.xml
echo "<guid>http://zihado.com/ebs/BizEnglish_20130327.mp3</guid>" >> a.xml
echo "<pubDate>Wed, 27 Mar 2013 11:40:00 GMT</pubDate>" >> a.xml
echo "<itunes:duration>20:00</itunes:duration>" >> a.xml
echo "<itunes:explicit>no</itunes:explicit>" >> a.xml
echo "</item>">> a.xml

