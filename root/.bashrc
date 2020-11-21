HISTCONTROL=ignoreboth
HISTTIMEFORMAT="%F %T => "
TMOUT=''

if [[ ${EUID} == 0 ]] ; then
  PS1='\[\033[00;31m\]\h \[\033[00;36m\]\w \[\033[0m\]\$ \[\033[00m\]'
else
  PS1='\u@\[\033[01;32m\]\h \[\033[01;34m\]\W \$ \[\033[00m\]'
fi

alias cl='clear'
alias cp='cp -v'
alias e='exit'
alias free='free -mot '
#alias grep='grep --colour=auto'
alias h='history | grep '
alias kinit='kinit -f -p -l 1d -r 7d'
alias klist='klist -Afade'
alias l.='ls -d .[0-9a-zA-Z]*'
alias la='ll -A'
alias lf='ls -lAFhrt'
alias lS='ls -lAFhrS'
alias ll='ls -l'
alias ls='ls --color=auto -F'
alias mv='mv -v'
#alias ps='ps opid,uid,user,tty,cmd'
#alias ps='ps -o user,pid,%cpu,%mem,vsz,rss,tty,stat,start,time,command'
alias rm='rm -v'
alias s='sudo -i'
alias vi='/usr/local/bin/vim'

case "$TERM" in
  xterm-*)
    PROMPT_COMMAND="printf '\033k$(hostname)\033\\';"${PROMPT_COMMAND}
    ;;
esac

# duplicated from ~/.bash_profile, but used in my sssh function, above
#([[ $TERM == "xterm" ]] || [[ $TERM == "st-256color" ]] || [[ $TERM == "xterm-256color" ]]) && \
[[ $PS1 && -f ~/.shell_prompt.sh ]] && \
  source ~/.shell_prompt.sh

[[ $PS1 && -f /usr/local/share/bash-completion/bash_completion.sh ]] && \
  source /usr/local/share/bash-completion/bash_completion.sh

