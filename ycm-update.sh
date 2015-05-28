#!/bin/sh
#
# Install/Update YCM
#

YCM_DIR=$HOME/.vim/bundle/YouCompleteMe
YCM_OPTS="--clang-completer --gocode-completer"

if [ ! -d $YCM_DIR ]
then
    echo "Please bundle YouCompleteMe before attempting to install/update"
    exit 0
fi

pushd $YCM_DIR > /dev/null
    if [ ! -f $HOME/.ycm_installed ]; then
        ./install.sh $YCM_OPTS
        if [ $? == 0 ]; then
            touch $HOME/.ycm_installed
        fi
    fi
popd
