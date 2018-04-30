export PYTHON2_PATH=$(python3 -m site --user-base)/bin
export PYTHON3_PATH=$(python3 -m site --user-base)/bin
export PYTHONSTARTUP=~/.pythonrc
export EDITOR=nvim
export PATH=$PATH:/Users/anthonyquizon/.cargo/bin:/Users/anthonyquizon/.local/bin:/usr/local/bin:/usr/local/sbin:$PYTHON3_PATH:$PYTHON2_PATH
export DEVELOPMENT=$HOME/Development

#Aliases
alias finder=open
alias l='ls'
alias sl='ls'
alias vim=nvim
alias vi=nvim
alias v=nvim
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

alias chrome="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome"
alias firefox="/Applications/Firefox.app/Contents/MacOS/firefox"

