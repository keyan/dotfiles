export EDITOR=vim
export GIT_EDITOR=vim
export PATH=$PATH:~/code/oss/depot_tools
export PATH=$PATH:~/usr/local/bin:/Applications/Racket\ v6.6/bin

# Virtualenvwrapper directory
export WORKON_HOME=$HOME/Envs

# Scripts
export PATH=$PATH:~/bin
source ~/git-completion.bash
source ~/.git-prompt.sh
source /usr/local/bin/virtualenvwrapper.sh

# go path
export GOPATH=$HOME/.go
export GOROOT=/usr/local/opt/go/libexec
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$GOROOT/bin

# PHP Composer PATH
export PATH=$PATH:~/.composer/vendor/bin

# Elixir PATH
export PATH=$PATH:/usr/local/bin/elixir

# Disable localization support to allow for GNU C builds on OSX
export NO_GETTEXT=1

# Git stuff
git config --global web.browser open

# Autojump
[[ -s $(brew --prefix)/etc/profile.d/autojump.sh ]] && . $(brew --prefix)/etc/profile.d/autojump.sh

# Git completion
if [ -f `brew --prefix`/etc/bash_completion ]; then
    . `brew --prefix`/etc/bash_completion
fi

alias gl='git log'
alias gb='git branch'
alias gs='git status'
alias gc='git checkout'
alias gbclear="git branch --merged | grep -v '\*\|master' | xargs -n 1 git branch -d"
alias gtclear="git tag -l | xargs git tag -d; git fetch"
alias phag='cat ~/.persistent_history|ag'
alias hag='history|ag'
alias ll='ls -la'
alias gosrc='cd ~/.go/src/'
alias wv='workon venmo'

# Let `hub` be used as `git`
eval "$(hub alias -s)"

# Use Chef's ruby
eval "$(chef shell-init bash)"

# Keeps history FOOOORRR-EEEEE-VER
export HISTFILESIZE=50000
export HISTSIZE=50000

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

export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND ;} run_on_prompt_command"

# Powerline prompt, use custom is not installed
# keeping this off for now because I haven't
# finished customizing.
# if [ -f `which powerline-daemon` ]; then
if false; then
    powerline-daemon -q
    POWERLINE_BASH_CONTINUATION=1
    POWERLINE_BASH_SELECT=1
    . /usr/local/lib/python2.7/site-packages/powerline/bindings/bash/powerline.sh
else
    # Colors
    RED="\[\033[0;31m\]"
    YELLOW="\[\033[1;33m\]"
    GREEN="\[\033[0;32m\]"
    BLUE="\[\033[1;34m\]"
    MAGENTA="\[\033[1;35m\]"
    LIGHT_RED="\[\033[1;31m\]"
    LIGHT_GREEN="\[\033[1;32m\]"
    CYAN="\[\033[0;36m\]"
    LIGHT_CYAN="\[\033[1;36m\]"
    WHITE="\[\033[1;37m\]"
    LIGHT_GRAY="\[\033[0;37m\]"
    PURPLE="\e[0;35m"
    COLOR_NONE="\[\e[0m\]"

    export PS1="${GREEN}\u ${COLOR_NONE}@ ${GREEN}\w${YELLOW}\$(__git_ps1) ${GREEN}${COLOR_NONE}$ ${COLOR_NONE}"
    export CLICOLOR=1
fi
