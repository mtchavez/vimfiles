#!/bin/sh

echo "----> Rsync vimfiles over"
echo
rsync --exclude ".git" --exclude ".gitignore" --exclude ".vim/bundle" --exclude "install.sh" --exclude "ycm-update.sh" --exclude "*.un~" \
    --exclude "README.md" --exclude ".DS_Store" -av --no-perms . ~

# Ensure bundle dir
mkdir -p $HOME/.vim/bundle
# Ensure vimtags dir
mkdir -p $HOME/.vimtags

while getopts "u" option
do
    case "$option" in
    u)
        UPDATE=1
        ;;
    esac
done

if [ -n "$UPDATE" ]; then
    mvim -c PlugInstall -c PlugClean! -c q -c q +qall
    mvim -c GoInstallBinaries -c q +qall
else
    echo
    echo "----> Skipping plugin update; pass -u if you want to update plugins"
fi

echo
echo "----> Installed successfully."
echo
