# dotfiles

Configured for Linux, and Mac OS X too. The only thing I've noticed that doesn't work in OS X is vim-preview (because OS X's vim isn't compiled with a Ruby interpreter). Vim-preview still installs fine, you just can't use it.

Copy them into your home directory, or clone the repository and symlink to repo files.

## vim

My Vim plugins are managed by Vundle which is a Vim plugin itself. It's pretty awesome and very easy to use and makes getting new plugins a snap.

Some of these plugins require more setup outside of Vim but they're outlined below.

1. [gmarik/vundle](https://github.com/gmarik/vundle)
2. [tpope/vim-surround](https://github.com/tpope/vim-surround)
3. [aert/vim-powerline](https://github.com/aert/vim-powerline)
4. [tpope/vim-endwise](https://github.com/tpope/vim-endwise)
5. [kien/ctrlp.vim](https://github.com/kien/ctrlp.vim)
6. [tpope/vim-fugitive](https://github.com/tpope/vim-fugitive)
7. [majutsushi/tagbar](https://github.com/majutsushi/tagbar)
8. [vim-scripts/AutoComplPop](https://github.com/vim-scripts/AutoComplPop)
9. [nother/vim-prose](https://github.com/nother/vim-prose)
10. [sjl/gundo.vim](https://github.com/sjl/gundo.vim) - doesn't work in OSX's vim because it doesn't have python support

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
