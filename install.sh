#!/usr/bin/env sh

endpath="$HOME/MyVim"
spf13vim="$endpath/spf13-vim"

warn() {
    echo "$1" >&2
}

die() {
    warn "$1"
    exit 1
}

lnif() {
    if [ ! -e $2 ] ; then
        ln -s $1 $2
    fi
    if [ -L $2 ] ; then
        ln -sf $1 $2
    fi
}

if [ ! -e $sp13vim/.git ]; then
    echo "cloning spf13-vim"
    cd $endpath && git submodule init && git submodule update
fi


echo "setting up symlinks"
lnif $spf13vim/.vimrc $HOME/.vimrc
lnif $endpath/.vimrc.local $HOME/.vimrc.local
lnif $spf13vim/.vimrc.bundles $HOME/.vimrc.bundles
lnif $endpath/.vimrc.bundles.local $HOME/.vimrc.bundles.local
lnif $spf13vim/.vim $HOME/.vim
if [ ! -d $spf13vim/.vim/bundle ]; then
    mkdir -p $spf13vim/.vim/bundle
fi

if [ ! -e $HOME/.vim/bundle/vundle ]; then
    echo "Installing Vundle"
    git clone http://github.com/gmarik/vundle.git $HOME/.vim/bundle/vundle
fi

echo "update/install plugins using Vundle"
system_shell=$SHELL
export SHELL="/bin/sh"
vim -u $spf13vim/.vimrc.bundles +BundleInstall! +BundleClean +qall
export SHELL=$system_shell
