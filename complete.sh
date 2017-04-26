#!/bin/bash

#cdxの補完
_cdx_complete(){
	case $2 in
		[0-9]* )
			COMPREPLY=( `cat ~/.cdx.bookmark|head -n$2|tail -n1` )
			;;
		*)
			;;
	esac
}
complete -d -F _cdx_complete cdx
