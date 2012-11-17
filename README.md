# dotfiles

Dotfiles for configuring a system.

Most of these will play nice with Linux and Mac OS X.

You can either download and simply copy them into your home directory, or clone the repository and create symbolic links to files in the repo.

## required

put stuff here

## vim plugins

My Vim plugins are managed by Vundle which is a Vim plugin itself. It's pretty awesome and very easy to use and makes getting new plugins a snap.

Some of these plugins require more setup outside of Vim but they're outlined below.

1. [gmarik/vundle](https://github.com/gmarik/vundle)
2. [tpope/vim-surround](https://github.com/tpope/vim-surround)
3. [greyblake/vim-preview](https://github.com/greyblake/vim-preview) requires a couple rubygems to operate
4. [Lokaltog/vim-powerline](https://github.com/Lokaltog/vim-powerline) needs a patched font. I included my favorite font that's pre-patched.
5. [tpope/vim-endwise](https://github.com/tpope/vim-endwise)
6. [kien/ctrlp.vim](https://github.com/kien/ctrlp.vim)

# sublime text 2 settings

## linux

    ln -s /<dotfiles>/.config/sublime-text-2 ~/.config/

## os x

    ln -s /<dotfiles>/.config/sublime-text-2 ~/Library/Application\ Support/Sublime\ Text\ 2

## TODO
* required section
* vim plugins section
* install script?
