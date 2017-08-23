#!/bin/bash

#cdxの補完
_cdx_complete(){
	case "$2" in
		[0-9]* )
			COMPREPLY=( `cat ~/.cdx.bookmark|head -n$2|tail -n1` )
      return 0
			;;
		-b)
      COMPREPLY=(`python3 $CDX_DIR/py/filedeco.py "$HOME/.cdx.bookmark"|$CDX_FUZZY_COMMAND|head -n1|awk '{print $2}'`)
      return 0
			;;
    -h)
      COMPREPLY=(`python3 $CDX_DIR/py/filedeco.py "$HOME/.cdx_history"|$CDX_FUZZY_COMMAND|head -n1|awk '{print $2}'`)
      return 0
      ;;
    */--)
      COMPREPLY=(`python3 $CDX_DIR/py/filedeco.py "$2" |$CDX_FUZZY_COMMAND|head -n1|awk '{print $2}'`)
      return 0
      ;;
	esac
}
complete -d -F _cdx_complete cdx
