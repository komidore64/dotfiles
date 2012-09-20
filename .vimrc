set nocompatible

filetype plugin on
filetype plugin indent on
syntax enable

set showmode
set showcmd

set hlsearch
set incsearch

set ignorecase
set smartcase

set ruler

set tabstop=4
set shiftwidth=4
set expandtab

autocmd BufWritePre * :%s/\s\+$//e "remove trailing whitespace
