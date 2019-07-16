" ~/.vimrc
"
" The ordering for a lot of these settings doesn't make a lot of sense, but
" I've discovered that if I start moving stuff around things can get out of
" whack.

" fancy vim
set nocompatible
set updatetime=1000

" color-y displayish settings
colorscheme default
set t_Co=256
set background=light

" one place for vim swap files
set directory=~/.vim/

" load up plugins via vundle
if filereadable(expand("~/.vundle"))
    source ~/.vundle
endif

syntax enable
filetype plugin indent on

" remap <Leader> to spacebar
let mapleader = " "
set timeout timeoutlen=500

" undo text highlighting
nnoremap <Leader><Space> :nohl<CR>

" toggle pastemode
nnoremap <Leader>p :set invpaste<CR>

" toggle spell checking
nnoremap <Leader>s :set invspell<CR>
set spelllang=en_us

" toggle list characters
nnoremap <Leader>l :set invlist<CR>

" toggle line numbers
nnoremap <Leader>n :set invnumber<CR>

" highlight search and real-time search
set hlsearch
set incsearch

" ignore case when searching
" unless you use a capital letter, then don't ignore case
set ignorecase
set smartcase

" have some sensible defaults
set encoding=utf-8
set tabstop=4
set shiftwidth=0
set expandtab
set smarttab
set smartindent
set showcmd
set showmode
set modelines=5
set showmatch
set matchtime=5
set scrolloff=3
set ruler
set tabpagemax=9999

" We have to have a winheight bigger than we want to set winminheight. But if
" we set winheight to be huge before winminheight, the winminheight set will
" fail. -- Gary Bernhardt
set winwidth=120
set winheight=10
set winminheight=10
set winheight=999

" vim command-line tab-completion
set wildmenu
set wildmode=list:longest
set completeopt=longest,menuone

" remove trailing whitespace
augroup whitespace
    autocmd!
    autocmd BufWritePre * :%s/\s\+$//e
augroup END

" set filetypes
augroup markdown_filetype
    autocmd!
    autocmd BufRead,BufNewFile *.md set ft=markdown
augroup END

augroup yaml_ansible_filetype
    autocmd!
    autocmd BufRead,BufNewFile */playbooks/**/*.y*ml,*/roles/**/*.y*ml set ft=yaml.ansible
augroup END

" mkdir on parent directory[s] if they don't exist when saving a file
augroup BWCCreateDir
    autocmd!
    autocmd BufWritePre * :call s:MkNonExDir(expand('<afile>'), +expand('<abuf>'))
augroup END

" disable netrw --------------
let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1
" ----------------------------

" vimdiff --------------------
highlight DiffAdd term=reverse cterm=bold ctermbg=green ctermfg=black
highlight DiffChange term=reverse cterm=bold ctermbg=cyan ctermfg=black
highlight DiffText term=reverse cterm=bold ctermbg=grey ctermfg=black
highlight DiffDelete term=reverse cterm=bold ctermbg=red ctermfg=black
" ----------------------------

" spell-checking -------------
highlight SpellCap cterm=undercurl ctermbg=grey ctermfg=black
highlight SpellBad cterm=undercurl ctermbg=red ctermfg=black
highlight SpellRare cterm=undercurl ctermbg=cyan ctermfg=black
" ----------------------------

" pop-up menu ----------------
highlight Pmenu term=reverse ctermbg=darkgrey ctermfg=white
highlight PmenuSel cterm=bold term=reverse ctermbg=lightgrey ctermfg=black
" ----------------------------

" cursorline -----------------
set cursorline
highlight clear CursorLine
highlight CursorLineNr ctermfg=white
" ----------------------------

" line numbers ---------------
set number
highlight clear LineNr
highlight LineNr ctermfg=darkgrey
" ----------------------------

" list characters ------------
set listchars=tab:→\ ,extends:→,precedes:←,trail:·
set list

highlight SpecialKey ctermfg=yellow
" ----------------------------

" folding --------------------
set nofoldenable
set foldcolumn=0

highlight clear FoldColumn
highlight FoldColumn ctermfg=darkblue

augroup folding
    autocmd!
    autocmd CursorHold * :call SetFoldColumn()
augroup END
" ----------------------------

" load plugin settings if ~/.vundle is found
if filereadable(expand("~/.vundle"))

    " vim-airline ----------------
    set noshowmode
    set laststatus=2
    let g:airline_left_sep=''
    let g:airline_right_sep=''
    " ----------------------------

    " vim-json -------------------
    let g:vim_json_syntax_conceal = 0
    " ----------------------------

    " vim-gitgutter --------------
    highlight clear SignColumn
    nnoremap <Leader>gg :GitGutterToggle<CR>
    " ----------------------------

    " fzf ------------------------
    let g:fzf_action = {
        \ 'enter': 'tab split',
        \ 'ctrl-t': 'tab split',
        \ 'ctrl-x': 'split',
        \ 'ctrl-v': 'vsplit' }
    let g:fzf_layout = { 'down': '~25%' }
    nnoremap <Leader>f :call FZFProjectRoot()<CR>
    " ----------------------------

    " indentLine -----------------
    let g:indentLine_color_term = 237
    " ----------------------------
endif

" functions ------------------
" ----------------------------

" create parent directories on save
" http://stackoverflow.com/a/4294176/336520
function s:MkNonExDir(file, buf)
    if empty(getbufvar(a:buf, '&buftype')) && a:file!~#'\v^\w+\:\/'
        let dir=fnamemodify(a:file, ':h')
        if !isdirectory(dir)
            call mkdir(dir, 'p')
        endif
    endif
endfunction

" search from the git root if we're in a git repo
function! FZFProjectRoot()
    let project_root = system('git rev-parse --show-toplevel 2> /dev/null')[:-2]
    if strlen(project_root) > 0
        call fzf#run(fzf#wrap('FZFProjectRoot', {'dir': project_root}))
    else
        call fzf#run(fzf#wrap('FZFProjectRoot'))
    endif
endfunction

" FIXME: we're so close! this almost works except that foldenable is still
" set after deleting all folds in a file, so foldcolumn doesn't go away :/
function! SetFoldColumn()
    if &foldenable == 1
        set foldcolumn=2
    else
        set foldcolumn=0
    endif
endfunction
