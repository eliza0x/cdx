#!/bin/bash


cdx()
{
	. ~/hxs/testdir/cdx/cdx.sh $@
}
source ~/hxs/testdir/cdx/complete.sh
export CDX_AUTO_LS=0
alias xa='~/hxs/testdir/autotest.sh'

pView()
{
  ~/hxs/testdir/cdx/pView.sh $@
}

cdx_echo(){
  ~/hxs/testdir/cdx/cdx_echo.sh $@
}
file_deco(){
  ~/hxs/testdir/cdx/file_deco.sh
}

man_tmux()
{
  if [ "$TMUX" != "" ]; then
    tmux split-window man $@
  else
    bash -c "man $@"
  fi
}
alias man=man_tmux

xztaityozx_fzf_tmux(){
  if [ "$TMUX" != "" ]; then
    fzf-tmux
  else
    fzf
  fi
}
export FZF_DEFAULT_OPTS="--extended --cycle --ansi --select-1 --exit-0 --reverse"
alias fzf=xztaityozx_fzf_tmux

_tmux_nvim_new(){
  if [ "$TMUX" != "" ]; then
    tmux split-window -h nvim $@
  else
    nvim $@
  fi
}
alias nnvim=_tmux_nvim_new
