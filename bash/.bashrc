export EDITOR=vim
export GIT_EDITOR=vim

# Virtualenvwrapper directory
export WORKON_HOME=$HOME/Envs
export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python3

# Scripts
export PATH=$PATH:~/bin
source ~/git-completion.bash
source ~/.git-prompt.sh
# Fuzzy finding CTRL+R
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
source /usr/share/doc/fzf/examples/key-bindings.bash &> /dev/null
source /usr/share/doc/fzf/examples/completion.bash &> /dev/null
# zlib
export LDFLAGS="-L/usr/local/opt/zlib/lib"
export CPPFLAGS="-I/usr/local/opt/zlib/include"
export PKG_CONFIG_PATH="/usr/local/opt/zlib/lib/pkgconfig"

## PATH setup
# Golang
export GOROOT=$(go env GOROOT)
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$GOROOT/bin
# Python
export PATH="/usr/local/bin/python3:$PATH"

# Disable localization support to allow for GNU C builds on OSX
export NO_GETTEXT=1

# Git stuff
git config --global web.browser open

# Git completion
# if [ -f `brew --prefix`/etc/bash_completion ]; then
#     . `brew --prefix`/etc/bash_completion
# fi

# Loading virtualenvwrapper on terminal startup is way too slow, instead load it on demand
# when it is actually needed (which isn't very often for me these days).
alias venv_on='source /usr/local/bin/virtualenvwrapper.sh'

# alias gl="git log --graph --pretty=format:'%C(yellow)%h%C(cyan)%d%Creset %s %C(white)- %an, %ar%Creset'"
alias gl="git log"
alias gb='git branch'
alias glc='git rev-parse HEAD | pbcopy'
alias gbb="git for-each-ref --sort=-\committerdate refs/heads/ --format='%(HEAD) %(color:yellow)%(refname:short)%(color:reset) - %(color:red)%(objectname:short)%(color:reset) - %(contents:subject) - %(authorname) (%(color:green)%(committerdate:relative)%(color:reset))'"
alias lines_by_author="git ls-files | xargs -n1 git blame --line-porcelain | sed -n 's/^author //p' | sort -f | uniq -ic | sort -nr"
alias gs='git status'
alias gc='git checkout'
alias gbclear="git branch | grep -v '\*\|master' | xargs -n 1 git branch -D"
alias gtclear="git tag -l | xargs git tag -d; git fetch"
alias gcm="git branch --format='%(refname:short)' | grep 'master\|main' | head -1 | xargs -I% -- sh -c 'git checkout \"%\"; git pull origin \"%\";'"
alias hag='history|ag'
alias ll='ls -la'
alias gen_tags='ctags -R --languages=python --python-kinds=-i --exclude=.mypy_cache .'
alias vlc='/Applications/VLC.app/Contents/MacOS/VLC'

# Linux specific stuff
if [ "`uname -a | grep -i Linux`" ]; then
  # Aliases to make linux pretend to be mac
  alias pbcopy="xclip -selection clipboard"
  alias pbpaste="xclip -selection clipboard -o"

  # This fails if ROS isn't installed, but its okay
  # source /opt/ros/noetic/setup.bash $> /dev/null
fi

# Let `hub` be used as `git`
eval "$(hub alias -s &> /dev/null)"

# Keeps history FOOOORRR-EEEEE-VER
export HISTFILESIZE=50000
export HISTSIZE=50000

# Color constants
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

# Set the full bash prompt.
function set_bash_prompt () {
  # Set the PYTHON_VIRTUALENV variable.
  if test -z "$VIRTUAL_ENV" ; then
      PYTHON_VIRTUALENV=""
  else
      PYTHON_VIRTUALENV="${GREEN}[venv: `basename \"$VIRTUAL_ENV\"`]${COLOR_NONE} "
  fi

  if [ "`uname -a | grep -i Linux`" ]; then
    PS1="${COLOR_NONE}\u @ \h ${BLUE}\w${MAGENTA} $(__git_ps1 "(\u2387 %s)") ${PYTHON_VIRTUALENV} ${COLOR_NONE}\n> ${COLOR_NONE}"
  else
    PS1="${COLOR_NONE}\u @ \h ${BLUE}\w${MAGENTA} $(__git_ps1 "( %s)") ${PYTHON_VIRTUALENV} ${COLOR_NONE}\n⫸ ${COLOR_NONE}"
  fi
}

export PROMPT_COMMAND=set_bash_prompt

# # Autojump
# [[ -s $(brew --prefix)/etc/profile.d/autojump.sh ]] && . $(brew --prefix)/etc/profile.d/autojump.sh
# Jump (in lieu of autojump)
eval "$(jump shell bash)"

# Use default OS coloring for files when using ls
export CLICOLOR=1
PATH=$PATH:/Users/kpishdadian/.lyftkube-bin

# Mac Catalina+ keeps warning you about using bash...
export BASH_SILENCE_DEPRECATION_WARNING=1
