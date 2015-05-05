
DEVELOPMENT=$HOME/Development
PROJECTS=$DEVELOPMENT/Projects

VENDOR=$DEVELOPMENT/vendor
VENDOR_PATH=$VENDOR/bin
VENDOR_LIB=$VENDOR/lib

#python
export PYTHONSTARTUP=~/.pythonrc

#NPM
NPM_PACKAGES=$HOME/.npm-packages
export NODE_PATH=$NPM_PACKAGES/lib/node_modules:$NODE_PATH
export NPM_PACKAGES_PATH=$NPM_PACKAGES/bin

#scripts
SCRIPTS_PATH=$HOME/scripts

#Smart Sparrow plaform
export PLATFORM=$PROJECTS/platform/core

#JAVA
export JAVA_HOME=$(/usr/libexec/java_home)
export ANT_HOME=$VENDOR_LIB/apache-ant-1.9.4
export TOMCAT_HOME=$VENDOR_LIB/apache-tomcat-7.0.56
export PACKER_HOME=$VENDOR_LIB/packer-0.7.2
export FLEX_HOME=$VENDOR_LIB/adobe-flex-sdk-4.6

#PATH setup
export PATH=$PACKER_HOME:$SCRIPTS_PATH:$VENDOR_PATH:$NPM_PACKAGES_PATH:$PATH

#Aliases
alias serve='http-server -a localhost -p'
alias emacs=emacs-24.5
alias l='ls'
alias sl='ls'

alias gcm=_gitcommitwithbranch
alias gpo='git push origin '
alias gs='git status'
alias ga='git add'
alias gaa='git add .'
alias gc='git checkout'
alias gcb='git checkout -b'

function mkcd {
    mkdir "$1" && cd "$1"
}

function serve {
    i=8001
    while true; do
        http-server -a 127.0.0.1 -p $i && break;
        i=$((i+1));
    done
}

function _gitcommitwithbranch {
    git commit -a -m "$(echo $(git branch | grep '*' | sed 's/* //')$(echo " ")$(echo $*))"
}

function psetup {
    npm install;
    bower install;
}
