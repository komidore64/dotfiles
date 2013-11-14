" ~/.vimrc

" fancy vim
set nocompatible

set encoding=utf-8

" one place for vim swap files
set directory=~/.vim/

" load up plugins via vundle
if filereadable(expand("~/.vundle"))
  source ~/.vundle
endif

syntax enable
filetype plugin indent on

nmap ss :w<CR>

" remap <Leader>
map , <Nop>
let mapleader = ","

" quickly undo text highlighting
map <C-h> :nohl<CR>

" toggle pastemode
map <Leader>pt :set invpaste<CR>
" toggle line-numbers
map <Leader>n :set invnumber<CR>
" toggle relative line-numbers
map <Leader>rn :set invrelativenumber<CR>
" location-list next
map <Leader>ln :lnext<CR>
" location-list previous
map <Leader>lp :lprevious<CR>

" i always accidentally hit this somehow, so let's disable it
map K <Nop>

" refresh if file changes outside of vim
set autoread " i'm not sure this does what i think it does

set showcmd
set showmode
set modelines=5

" OPEN ALL THE TABS
set tabpagemax=9001

" highlight search real-time search
set hlsearch
set incsearch

" ignore case when searching
" unless you use a capital letter, then don't ignore case
set ignorecase
set smartcase

set ruler

" how to represent invisible characters
set listchars=tab:/*,eol:$,nbsp:%

" have some sensible defaults
set tabstop=4
set shiftwidth=4
set expandtab
set smarttab

" vim command-line tab-completion
set wildmode=list:longest

" remove trailing whitespace
autocmd BufWritePre * :%s/\s\+$//e

autocmd BufRead *.md set ft=markdown

" stop vim from restoring screen contents on exit. it looks badass
set t_ti= t_te=

" disable netrw --------------
let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1
" ----------------------------

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
highlight Pmenu term=reverse ctermbg=darkgrey ctermfg=white
highlight PmenuSel cterm=bold term=reverse ctermbg=lightgrey ctermfg=black
" ----------------------------

" load plugin settings if ~/.vundle is found
if filereadable(expand("~/.vundle"))

    " powerline ------------------
    set noshowmode
    set laststatus=2
    let g:Powerline_symbols = 'compatible'
    " ----------------------------

    " ctrlp ----------------------
    let g:ctrlp_open_multiple_files = 'tj' " open multiple files in additional tabs
    let g:ctrlp_show_hidden = 1 " include dotfiles and dotdirs in ctrlp indexing

    " remap <cr> to open file in a new tab
    let g:ctrlp_prompt_mappings = {
        \ 'AcceptSelection("e")': ['<c-t>'],
        \ 'AcceptSelection("t")': ['<cr>', '<2-LeftMouse>'],
    \ }
    " ----------------------------

    " tagbar ---------------------
    map <Leader>tt :TagbarToggle<CR>
    let g:tagbar_autofocus = 1
    let g:tagbar_autoclose = 1
    " ----------------------------

    " nyancat --------------------
    map <Leader>N :Nyancat2<CR>
    " ----------------------------

    " gundo ----------------------
    map <Leader>gt :GundoToggle<CR>
    " ----------------------------

    " vimux ----------------------
    map <Leader>vc :VimuxPromptCommand<CR>
    map <Leader>vl :VimuxRunLastCommand<CR>
    map <Leader>vq :VimuxCloseRunner<CR>
    " ----------------------------

    " vim-json -------------------
    let g:vim_json_syntax_conceal = 0
    " ----------------------------

    " syntastic ------------------
    let g:syntastic_ruby_checkers = ['mri', 'rubocop']
    map <Leader>sr :SyntasticReset<CR>
    map <Leader>se :Errors<CR>
    " ----------------------------

    " scratch.vim ----------------
    let g:scratch_autohide = 0
    " ----------------------------

endif
