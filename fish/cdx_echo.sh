#!/bin/bash

instdir="$(cd "$(dirname "${BASH_SOURCE:-$0}")"; pwd)"

pPrint(){
  $instdir/pView.sh $@
}

echo -e "\e[1;39m --> \e[1;35m cdx \e[1;39m : `pPrint $1` \e[1;39m ->>> `pPrint $2`"
