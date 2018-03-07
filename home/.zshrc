
export ZSH=~/.oh-my-zsh
ZSH_THEME="robbyrussell"
plugins=(git)

source $ZSH/oh-my-zsh.sh
if [ -f ~/.bashrc ]; then
   source ~/.bashrc
fi

