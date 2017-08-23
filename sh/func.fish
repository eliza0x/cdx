#!/usr/bin/fish

function cdx
  set branch (python3 $CDX_DIR/py/branch.py $argv)
  set intaractive_srcFile "$HOME/.cdx.bookmark"
  set from (pwd)

  if [ $branch = 0 ];
    set intaractive_srcFile "$HOME/.cdx_history"
  else if [ $branch = 2 ];
    set intaractive_srcFile (echo $argv|awk '{print $NF}')
  end

  python3 $CDX_DIR/py/dirmake.py $branch (echo "$argv"|awk '{print $NF}')
  if [ $status = 1 ];
    return 0
  end

  set cmd (python3 $CDX_DIR/py/optanalyze.py $argv)

  if [ $branch -le 2 ];
    eval $cmd
    python3 $CDX_DIR/py/filedeco.py $intaractive_srcFile |eval $CDX_FUZZY_COMMAND | awk '{print $2}' 2> /dev/null |read dir
    eval $cdcommand $dir

  else if [ $branch = 6 ];
    python3 $CDX_DIR/py/addBookmark.py (pwd)
    return 0

  else
    eval $cmd
    if [ $cdcommand = "popd" ];
      eval $cdcommand
    else if [ $cdcommand = "help" ];
      return 0
    else
      eval $cdcommand $changeTo > /dev/null
      pwd >> $HOME/.cdx_history
    end
  end

  python3 $CDX_DIR/py/pView.py $from (pwd)

  if [ "$autols" = 1 ];
    echo ""
    ls
  end
end
