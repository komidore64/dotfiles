# dotfiles

Configured for Linux, and Mac OS X too. The only thing I've noticed that doesn't work in OS X is vim-preview (because OS X's vim isn't compiled with a Ruby interpreter). Vim-preview still installs fine, you just can't use it.

Copy them into your home directory, or clone the repository and symlink to repo files.

## vim

My Vim plugins are managed by Vundle which is a Vim plugin itself. It's pretty awesome and very easy to use and makes getting new plugins a snap.

Some of these plugins require more setup outside of Vim but they're outlined below.

1. [gmarik/vundle](https://github.com/gmarik/vundle)
2. [tpope/vim-surround](https://github.com/tpope/vim-surround)
3. [greyblake/vim-preview](https://github.com/greyblake/vim-preview) requires a couple rubygems to operate.
4. [Lokaltog/vim-powerline](https://github.com/Lokaltog/vim-powerline) needs a patched font. I included my favorite font already pre-patched. Install the patched font and use it in your terminal.
5. [tpope/vim-endwise](https://github.com/tpope/vim-endwise)
6. [kien/ctrlp.vim](https://github.com/kien/ctrlp.vim)
7. [tpope/vim-fugitive](https://github.com/tpope/vim-fugitive)

## sublime text 2 settings

### linux

    ln -s /<dotfiles>/config/sublime-text-2 ~/.config/

### os x

    ln -s /<dotfiles>/config/sublime-text-2 ~/Library/Application\ Support/Sublime\ Text\ 2

## TODO
* install script?
