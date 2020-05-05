alias cls='clear'
alias cd..="cd .."
alias ..="cd .."
alias ls='ls $LS_OPTIONS -hF'
alias ll='ls $LS_OPTIONS -lAhF'
alias hosts='sudo $EDITOR /etc/hosts'
alias vtop='vtop --theme monokai'

# mv, rm, cp
alias mv='mv -v'
# alias rm='rm -i -v'
alias cp='cp -v'
function mkcd(){ 
    mkdir -p $1 
    cd $1 
}

# Git
alias git=hub
alias g="git"
alias gc='git commit -v'
alias git-undopush='git push -f origin HEAD^:master'
alias git-stashpopforce='git stash show -p | git apply && git stash drop'
alias yolo='git push --force'

# using: git-reset-author old-mail@mail.com
git-reset-author() {
    git filter-branch --env-filter '
    OLD_EMAIL="alexandre.laurans14@gmail.com"
    CORRECT_NAME="Alexandre LAURANS"
    CORRECT_EMAIL="ancitik@protonmail.com"
    if [ "$GIT_COMMITTER_EMAIL" = "$OLD_EMAIL" ]
    then
        export GIT_COMMITTER_NAME="$CORRECT_NAME"
        export GIT_COMMITTER_EMAIL="$CORRECT_EMAIL"
    fi
    if [ "$GIT_AUTHOR_EMAIL" = "$OLD_EMAIL" ]
    then
        export GIT_AUTHOR_NAME="$CORRECT_NAME"
        export GIT_AUTHOR_EMAIL="$CORRECT_EMAIL"
    fi
    ' --tag-name-filter cat -- --branches --tags
}

git-standup() {
    AUTHOR=${AUTHOR:="`git config user.name`"}

    since=yesterday
    if [[ $(date +%u) == 1 ]] ; then
        since="2 days ago"
    fi

    git log --color --all --graph --since "$since" --author="$AUTHOR" --pretty=format:'%Cred %C(bold blue)<%an>%Creset -%C(yellow)%d%Creset %Cgreen(%cr)%Creset %B'
}

alias glols='git log --graph --pretty='\''%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'\'' --stat'
alias glol='git log --graph --pretty='\''%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'\'
#                                              │                  │         │          │                  └─ committer name
#                                              │                  │         │          └─ date (relative)
#                                              │                  │         └─ message
#                                              │                  └─ decorations (branch, heads or tags)
#                                              └─ hash (abbreviated)


# Personal projects folders
alias cdlab='cd $HOME/Documents/Lab'
alias cdbl='cd $HOME/Documents/Lab/Ippon/berger-levrault/'

# RAM
alias ram='ps aux | awk '"'"'{print $6/1024 " MB\t\t" $11}'"'"' | sort -rn | head -25'

ds_fucking_store() {
    sudo find / -name ".DS_Store" -depth -exec rm {} \;
}


# HTTP/REST API
jsonapi() {
    http "$@" Accept:application/vnd.api+json Content-Type:application/vnd.api+json
}

pyserver() {
    if [[ $OSTYPE == darwin* ]] ; then
        /usr/bin/open -a "/Applications/Google Chrome.app" 'http://127.0.0.1:8000/'
    else
        google-chrome "http://0.0.0.0:8000/"
    fi
    python -m SimpleHTTPServer 8000
}

# Greenkeeper
alias greenkeeper-clean="git fetch -p && git branch --remote | fgrep greenkeeper | sed 's/^.\{9\}//' | xargs git push origin --delete"

# WTF 😇
alias russian-roulette='[ $(( $RANDOM % 6 )) == 0 ] && rm -rf / || echo "You live"'

#################
#    PROXY      #
#################
enableProxy() {
    export http_proxy=$HTTPPROXY
    export https_proxy=$HTTPSPROXY
    export HTTP_PROXY=$HTTPPROXY
    export HTTPS_PROXY=$HTTPSPROXY

    npm config set proxy $HTTPPROXY
    npm config set https-proxy $HTTPPROXY
}

disableProxy() {
    unset http_proxy
    unset https_proxy
    unset HTTP_PROXY
    unset HTTPS_PROXY

    npm config delete proxy
    npm config delete https-proxy
}

# WTF Composer
disableHttpsProxyOnly() {
    export http_proxy=$URLPROXY
    export HTTP_PROXY=$URLPROXY
    export HTTP_PROXY REQUEST_FULLURI=true

    # http instead
    export https_proxy=$URLPROXY
    export HTTPS_PROXY=$URLPROXY
    export HTTPS_PROXY_REQUEST_FULLURI=false
}

# Show/hide hidden files (starting with a `.`)
alias showFiles='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'
alias hideFiles='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'

# change mac addresss and get unlimitted wifi in airport
function airport() {
  local mac=$(openssl rand -hex 6 | sed 's/\(..\)/\1:/g; s/.$//')
  sudo ifconfig en0 ether $mac
  sudo ifconfig en0 down
  sudo ifconfig en0 up
  echo "Your new physical address is $mac"
}
