#!/bin/bash

cdx()
{
  local branch=$(python3 $CDX_DIR/py/branch.py "$@")
  local intaractive_srcFile="$HOME/.cdx.bookmark"
  local from=$(pwd)

  if [ $branch == 0 ]; then
    intaractive_srcFile="$HOME/.cdx_history"
  elif [ $branch == 2 ];then
    intaractive_srcFile=$(echo "$@"|awk '{print $NF}')
  fi
  
  python3 $CDX_DIR/py/dirmake.py $branch $(echo "$@"|awk '{print $NF}')
  if [ $? == 1 ]; then
    return 0
  fi

  cmd=$(python3 $CDX_DIR/py/optanalyze.py "$@")
  if [ $branch -le 2 ]; then
    eval $cmd
    $cdcommand $(python3 $CDX_DIR/py/filedeco.py $intaractive_srcFile | $CDX_FUZZY_COMMAND | awk '{print $2}') 2> /dev/null > /dev/null
  elif [ $branch == 6 ]; then
    python3 $CDX_DIR/py/addBookmark.py $(pwd)
    return 0
  else
    eval $cmd
    if [ $cdcommand == "popd" ]; then
      $cdcommand
    elif [ $cdcommand == "help" ]; then
      return 0
    else
      $cdcommand $changeTo > /dev/null
      echo $(pwd) >> ~/.cdx_history
    fi
  fi
  
  python3 $CDX_DIR/py/pView.py $from $(pwd)

  if [ "$autols" == 1 ]; then
    echo ""
    ls
  fi
}
