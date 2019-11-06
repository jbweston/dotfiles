#!/bin/bash
# -*- coding: utf-8 -*-
# print diffs of existing dotfiles with the ones in this repository

IGNORE="README.rst setup.sh diff-dotfiles.sh"

function print_diff {
    local file=$1
    if [ -e ~/.$file ] ; then
        DIFF=$(diff $file ~/.$file)
        if [[ $? == 0 ]] ; then
            echo "$file is identical to $HOME/.$file"
        else
            echo
            echo "=============== diff for .$file ================"
            echo "$DIFF"
            echo "================================================"
            echo
        fi
    else
        echo ".$file does not exist in your home directory"
    fi
}

if [[ -z "$@" ]] ; then
    for file in $(ls $(for f in $IGNORE; do echo "-I $f" ; done))
    do
        print_diff $file
    done
else
    for file in "$@"
    do
        print_diff $file
    done
fi
