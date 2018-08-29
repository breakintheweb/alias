# wip
# adding ansi colors
red="[0;49;31m"
green="[0;49;32m"
yellow="[0;49;33m"
purple="[0;49;35m"
lgreen="[0;49;92m"
lyellow="[0;49;93m"
lblue="[0;49;94m"
teal="[0;49;96m"
default="[0m"
esc=$(printf '\033') # universal esc char

# function to add aliases to this file
# usage: aliadd aliasname "alias description" command
function aliadd() {
        if [ -f ~/.bash_aliases ]; then
                echo "# $2" >> ~/.bash_aliases
                echo "alias $1='${@:3}'" >> ~/.bash_aliases
                source ~/.bash_aliases;  #reload bashrc
                echo "Added alias:";
                alias $1; #show added command
        fi
        }

# colorize ip
alias ip='ip --color'
alias ipb='ip --color --brief'

# expand anything
alias xx="atool -x"

#tophist
alias bashtop="history | sed -e 's/ *[0-9][0-9]* *//' | sort | uniq -c | sort -rn | head -10"

# Colored df
alias disks='df -ha |\
             sed -e "s_/dev/sda[1-9]_${esc}$purple&${esc}$default_" |\
             sed -e "s_/dev/sdb[1-9]_${esc}[33m&${esc}${default}_" |\
             sed -e "s_/dev/sd[c-z][1-9]_${esc}[37m&${esc}${default}_" |\
             sed -e "s_[.,0-9]*[MG]_${esc}[36m&${esc}${default}_" |\
             sed -e "s_[0-9]*%_${esc}[32m&${esc}${default}_" |\
             sed -e "s_9[0-9]%_${esc}[31m&${esc}${default}_" |\
             sed -e "s_/mnt/[-_A-Za-z0-9]*_${esc}[35;1m&${esc}${default}_"'

# Search process by name and highlight !
function psgrep() { ps axuf | grep -v grep | grep "$@" -i --color=auto; }

# spawn shell on docker given the containerid
function dockersh() { docker exec -ti  "$@" /bin/bash; }

# Git logging in color
alias glog="git log -n 15 --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
# Get wan ip address
alias wanip='curl ifconfig.me'
# colorize netstat
alias netstat='grc netstat'
# dsiplay open ports
alias netopen='netstat -nape --inet'

#show listening connections with color
# IP
# Port
# Established
# UDP
# TCP
alias netlisten='lsof -Panl -i tcp -i udp |\
                 sed -e "s_\([0-9]\{1,3\}\.\)\{3\}[0-9]\{1,3\}_\x1b[33m&\x1b[0m_" |\
                sed -e "s_(ESTABLISHED)_\x1b[31m&\x1b[0m_" |\
                sed -e "s_UDP_${esc}${lblue}&${esc}${default}_"  |\
                sed -e "s_TCP_${esc}${purple}&${esc}${default}_"'


#ovs show with color
alias ovs='ovs-vsctl show |\
                sed -e "s_Bridge.*_\x1b[31m&\x1b[0m_" |\
                sed -e "s_Port.*_${esc}${lblue}&${esc}${default}_"'

alias ovs-ptb='ovs-vsctl port-to-br'
# Exclude rfc1918
function notrfc1918 () {
  grep -vE --color=never '(127|192\.168|10\.|172\.1[6789]\.|172\.2[0-9]\.|172\.3[01]\.*)' "$@"
}
# Include rfc1918
function rfc1918 () {
  grep -E --color=never '(127|192\.168|10\.|172\.1[6789]\.|172\.2[0-9]\.|172\.3[01]\.*)' "$@"
}

# Verify ssh connection and connection
function vssh() { until nc -vzw 2 $1 22; do sleep 2; done; ssh $1; }

# Color ls and format with details
alias ls='ls -AlhF --color=auto'

# Search hostsfile for keyword
alias host='getent hosts |grep '
