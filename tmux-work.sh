#!/bin/zsh
# Script to open the tmux work session

SESSIONNAME="work"
tmux has-session -t $SESSIONNAME &> /dev/null

if [ $? != 0 ]
then
  tmux new-session -s $SESSIONNAME -n nvim -d
  tmux send-keys -t $SESSIONNAME: "yarn; git fetch; git status; exec zsh" C-m
  while test $# -gt 0
  do
    case "$1" in
      ladle)
        tmux new-window -n ladle -t $SESSIONNAME: "yarn ladle:serve; exec zsh"
        ;;
      vitest)
        tmux new-window -n vitest -t $SESSIONNAME: "yarn test:run; exec zsh"
        ;;
    esac
    shift
  done
fi

tmux attach -t $SESSIONNAME:0
