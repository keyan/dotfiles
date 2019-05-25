export EDITOR=vim
export GIT_EDITOR=vim

# Virtualenvwrapper directory
export WORKON_HOME=$HOME/Envs
export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python3

# Scripts
export PATH=$PATH:~/bin
source ~/git-completion.bash
source ~/.git-prompt.sh

## PATH setup
# Golang
export GOROOT=$(go env GOROOT)
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin
# Python
export PATH="/usr/local/bin/python3:/usr/local/opt/python@2/bin:$PATH"
# Rust
export PATH="$HOME/.cargo/bin:$PATH"

# Disable localization support to allow for GNU C builds on OSX
export NO_GETTEXT=1

# Git stuff
git config --global web.browser open

# # Autojump
# [[ -s $(brew --prefix)/etc/profile.d/autojump.sh ]] && . $(brew --prefix)/etc/profile.d/autojump.sh

# Git completion
# if [ -f `brew --prefix`/etc/bash_completion ]; then
#     . `brew --prefix`/etc/bash_completion
# fi

# Loading virtualenvwrapper on terminal startup is way too slow, instead load it on demand
# when it is actually needed (which isn't very often for me these days).
alias venv_on='source /usr/local/bin/virtualenvwrapper.sh'

alias gl='git log'
alias gb='git branch'
alias gbb="git for-each-ref --sort=-\committerdate refs/heads/ --format='%(HEAD) %(color:yellow)%(refname:short)%(color:reset) - %(color:red)%(objectname:short)%(color:reset) - %(contents:subject) - %(authorname) (%(color:green)%(committerdate:relative)%(color:reset))'"
alias lines_by_author="git ls-files | xargs -n1 git blame --line-porcelain | sed -n 's/^author //p' | sort -f | uniq -ic | sort -nr"
alias gs='git status'
alias gc='git checkout'
alias gbclear="git branch | grep -v '\*\|master' | xargs -n 1 git branch -D"
alias gtclear="git tag -l | xargs git tag -d; git fetch"
alias gp="git pull origin master && gen_tags"
alias hag='history|ag'
alias ll='ls -la'
alias tf='terraform'
alias gen_tags='ctags -R --languages=python --python-kinds=-i --exclude=.mypy_cache .'

# Let `hub` be used as `git`
eval "$(hub alias -s)"

# Keeps history FOOOORRR-EEEEE-VER
export HISTFILESIZE=50000
export HISTSIZE=50000

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
