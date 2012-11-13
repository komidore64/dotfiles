set nocompatible

" vundler for vim plugins -----
filetype off

set rtp+=~/.vim/bundle/vundle
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'tpope/vim-surround'
Bundle 'greyblake/vim-preview'
Bundle 'Lokaltog/vim-powerline'
Bundle 'tpope/vim-endwise'
Bundle 'kien/ctrlp.vim'
" -----------------------------

syntax enable
filetype plugin indent on

" Powerline -------------------
set noshowmode
set laststatus=2
let g:Powerline_symbols = 'fancy'
set encoding=utf-8
" -----------------------------

" ctrlp -----------------------
let g:ctrlp_open_multiple_files = 'tjr'
let g:ctrlp_show_hidden = 1
" -----------------------------

set showcmd

set hlsearch
set incsearch

set ignorecase
set smartcase

set ruler

set tabstop=4
set shiftwidth=4
set expandtab

set wildmode=list:longest

autocmd BufWritePre * :%s/\s\+$//e "remove trailing whitespace

" :REV to revert file to state of the most recent save
command REV earlier 1f

" disable netrw ---------------
let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1
" -----------------------------
