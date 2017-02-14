export PYTHONSTARTUP=~/.pythonrc
export NODE_PATH=$HOME/.npm-packages/lib/node_modules:$NODE_PATH
export NPM_PACKAGES_PATH=$HOME/.npm-packages/bin
export CABAL_PATH=$HOME/.cabal/bin
export LOCAL_PATH=$HOME/.local/bin
export EDITOR=nvim
export FZF_DEFAULT_COMMAND="find -L * -path '*/\.*' -prune -o -type f -print -o -type l -print 2> /dev/null"
export PATH=$NPM_PACKAGES_PATH:$CABAL_PATH:$LOCAL_PATH:$ANDROID_HOME:$PATH

#Aliases
alias blender=~/Applications/Blender.app/Contents/MacOS/blender
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
alias racketr='rlwrap racket'
alias schemer='rlwrap scheme'
alias prolog='swipl'
alias ctags="`brew --prefix`/bin/ctags"

export NODE_PATH=/usr/local/lib/jsctags/:$NODE_PATH
