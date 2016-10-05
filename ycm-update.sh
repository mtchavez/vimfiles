#!/bin/sh
#
# Install/Update YCM
#

YCM_DIR=$HOME/.vim/bundle/YouCompleteMe
YCM_OPTS="--clang-completer --gocode-completer --racer-completer --tern-completer"

if [ ! -d $YCM_DIR ]
then
    echo "Please bundle YouCompleteMe before attempting to install/update"
    exit 0
fi

while getopts "u" option
do
    case "$option" in
    u)
        UPDATE=1
        ;;
    esac
done

function update_ycm() {
    python ./install.py $YCM_OPTS
    if [ $? == 0 ]; then
        touch $HOME/.ycm_installed
    fi
}

pushd $YCM_DIR > /dev/null
    if [ -n "$UPDATE" ] || [ ! -f $HOME/.ycm_installed ]; then
        update_ycm
    else
        echo "----> Skipping YouCompleteMe update; pass -u if you want to re-install/update"
    fi
popd
