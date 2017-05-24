#!/bin/bash

## cdx is hyper cd command

##color setting
clr_error="\e[1;31m"
clr_main="\e[1;35m"
clr_Black="\e[1;30m"
clr_reset="\e[0;39m"
clr_green="\e[1;32m"

cdx_bm_arg=$1
cd_flag=1
change_to=$HOME
cdx_option=$1


if [ "$cdx_bm_arg" == "" ]; then
	cdx_bm_arg=$HOME
	cdx_option=$HOME
fi

if expr "$cdx_bm_arg" : "[0-9]*" > /dev/null  ; then
	#読み出し
change_to=`cat ~/.cdx.bookmark|head -n$cdx_bm_arg|tail -n1`
else
	#引数のところへcd
	change_to=$cdx_bm_arg
fi

if [ $cdx_option == "-p" ]; then
	bef_dir=`pwd`
	popd
	if [ $? = 0 ]; then
		d=`pwd`
    cdx_echo $bef_dir $d
	fi
	cd_flag=0
fi


if [ $cdx_option == "-h" ]; then
  bef_dir=`pwd`
  dir= `cat ~/.cdx_history|fzf --tac`
  if [ "$dir" != "" ]; then
    pushd ${dir:=`pwd`} > /dev/null
    cdx_echo $bef_dir $dir
  fi
  cd_flag=0
fi
if [ $cdx_option == "-bm" ]; then
  if [ "$2" == "add" ]; then
    echo -e "${clr_green} add bookmark `pView`"
    pwd >> ~/.cdx.bookmark
  else
	  export CDX_TMP_BM=`pwd`
	  echo -e "${clr_green}Temporary BookMark${clr_Black} <-- ${clr_green}`pView`"
  fi
	cd_flag=0
fi
if [ $cdx_option == "-b" ]; then
  bef_dir=`pwd`
  dir=`cat ~/.cdx.bookmark|fzf`
  if [ "$dir" != "" ]; then
    pushd $dir > /dev/null
    cdx_echo $bef_dir $dir
  fi
  cd_flag=0
fi
if [ $cdx_option == "-bt" ]; then
	change_to=$CDX_TMP_BM
	cd_flag=1
fi

if [ $cd_flag = 1 ]; then
	bef_dir=`pwd`
	pushd $change_to  > /dev/null
	if [ $? != 0 ]; then
		echo -e -n "${change_to}\nが見つかりませんでした。\nカレント以下に作ろうか？(y/n):"
		read ans
		if [ $ans == 'y' ]; then
			mkdir $change_to
			pushd $change_to > /dev/null
			echo $bef_dir >> ~/.cdx_history
      cdx_echo $bef_dir $change_to
		fi
	else
    cdx_echo $bef_dir $change_to
		echo $bef_dir >> ~/.cdx_history

		history -a
		line=`cat ~/.bash_history|wc -l`
		lineStart=`echo $line - 6|bc`
		if [ $lineStart -lt 1 ]; then
			lineStart=1
		fi
		if [ `cat ~/.bash_history|sed -n "$lineStart,${line}p"|grep "ls"|wc -l` -ge 2 ] && [ $CDX_AUTO_LS == 1  ]; then
			echo -e "${clr_main}探し物ですか？${clr_reset}"
			ls -la
		fi
	fi
fi

