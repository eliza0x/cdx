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
      COMPREPLY=(`echo $2|xargs -I {} dirname {}|sed "s|~|$HOME|"|xargs -I {} find {} -type d|fzf`)
      return 0
      ;;
	esac
}
complete -d -F _cdx_complete cdx
