# dotfiles

Configured for Linux, and Mac OS X too.

Copy them into your home directory, or clone the repository and symlink to the repo files.

## vim

My Vim plugins are managed by Vundle which is a Vim plugin itself. It's pretty awesome, very easy to use, and makes getting new plugins a snap.

1. [gmarik/vundle](https://github.com/gmarik/vundle) --> [vundle setup](https://github.com/komidore64/dotfiles/blob/master/vimrc#L14-L38)
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

```bash
# linux
ln -s /<dotfiles>/config/sublime-text-2 ~/.config/

# mac os x
ln -s /<dotfiles>/config/sublime-text-2 ~/Library/Application\ Support/Sublime\ Text\ 2
```

### launch sublime text from the command line

for linux, use my handy script ```subl``` located in ```/bin```

```bash
# mac os x
ln -s "/Applications/Sublime Text 2.app/Contents/SharedSupport/bin/subl" ~/bin/subl
# then just run
subl
```

### caveats

be sure to ```git submodule update --init``` first thing

## TODO
* install script?
