set nocompatible
set dir=~/.vim/ " set one for place for vim swap files

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
let g:Powerline_symbols = 'fancy' " show fancy symbols (requires patched font)
set encoding=utf-8
" -----------------------------

" ctrlp -----------------------
let g:ctrlp_open_multiple_files = 'tj' " open multiple files in additional tabs
let g:ctrlp_show_hidden = 1 " include dotfiles and dotdirs in ctrlp indexing

let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("e")': ['<c-t>'],
    \ 'AcceptSelection("t")': ['<cr>', '<2-LeftMouse>'],
\ } " remap <cr> to open file in a new tab
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

set t_ti= t_te= " stop vim from restoring screen contents on exit. it looks cooler.

autocmd BufWritePre * :%s/\s\+$//e "remove trailing whitespace

" :REV to "revert" file to state of the most recent save
command REV earlier 1f

" disable netrw ---------------
let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1
" -----------------------------
