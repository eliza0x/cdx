#!/usr/bin/fish

## cdx - hyper cd command

set ALLOPTS "$CDX_DEFAULT_OPTS $argv"

##option解析

echo $ALLOPTS|xargs -n1

echo $ALLOPTS|sed 's/ /\n/g'|while read OPT in
  if $OPT == "--fuzzy"
    echo -n "set "
end
