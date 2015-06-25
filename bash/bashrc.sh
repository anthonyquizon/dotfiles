
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

#Smart Sparrow plaform
export PLATFORM=$PROJECTS/platform/core

#GHC
export CABAL_PATH=$HOME/.cabal/bin

#JAVA
export JAVA_HOME=$(/usr/libexec/java_home)
export ANT_HOME=$VENDOR_LIB/apache-ant-1.9.4
export TOMCAT_HOME=$VENDOR_LIB/apache-tomcat-7.0.56
export PACKER_HOME=$VENDOR_LIB/packer-0.7.2
export FLEX_HOME=$VENDOR_LIB/adobe-flex-sdk-4.6

#PATH setup
export PATH=$PACKER_HOME:$VENDOR_PATH:$NPM_PACKAGES_PATH:$CABAL_PATH:$PATH

#Aliases
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
    if [ $# -eq 0 ]
    then
        i=8000
        while true; do
            http-server -a 127.0.0.1 -p $i && break;
            i=$((i+1));
        done
    else
        http-server -a 127.0.0.1 -p $1;
    fi
}

function _gitcommitwithbranch {
    git commit -a -m "$(echo $(git branch | grep '*' | sed 's/* //')$(echo " ")$(echo $*))"
}

function psetup {
    npm install;
    bower install;
}

function start {
    cd $PLATFORM && vagrant up && ./gradlew runServices $@
}

function stop {
    cd $PLATFORM && ./gradlew stopServices $@
}

function clean {
    cd $PLATFORM/testing/build && rm startInteractionProcessRunner.err
}

function build {
    cd $PLATFORM && ./gradlew setup && ./gradlew build
    # TODO setup database
}

function update {
    cd $PLATFORM && git pull
    build
}

function platform {
    case $1 in
        up)
            shift 1
            start $@
            ;;
        down)
            shift 1
            stop $@
            clean
            ;;
        clean)
            clean
            ;;
        update)
            update
            ;;
        reset)
            stop
            clean
            start
            ;;
    esac
}
