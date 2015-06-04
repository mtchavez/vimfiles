#!/bin/sh
#
# install vundle
echo "----> Installing vundle..."
echo
if [ ! -d "$HOME/.vim/bundle" ]; then
    mkdir -p $HOME/.vim/bundle
fi
if [ ! -d "$HOME/.vim/bundle/Vundle.vim" ]; then
    git clone http://github.com/gmarik/Vundle.vim $HOME/.vim/bundle/Vundle.vim
else
    pushd $HOME/.vim/bundle/Vundle.vim
    git pull
    popd
fi
echo
echo "----> Done installing vundle."
echo

echo "----> Rsync vimfiles over"
echo
rsync --exclude ".git" --exclude ".gitignore" --exclude ".vim/bundle" --exclude "install.sh" --exclude "ycm-update.sh" --exclude "*.un~" \
    --exclude "README.md" --exclude ".DS_Store" -av --no-perms . ~

# Ensure bundle dir
mkdir -p $HOME/.vim/bundle

while getopts "u" option
do
    case "$option" in
    u)
        UPDATE=1
        ;;
    esac
done

if [ -n "$UPDATE" ]; then
    mvim -c PluginInstall! -c PluginClean! -c q -c q +qall
else
    echo
    echo "----> Skipping plugin update; pass -u if you want to update plugins"
fi

echo
echo "----> Installed successfully."
echo
