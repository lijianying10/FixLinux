export TERM='xterm-256color'
export LANG=en_US.UTF-8
export LC_CTYPE="en_US.UTF-8"
export LC_ALL=en_US.UTF-8
TZ='Asia/Shanghai'; export TZ
stty stop ''
stty start ''
stty -ixon
stty -ixoff
PS1="[\[\e[32m\]#\##\[\e[31m\]\u@\[\e[36m\]\h \w]\$\[\e[m\]"
alias resetenv='curl https://raw.githubusercontent.com/lijianying10/FixLinux/master/script/env.sh | bash'
