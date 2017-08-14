#!/bin/bash

## cdx - hyper cd command

##color
clr_error="\e[1;31m"
clr_main="\e[1;35m"
clr_Black="\e[1;30m"
clr_reset="\e[0;39m"
clr_green="\e[1;32m"

##もろもろのフラグ
__cdx_flag_ssh=0
__cdx_flag_use_fazzysearch=0
__cdx_flag_use_cd=0
__cdx_flag_make=0
__cdx_flag_automake=0
__cdx_flag_ls=0
##もろもろの変数
__cdx_fazzy_pipe="cat"
__cdx_current=`pwd`
__cdx_cd_command="pushd"
## OPT
ALLOPTS="$CDX_DEFAULT_OPTS $@"

##option解析
for OPT in $ALLOPTS; do
  case "$OPT" in
    '--ssh')
      __cdx_flag_ssh=1
      shift
      ;;
    '--help')
      echo -e  "Usage : cdx [OPTIONS] PATH"
      echo -e  "cdx is hyper cd command"
      echo -e  "This script is wrapper for the cd command."
      echo -e  "cdx automatically adds the value stored in CDX_DEFAULT_OPTS to option."
      echo -e  "Options : "
      echo -e  "\t--help\t\tprint this help."
      echo -e  "\t--fuzzy\t\tUse fuzzy search like fzf or peco or etc.The command must be stored in the variable  CDX_FUZZY_COMMAND"
      echo -e  "\t--cd\t\tUse cd command instead of pushd"
      echo -e  "\t--ls\t\tls command automatically executed after change directory."
      echo -e  "\t-h\t\tcd from history.This option must be use --fuzzy option"
      echo -e  "\t-b\t\tcd from bookmark.This option must be use --fuzzy option"
      echo -e  "\t+b\t\tAdd current directory to bookmark"
      echo -e  "\t-p\t\tUse popd command instead cd or pushd command."
      echo -e  "\t--automake\tWhen destination directory is not exists. cdx make directory automatically."
      echo -e  "\t--make\t\tWhen destination directory is not exists. cdx asks if you want to make directory."
      echo -e  "\t--ssh\t\tAllow ssh login when giving cdx a host name in ~/.ssh/config"
      return 0
      ;;
    '--fuzzy')
      __cdx_flag_use_fazzysearch=1
      __fazzy_pipe="$CDX_FUZZY_COMMAND"
      shift
      ;;
    '--cd')
      __cdx_cd_command="cd"
      __cdx_flag_use_cd=1
      shift
      ;;
    '--ls')
      __cdx_flag_ls=1
      shift
      ;;
    '-h')
      if [ $__cdx_flag_use_fazzysearch = 0 ]; then
        echo -e "${clr_error} cdx : ${clr_reset} this option must be use --fuzzy option"
        return 0
      fi
      __to=`cat ~/.cdx_history|$__cdx_fazzy_pipe`
      if [ "$__to" != "" ]; then
        $__cdx_cd_command $__to  > /dev/null
        cdx_echo $__cdx_current $__to
        return 0
      fi
      ;;
    '-b')
      if [ $__cdx_flag_use_fazzysearch = 0 ]; then
        echo -e "${clr_error} cdx : ${clr_reset} this option must be use --fuzzy option"
        return 0
      fi
      __to=$(cat ~/.cdx.bookmark|$__cdx_fazzy_pipe)
      if [ "$__to" != "" ]; then
        $__cdx_cd_command $__to > /dev/null
        cdx_echo $__cdx_current $__to
      fi
      return 0
      ;;
    '+b')
      echo -e "${clr_green} add Bookmark `pView`"
      echo $__cdx_current >> ~/.cdx.bookmark
      return 0
      ;;
    '-p')
      popd
      if [ $? = 0 ]; then
        cdx_echo $__cdx_current `pwd`
      fi
      return 0
      ;;
    '--automake')
      __cdx_flag_make=1
      __cdx_flag_automake=1
      shift
      ;;
    '--make')
      __cdx_flag_make=1
      shift
      ;;
    -*)
      echo "$OPT Didn't match anything"
      ;;
    *)
      __cdx_param="$OPT"
      ;;
  esac
done

__cdx_param=$(echo $__cdx_param|sed "s|~|$HOME|g")

ls $__cdx_param 2>/dev/null > /dev/null
if [ $? != 0 ] && [ $__cdx_flag_ssh == 1 ]; then
  __cdx_ssh_hosts=$(cat ~/.ssh/config|grep ^Host|grep $__cdx_param) 2>/dev/null
  if [ $? == 0 ]; then
    echo -e " ${clr_green}ssh to $__cdx_param ${clr_reset}"
    ssh $__cdx_param
    return 0
  fi
fi

pushd $__cdx_param 2>&1 > /dev/null
if [ $? != 0 ]; then
  echo -e "${clr_error}cdx : ${clr_reset}$__cdx_paramが見つかりませんでした"
  if [ $__cdx_flag_make == 1 ]; then
    if [ $__cdx_flag_automake == 1 ]; then
      mkdir $__cdx_param
      $__cdx_cd_command $__cdx_param
      echo $__cdx_param >> ~/.cdx_history
      cdx_echo $__cdx_current $(pwd)
    else
      echo -en "${clr_main}カレント以下に作りましょうか？(y/n):"
      read __cdx_ans
      if [ "$__cdx_ans" == "y" ]; then
        mkdir $__cdx_param
        $__cdx_cd_command $__cdx_param
        echo $__cdx_param >> ~/.cdx_history
        cdx_echo $__cdx_current $(pwd)
      fi
    fi
  fi
else
  cdx_echo $__cdx_current $(pwd)
  if [ $__cdx_flag_ls == 1 ]; then
    ls
  fi
fi
