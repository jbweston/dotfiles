#!/bin/bash
# -*- coding: utf-8 -*-
# create symlinks to all the dotfiles

IGNORE="README.rst setup.sh diff-dotfiles.sh scripts config"
SAFE=0  # set to 1 to simulate deletion

function ask {
    local cont
    echo -n "$1"
    read -p " (y/n)" cont
    if [[ $cont =~ [Yy] ]]
    then
        return 0  # 0 == true for bash
    else
        return 1
    fi
}

function remove {
    [[ $SAFE == 1 ]] && echo "removing $1" || rm -rf $1
}

function link {
    local from_file="$1"
    local to_file="$2"
    if [[ -L $to_file && $(readlink -f $from_file) == $from_file ]] ; then
        return 0
    elif [[ -e $to_file ]] ; then
        ask "$to_file exists, remove $to_file and link $from_file instead?"
        [[ $? == 0 ]] && remove $to_file || return 0
    fi
    echo -n "linking $from_file --> $to_file ... "
    ln -s $from_file $to_file 2>/dev/null
    [[ $? == 0 ]] && echo 'OK' || echo 'FAIL'
}


for file in $(ls $(for f in $IGNORE; do echo "-I $f" ; done))
do
    to_file="$HOME/.$file"
    from_file="$(pwd)/$file"
    [[ "$file" =~ "$IGNORE" ]] && continue
    link "$from_file" "$to_file"
done

to_dir=$HOME/.config
[[ -d "$to_dir" ]] || mkdir -p "$to_dir"
for file in $(ls config)
do
    to_file=$to_dir/$file
    from_file=$(pwd)/config/$file
    link "$from_file" "$to_file"
done

to_dir=$HOME/.local/bin
[[ -d "$to_dir" ]] || mkdir -p "$to_dir"
for file in $(ls scripts)
do
    to_file=$to_dir/$file
    from_file=$(pwd)/scripts/$file
    link "$from_file" "$to_file"
done
