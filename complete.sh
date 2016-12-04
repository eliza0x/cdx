#!/bin/bash

#cdxの補完
_cdx_complete(){
	case $2 in
		[0-9]* )
			COMPREPLY=( `echo "${cdx_bookmark[$2]}"` )
			;;
		*)
			;;
	esac
}
complete -d -F _cdx_complete cdx
