export PYTHONSTARTUP=~/.pythonrc
export EDITOR=nvim
export FZF_DEFAULT_COMMAND="find -L * -path '*/\.*' -prune -o -type f -print -o -type l -print 2> /dev/null"
export PATH=/Library/Frameworks/Python.framework/Versions/3.3/bin:$PATH

export NODE_PATH=$HOME/.npm-packages/lib/node_modules:$NODE_PATH
export NPM_PACKAGES_PATH=$HOME/.npm-packages/bin
export CABAL_PATH=$HOME/.cabal/bin
export LOCAL_PATH=$HOME/.local/bin
export MONO_GAC_PREFIX="/usr/local"

export ANT_HOME=/usr/local/opt/ant
export MAVEN_HOME=/usr/local/opt/maven
export GRADLE_HOME=/usr/local/opt/gradle
export ANDROID_HOME=/usr/local/opt/android-sdk

export PATH=$NPM_PACKAGES_PATH:$PATH
export PATH=$CABAL_PATH:$PATH
export PATH=$LOCAL_PATH:$PATH
export PATH=$ANT_HOME/bin:$PATH
export PATH=$MAVEN_HOME/bin:$PATH
export PATH=$GRADLE_HOME/bin:$PATH
export PATH=$ANDROID_HOME/tools:$PATH
export PATH=$ANDROID_HOME/platform-tools:$PATH
export PATH=$ANDROID_HOME/build-tools/19.1.0:$PATH

export DEVELOPMENT=$HOME/Development


#Aliases
alias finder=open
alias l='ls'
alias sl='ls'
alias vim=nvim
alias lisp='rlwrap sbcl'
alias tmux="TERM=screen-256color-bce tmux"

alias gcm=_gitcommitwithbranch
alias gpo='git push origin '
alias gs='git status'
alias ga='git add'
alias gaa='git add .'
alias gc='git checkout'
alias gcb='git checkout -b'
alias cljslein='rlwrap lein'
alias smlr='rlwrap sml'
alias racketrl='rlwrap racket'
alias schemerl='rlwrap scheme'
alias ocamlrl='rlwrap ocaml'
alias prolog='swipl'
alias ctags="`brew --prefix`/bin/ctags"

export NODE_PATH=/usr/local/lib/jsctags/:$NODE_PATH
