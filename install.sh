#!/bin/sh

# install vundle
echo "Installing vundle..."
if [ ! -d "~/vim/bundle" ]; then
    mkdir -p ~/.vim/bundle
fi
if [ ! -d "~/.vim/bundle/Vundle.vim" ]; then
    git clone http://github.com/gmarik/Vundle.vim ~/.vim/bundle/Vundle.vim
else
    pushd ~/.vim/bundle/Vundle.vim
    git pull
    popd
fi
echo "Done installing vundle."

echo "Rsync vimfiles over"
rsync --exclude ".git" --exclude ".gitignore" --exclude "install.sh" --exclude "LICENSE" --exclude "*.un~" \
    --exclude "README.md" --exclude ".DS_Store" -av --no-perms . ~

while getopts "u" option
do
    case "$option" in
    u)
        UPDATE=1
        ;;
    esac
done

if [ -n "$UPDATE" ]; then
    mvim -c PluginInstall! -c PluginClean! -c q -c q
else
    echo "Skipping plugin update; pass -u if you want to update plugins"
fi

echo
echo "Installed successfully."
echo
