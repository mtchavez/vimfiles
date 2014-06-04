#!/bin/sh

# install vundle
echo "Installing vundle..."
  if [ -d ".vim/bundle/vundle" ]; then
    pushd .vim/bundle/vundle
    git pull
    popd
  else
    git clone http://github.com/gmarik/vundle.git .vim/bundle/vundle
  fi
echo "Done installing vundle."

echo "Rsync vimfiles over"
rsync --exclude ".git" --exclude "install.sh" --exclude "LICENSE" --exclude "*.un~" \
    --exclude "README.md" --exclude ".DS_Store" -av --no-perms . ~

mvim -c BundleInstall! -c BundleClean! -c q -c q

echo
echo "Installed successfully."
echo
