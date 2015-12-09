
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

#CABAL
export CABAL_PATH=$HOME/.cabal/bin
export STACKAGE_PATH=$HOME/.local/bin
export STACKAGE_GHC_7_84_PATH=$HOME/.stack/programs/x86_64-osx/ghc-7.8.4/bin

#JAVA
export JAVA_HOME=$(/usr/libexec/java_home)
export ANT_HOME=$VENDOR_LIB/apache-ant-1.9.4
export TOMCAT_HOME=$VENDOR_LIB/apache-tomcat-7.0.56
export PACKER_HOME=$VENDOR_LIB/packer-0.7.2
export FLEX_HOME=$VENDOR_LIB/adobe-flex-sdk-4.6

#CLOJURE
export BOOT_JVM_OPTIONS="-client 
-XX:+TieredCompilation 
-XX:TieredStopAtLevel=1 
-Xmx2g 
-XX:+UseConcMarkSweepGC 
-XX:+CMSClassUnloadingEnabled 
-Xverify:none"

#PATH setup
export PATH=$PACKER_HOME:$VENDOR_PATH:$NPM_PACKAGES_PATH:$CABAL_PATH:$STACKAGE_PATH:$STACKAGE_GHC_7_84_PATH:$PATH
export EDITOR=nvim

#Aliases
alias blender=~/Applications/Blender.app/Contents/MacOS/blender
alias emacs=emacs-24.5
alias l='ls'
alias sl='ls'
alias vim=nvim

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
            http-server -p $i && break;
            i=$((i+1));
        done
    else
        http-server -p $1;
    fi
}


function project-setup {
    npm install;
    bower install;
}

function platform-start {
    cd $PLATFORM && vagrant up && ./gradlew runServices $@
}

function platform-stop {
    cd $PLATFORM && ./gradlew stopServices $@
}

function platform-clean {
    cd $PLATFORM/testing/build && rm startInteractionProcessRunner.err
}

function platform-build {
    cd $PLATFORM && ./gradlew setup && ./gradlew build
    # TODO setup database
}

function platform-update {
    cd $PLATFORM && git pull
    platform-build
}

function platform {
    case $1 in
        up)
            shift 1
            platform-start $@
            ;;
        down)
            shift 1
            platform-stop $@
            platform-clean
            ;;
        clean)
            platform-clean
            ;;
        update)
            platform-update
            ;;
        reset)
            platform-stop
            platform-clean
            platform-start
            ;;
    esac
}


function git-commit-with-branch {
    git commit -a -m "$(echo $(git branch | grep '*' | sed 's/* //')$(echo " ")$(echo $*))"
}

function git-clean-branches {
    git checkout master; git branch | sed -e '/master/d' -e 's/^/git branch -D /' | bash
}

function git-origin-branch {
    git fetch; git checkout -b $1 origin/$1 
}

function ipaddr {
    ifconfig | grep 'inet.*broadcast';
}

function include-if-exists () {
    [[ -f "$1" ]] && source "$1"
}
