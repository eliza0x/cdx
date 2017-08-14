#!/bin/bash

#cdxの補完
_cdx_complete(){
	case "$2" in
		[0-9]* )
			COMPREPLY=( `cat ~/.cdx.bookmark|head -n$2|tail -n1` )
      return 0
			;;
		-b)
      COMPREPLY=(`cat ~/.cdx.bookmark|file_deco|fzf|head -n1|awk '{print $2}'`)
      return 0
			;;
    -h)
      COMPREPLY=(`cat ~/.cdx_history|file_deco|fzf|head -n1|awk '{print $2}'`)
      return 0
      ;;
    *\*\*)
      dir=`echo "$2"|sed "s/\*//g;s|~|${HOME}|g"`
      COMPREPLY=("$dir"`ls -l "$dir" |grep ^d|awk '{print $9}'|fzf`)
      return 0
      ;;
	esac
}
complete -d -F _cdx_complete cdx
