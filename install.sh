#! /bin/bash

DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source_dir=home
target_dir=~

find $source_dir -type f | while read file; do 
    source_file=${file/$source_dir\//$(pwd)\/$source_dir/};
    target_file=${file/$source_dir\//$target_dir/};

    mkdir -p "`dirname $target_file`"
    rm $target_file 2>/dev/null

    echo "linking" $source_file "to" $target_file;

    ln -s $source_file $target_file 2>/dev/null
done

echo $DOTFILES_DIR

if [[ $@ = "all" ]]; then
    . "$DOTFILES_DIR/brew-cask.sh"
fi
