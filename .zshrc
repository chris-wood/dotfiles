#caw's zshrc -- extended from Nacho Solis

#####################################################
# Define variables to be exported
export PATH=$HOME/usr/bin:$PATH
export PATH=$PATH:/Users/isolis/dev/local/bin
#export PATH=/usr/local/sbin:/usr/sbin:/sbin:$PATH
#export PATH=/usr/local/java/bin:$PATH
#export LD_LIBRARY_PATH=$HOME/usr/lib:/usr/local/lib/:$LD_LIBRARY_PATH
  
export EDITOR=vim
export CVS_RSH=ssh

#export LC_CTYPE=en_US

#####################################################
replaceinplace() {
    grep -l "$2" $1 | xargs -n 1 perl -pi -e "s/$2/$3/g"
}
moreprime() {
    PYGMENT="pygmentize"
    if [ -x "$(command -v ${PYGMENT})" ]; then
        ${PYGMENT} $1
    else
        more $1
    fi
}

# now let's define some aliases
alias vi="vim"
alias nprintcode="enscript -2 -C -E -G -j -r"
alias nprinttext="enscript -2 -G -j -r"
alias printrfc="enscript -2rG -p - --line-numbers --color=1 -c $1 > out.ps && open out.ps"
alias rip=replaceinplace
alias mp="mplayer -idx -fs"
alias syncdir="rsync -Wtrv --size-only"
alias apt-get="sudo apt-get"
alias aptitude="sudo aptitude"
alias ssh="ssh -A -X"
alias l="ls -l"
alias g="git"
alias m="more"
alias more=moreprime

#bindkey -v
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
CURRENT_BRANCH=""
function listBranch () { 
    currentbranch=`git status 2>&1 | grep 'fatal'`
    # check to see if we failed to find a branch
    if [ "$currentbranch" != "" ]; then 
        CURRENT_BRANCH=""
    else
        CURRENT_BRANCH=`git status | grep 'On branch' | awk '{print $3}'`
        CURRENT_BRANCH="◀ $CURRENT_BRANCH ▶"
    fi
    echo $CURRENT_BRANCH
}

setopt PROMPT_SUBST
#PROMPT="%{$fg[cyan]%}[%{$fg[default]%}%n%{$fg[cyan]%}@%{$fg[default]%}%m%{$fg[cyan]%}:%{$fg[default]%}%~%{$fg[cyan]%}]%{$fg[black]%}|${CURRENT_BRANCH}|%(!.#.$)%{$fg[default]%} "
alias nshortprompt="export PROMPT=\"[%m:%1~]%(!.#.$) \""
alias nnormalprompt="export PROMPT=\"[%n@%m:%~]%(!.#.$) \""

PROMPT='%B%F{cyan}[%f%F{grey}%n@%m%f:%F{red}${${(%):-%~}}%F{cyan}]%B%F{blue}$(listBranch)%f ✗%b '

autoload -U promptinit
promptinit

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


# Display the time in the upper-right hand corner
#while sleep 1;
#do 
#    tput sc
#    tput cup 0 $(($(tput cols)-11));
#    echo -e "\e[31m`date +%r`\e[39m";
#    tput rc;
#done &

