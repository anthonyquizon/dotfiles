export ZSH=~/.oh-my-zsh
ZSH_THEME="robbyrussell"
plugins=(git)

export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
source $ZSH/oh-my-zsh.sh
if [ -f ~/.bashrc ]; then
   source ~/.bashrc
fi

export NVM_DIR="/Users/anthonyquizon/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

# OPAM configuration
. /Users/anthonyquizon/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true
