set nocompatible " fancy vim

set directory=~/.vim/ " one place for vim swap files

" ----------------------------
" ----------------------------
"
" plugins
"
"

" pre vundler setup ----------
filetype off

set runtimepath+=~/.vim/bundle/vundle
call vundle#rc()
" ----------------------------

" plugins (via vundler) ------
Bundle 'gmarik/vundle'
Bundle 'tpope/vim-surround'
Bundle 'greyblake/vim-preview'
Bundle 'aert/vim-powerline'
Bundle 'tpope/vim-endwise'
Bundle 'kien/ctrlp.vim'
Bundle 'tpope/vim-fugitive'
Bundle 'majutsushi/tagbar'
Bundle 'koron/nyancat-vim'
Bundle 'vim-scripts/AutoComplPop'
Bundle 'nother/vim-prose'
Bundle 'sjl/gundo.vim'
" ----------------------------

" post vundler setup ---------
syntax enable
filetype plugin indent on
" ----------------------------

" powerline ------------------
set noshowmode
set laststatus=2
let g:Powerline_symbols = 'compatible'
set encoding=utf-8
" ----------------------------

" ctrlp ----------------------
let g:ctrlp_open_multiple_files = 'tj' " open multiple files in additional tabs
let g:ctrlp_show_hidden = 1 " include dotfiles and dotdirs in ctrlp indexing

let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("e")': ['<c-t>'],
    \ 'AcceptSelection("t")': ['<cr>', '<2-LeftMouse>'],
\ } " remap <cr> to open file in a new tab
" ----------------------------

" tagbar ---------------------
map <Leader>tb :TagbarToggle<CR>
let g:tagbar_autofocus = 1
let g:tagbar_autoclose = 1
" ----------------------------

" nyancat --------------------
nmap <Leader>N :Nyancat2<CR>
" ----------------------------

" vim-prose ------------------
nmap <Leader>vp :VimProseEnable<CR>
" ----------------------------

" gundo ----------------------
nmap <Leader>gt :GundoToggle<CR>
" ----------------------------


" ----------------------------
" ----------------------------
"
" vim settings
"
"

" quick hack to open help pages in a new tab as opposed to a split
:cabbrev help tab help

set autoread " refresh if file changes outside of vim

set showcmd
set modelines=5

set tabpagemax=100 " OPEN ALL THE TABS

set hlsearch " highlight search
set incsearch " real-time search

set ignorecase " ignore case when searching
set smartcase  " unless you use a capital letter, then don't ignore case

set ruler

set listchars=tab:/*,eol:$,nbsp:% " how to represent invisible characters

" have some defaults
set tabstop=4
set shiftwidth=4
set expandtab
set smarttab

set wildmode=list:longest " vim command-line tab-completion

autocmd BufWritePre * :%s/\s\+$//e "remove trailing whitespace
set t_ti= t_te= " stop vim from restoring screen contents on exit. it looks cooler.

" netrw ----------------------
let g:netrw_home = expand("~/.vim/")
" ----------------------------

" shortcuts
map <C-h> :nohl<CR>

" vimdiff --------------------
highlight DiffAdd term=reverse cterm=bold ctermbg=green ctermfg=white
highlight DiffChange term=reverse cterm=bold ctermbg=cyan ctermfg=black
highlight DiffText term=reverse cterm=bold ctermbg=gray ctermfg=black
highlight DiffDelete term=reverse cterm=bold ctermbg=red ctermfg=black
" ----------------------------

" spell-checking -------------
highlight SpellCap cterm=undercurl ctermbg=cyan ctermfg=black
highlight SpellBad cterm=undercurl ctermbg=red ctermfg=black
highlight SpellRare cterm=undercurl ctermbg=cyan ctermfg=black
" ----------------------------

" pop-up menu ----------------
highlight Pmenu term=reverse ctermbg=lightgrey ctermfg=black
highlight PmenuSel term=reverse ctermbg=cyan ctermfg=black
" ----------------------------

