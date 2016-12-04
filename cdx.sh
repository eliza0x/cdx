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
	if [ $cdx_bm_arg -ge ${#cdx_bookmark[@]} ] || [ $cdx_bm_arg -lt 0 ]; then
		echo -e "${clr_error}[ブックマークの範囲外です]"
		cd_flag=0
	fi
	#読み出し
	change_to=${cdx_bookmark[$cdx_bm_arg]}
else
	#引数のところへcd
	change_to=$cdx_bm_arg
fi

if [ $cdx_option == "-p" ]; then
	bef_dir=`pwd`
	popd
	if [ $? = 1 ]; then
		echo -e "  ${clr_Black}--> ${clr_main}cdx ${clr_Black}: ${clr_green}$bef_dir${clr_Black} ->>>${clr_green} `pwd`${clr_reset} "
	fi
	cd_flag=0
fi


if [ $cdx_option == "-h" ]; then
	line=$2
	if [ "$line" == "" ]; then
		line=`cat ~/.cdx_history|wc -l`
		lineStart=`echo $line - 10|bc`
		if [ $lineStart -lt 1 ]; then
			lineStart=1
		fi
		cat -n ~/.cdx_history|sed -n "$lineStart,${line}p"
		cd_flag=0
	elif [ $line == "clear" ]; then
		echo "" > ~/.cdx_history
		cd_flag=0
	else
		change_to=`cat ~/.cdx_history | sed -n "$line,${line}p"`
	fi
fi
if [ $cdx_option == "bm" ]; then
	export CDX_TMP_BM=`pwd`
	echo -e "${clr_green}Temporary BookMark${clr_Black} <-- ${clr_green}`pwd`"
	cd_flag=0
fi
if [ $cdx_option == "b" ]; then
	change_to=$CDX_TMP_BM
	cd_flag=1
fi

if [ $cd_flag = 1 ]; then
	bef_dir=`pwd`
	pushd $change_to > /dev/null
	if [ $? = 1 ]; then
		echo -e -n "${change_to}\nが見つかりませんでした。\n作ろうか？(y/n):"
		read ans
		if [ $ans == 'y' ]; then
			mkdir $change_to
			cd $change_to > /dev/null
			echo $bef_dir >> ~/.cdx_history
			echo -e "  ${clr_Black}--> ${clr_main}cdx ${clr_Black}: ${clr_green}$bef_dir${clr_Black} ->>>${clr_green} `pwd`${clr_reset} "
		fi
	else
		echo -e "  ${clr_Black}--> ${clr_main}cdx ${clr_Black}: ${clr_green}$bef_dir${clr_Black} ->>>${clr_green} `pwd`${clr_reset} "
		echo $bef_dir >> ~/.cdx_history

		history -a
		line=`cat ~/.bash_history|wc -l`
		lineStart=`echo $line - 6|bc`
		if [ $lineStart -lt 1 ]; then
			lineStart=1
		fi
		if [ `cat ~/.bash_history|sed -n "$lineStart,${line}p"|grep "ls"|wc -l` -ge 2 ]; then
			echo -e "${clr_main}探し物ですか？${clr_reset}"
			ls -la
		fi
	fi
fi

