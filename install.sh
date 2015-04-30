#! /bin/bash

backup_dir=~/.dotfiles.bak
source_dir=$(pwd)
target_dir=~

dotfiles=(
    bash/bashrc.sh .bashrc
    bash/bash_profile.sh .bash_profile
    emacs/main.el .emacs
    git/gitconfig .gitconfig
    git/gitignore .gitignore
    lein/profiles.clj .lein/profiles.clj 
    node/npmrc.sh .npmrc
    python/pythonrc .pythonrc
    vim/vimrc.vim .vimrc
    zsh/zshrc.sh .zshrc
)

mkdir -p $backup_dir

for ((i=0; i<${#dotfiles[@]}; i+=2)); do
    source=${dotfiles[i]}
    target=${dotfiles[i+1]}
    dir=$(dirname $target)
    
    echo "linking $target"

    cp -R $source $backup_dir/$target 2>/dev/null

    if [[ $dir != "." ]]; then
        mkdir -p $target_dir/$dir
    fi

    rm $target_dir/$target 2>/dev/null
    ln -s $source_dir/$source $target_dir/$target 
done