# dotfiles

Configured for Linux, and Mac OS X too. The only thing I've noticed that doesn't work in OS X is vim-preview (because OS X's vim isn't compiled with a Ruby interpreter). Vim-preview still installs fine, you just can't use it.

Copy them into your home directory, or clone the repository and symlink to repo files.

## vim

My Vim plugins are managed by Vundle which is a Vim plugin itself. It's pretty awesome and very easy to use and makes getting new plugins a snap.

Some of these plugins require more setup outside of Vim but they're outlined below.

1. [gmarik/vundle](https://github.com/gmarik/vundle)
2. [tpope/vim-surround](https://github.com/tpope/vim-surround)
3. [greyblake/vim-preview](https://github.com/greyblake/vim-preview) requires a couple rubygems to operate. sadly does not work in os x.
4. [aert/vim-powerline](https://github.com/aert/vim-powerline)
5. [tpope/vim-endwise](https://github.com/tpope/vim-endwise)
6. [kien/ctrlp.vim](https://github.com/kien/ctrlp.vim)
7. [tpope/vim-fugitive](https://github.com/tpope/vim-fugitive)
8. [majutsushi/tagbar](https://github.com/majutsushi/tagbar)
9. [vim-scripts/AutoComplPop](https://github.com/vim-scripts/AutoComplPop)
10. [nother/vim-prose](https://github.com/nother/vim-prose)

## sublime text 2

### settings

#### linux

    ln -s /<dotfiles>/config/sublime-text-2 ~/.config/

#### os x

    ln -s /<dotfiles>/config/sublime-text-2 ~/Library/Application\ Support/Sublime\ Text\ 2

### executable

#### linux

use my handy script ```subl``` located in ```/bin```

#### os x

    ln -s "/Applications/Sublime Text 2.app/Contents/SharedSupport/bin/subl" ~/bin/subl

## TODO
* install script?
