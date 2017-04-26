#!/bin/bash

pPrint(){
  ~/hxs/testdir/cdx/pView.sh $@
}

echo -e "\e[1;30m --> \e[1;35m cdx \e[1;30m : `pPrint $1` \e[1;30m ->>> `pPrint $2`"
