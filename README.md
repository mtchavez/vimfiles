# About

Install my vim files and environment. Mostly taken from https://github.com/geetarista/vimfiles

## Requirements

* MacVim with Lua JIT enabled
* [You Complete Me](https://github.com/Valloric/YouCompleteMe) setup
* [Patched fonts for powerline](https://github.com/Lokaltog/powerline-fonts)

## Installation

WARNING: Existing files are deleted during installation. Use at your own risk.

To use, just run the following commands:

    git clone git://github.com/mtchavez/vimfiles.git && cd vimfiles

    ./install.sh

This will create a symbolic link to each of these files in your home directory.

## Bundles

To update plugins, just run :BundleInstall within vim.
