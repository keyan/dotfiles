export EDITOR=vim
export GIT_EDITOR=vim
export SHABU_REPO=~/code/shabu
export WORKON_HOME=$HOME/Envs
source /usr/local/bin/virtualenvwrapper.sh
source ~/.git-prompt.sh

export PATH=$PATH:~/usr/local/bin
export PATH=$PATH:~/bin
# Git tab completion
source ~/git-completion.bash

# Autojump
[[ -s $(brew --prefix)/etc/profile.d/autojump.sh ]] && . $(brew --prefix)/etc/profile.d/autojump.sh

# Colors
RED="\[\033[0;31m\]"
YELLOW="\[\033[1;33m\]"
GREEN="\[\033[0;32m\]"
BLUE="\[\033[1;34m\]"
LIGHT_RED="\[\033[1;31m\]"
LIGHT_GREEN="\[\033[1;32m\]"
CYAN="\[\033[0;36m\]"
LIGHT_CYAN="\[\033[1;36m\]"
WHITE="\[\033[1;37m\]"
LIGHT_GRAY="\[\033[0;37m\]"
COLOR_NONE="\[\e[0m\]"

export PS1="${GREEN}keyan@ \w${YELLOW}\$(__git_ps1) ${GREEN}$ ${COLOR_NONE}"
export CLICOLOR=1

alias gl='git log'
alias gb='git branch'
alias gs='git status'
alias gco='git checkout'
alias wv='workon venmo'
alias vs='vagrant ssh'
alias phag='cat ~/.persistent_history|ag'
alias hag='history|ag'

# History stuff
#################

# Keeps history FOOOORRR-EEEEE-VER
log_bash_persistent_history()
{
  [[
    $(history 1) =~ ^\ *[0-9]+\ +([^\ ]+\ [^\ ]+)\ +(.*)$
  ]]
  local date_part="${BASH_REMATCH[1]}"
  local command_part="${BASH_REMATCH[2]}"
  if [ "$command_part" != "$PERSISTENT_HISTORY_LAST" ]
  then
    echo $date_part "|" "$command_part" >> ~/.persistent_history
    export PERSISTENT_HISTORY_LAST="$command_part"
  fi
}

# Stuff to do on PROMPT_COMMAND still about history
run_on_prompt_command()
{
    log_bash_persistent_history
}

PROMPT_COMMAND="run_on_prompt_command"
