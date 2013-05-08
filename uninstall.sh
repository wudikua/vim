#!/usr/bin/env sh

endpath="$HOME/VIM/spf13-vim/.vim"

warn() {
    echo "$1" >&2
}

die() {
    warn "$1"
    exit 1
}

rm $HOME/.vimrc
rm $HOME/.vimrc.local
rm $HOME/.vimrc.bundles
rm $HOME/.vimrc.bundles.local
rm $HOME/.vim
