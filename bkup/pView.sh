#!/bin/bash

dir=${1:-`pwd`}
dir=`echo $dir|sed 's/\/$//'`

length=$(echo $dir|sed -e 's@[^/]@@g'|wc -c)

echo $dir|
sed 's/\///;s/\//\n/g'|
awk -v end=$length '
  BEGIN{
    idx=0
  }
  {
    if(idx==end-2){
      print "\\\\e[1;33m/"$1
    }else if(idx<=1){
      print "\\\\e[1;34m/"$1
    }else if(idx>=end-4){
      print "\\\\e[1;34m/"$1
    }else if(idx==2){
      print "\\\\e[1;34m/.."
    }
    idx++
  }
'|
while read LINE;do
  echo -en $LINE
done
echo -e "\e[39m"
