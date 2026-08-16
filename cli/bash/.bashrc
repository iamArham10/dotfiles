#
# ~/.bashrc
#

export EDITOR='nvim'
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '
export PATH="/home/arham/.local/bin:$PATH"

# Auto-start tmux
#if command -v tmux >/dev/null 2>&1; then
#  if [ -z "$TMUX" ]; then
#    tmux attach -t default || tmux new -s default
#  fi
#fi
export PATH="$HOME/.local/share/gem/ruby/3.4.0/bin:$PATH"

# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"
