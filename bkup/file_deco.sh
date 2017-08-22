#!/bin/bash


idx=1
while read LINE;do
  echo -e "\e[1;33m[$idx]\e[39m $LINE"
  idx=`echo $idx + 1|bc`
done
