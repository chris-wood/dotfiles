#caw's zshrc -- borrowed from Nacho Solis

#####################################################
# Define variables to be exported
export PATH=$HOME/usr/bin:$PATH
export PATH=$PATH:/Users/isolis/dev/local/bin
#export PATH=/usr/local/sbin:/usr/sbin:/sbin:$PATH
#export PATH=/usr/local/java/bin:$PATH
#export LD_LIBRARY_PATH=$HOME/usr/lib:/usr/local/lib/:$LD_LIBRARY_PATH
  
export EDITOR=vim
export CVS_RSH=ssh

export ANDROID_SDK=/Users/dev/android-sdk-macosx
export PATH=$PATH:${ANDROID_SDK}/tools
export PATH=$PATH:${ANDROID_SDK}/platform-tools
#export ANDROID_NDK=/Users/dev/android-ndk-r4b

#export LC_CTYPE=en_US

#####################################################
# now let's define some aliases
alias vi="vim"
alias nprintcode="enscript -2 -C -E -G -j -r"
alias nprinttext="enscript -2 -G -j -r"
alias mp="mplayer -idx -fs"
alias syncdir="rsync -Wtrv --size-only"
alias apt-get="sudo apt-get"
alias aptitude="sudo aptitude"
alias ssh="ssh -A -X"
alias l="ls -l"

bindkey -v
bindkey '^e' insert-last-word
bindkey -a q push-line-or-edit
bindkey '^x' history-beginning-search-backward
bindkey '^r' history-incremental-search-backward

#####################################################
# Configure history, a big history
HISTFILE=$HOME/.zsh_history
SAVEHIST=100000
HISTSIZE=100000

######################################################
# Configure modules, etc.
#autoload -U compinstall
#zstyle :compinstall filename '/home/isolis/.zshrc'
autoload -U compinit
compinit
autoload -U colors
colors

########################################################
# Lets set the prompt
PS1="%{$fg[cyan]%}[%{$fg[default]%}%n%{$fg[cyan]%}@%{$fg[default]%}%m%{$fg[cyan]%}:%{$fg[default]%}%~%{$fg[cyan]%}]%(!.#.$)%{$fg[default]%} "
alias nshortprompt="export PS1=\"[%m:%1~]%(!.#.$) \""
alias nnormalprompt="export PS1=\"[%n@%m:%~]%(!.#.$) \""
#export PS1="[%n@%m:%~]%(!.#.$) "
#export PS1="[%n@%m:%1~]%(!.#.$) "

########################################################
# Lets define some of those neat functions

# chpwd
# executed every time the directory changes
#   - changes the name of the xterm window to user@host:path
chpwd() {
  [[ -t 1 ]] || return
  case $TERM in
    sun-cmd) print -Pn "\e]l%n@%m:%~\e\\"
    ;;
    *xterm*|rxvt|(dt|k|E)term) print -Pn "\e]2;%n@%m:%~\a"
    ;;
  esac
}

chpwd;

#######################################################
# Process OS specific stuff

case `uname -s` in
  Darwin) # Linux stuff
    alias ls="ls -G"
  ;;
  Linux) # Linux stuff
    alias ls="ls --color"
  ;;
  FreeBSD) # FreeBSD stuff
    alias ls="ls -G"
    if [[ $TERM == "xterm" ]] then
      export TERM=xterm-color
    fi
  ;;
  *) # Others ...
esac  


#######################################################
# Process host specific options

case `hostname` in
  verde) # Linux at work
    export JDK_HOME=/usr/local/java
    export JAVA_HOME=/usr/local/java
    export PATH=${JDK_HOME}bin:$PATH
  ;;
  rasa) # Linux at work
  ;;
  cacique) # Linux at home
    alias mp="mplayer -vo xv -monitoraspect 16:9 -idx -fs"
    alias mplayer="mplayer -vo xv -monitoraspect 16:9"
  ;;
  firewall)
  ;;
  miramar)
    export CVSROOT=/home/cvshome
  ;;
  *) # Generic host
esac
