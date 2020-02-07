" ~/.vimrc


" fancy vim
set nocompatible
set updatetime=1000

" color and display
colorscheme default
set t_Co=256
set background=light

" one place for swap files
set directory=~/.vim/

" load up plugins via vundle
if filereadable(expand("~/.vundle"))
    source ~/.vundle
endif

syntax enable
filetype plugin on
filetype indent on

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
nnoremap <Leader>n :set norelativenumber invnumber<CR>

" toggle relative line numbers
nnoremap <Leader>r :set nonumber invrelativenumber<CR>

" i never use "Ex" mode
nnoremap Q <Nop>

" highlight search and real-time search
set hlsearch
set incsearch

" ignore case when searching,
set ignorecase

" (cont'd) unless you use a capital letter then don't ignore case
set smartcase

" sensible defaults ----------
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
" ----------------------------

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

" remove trailing whitespace -
augroup whitespace
    autocmd!
    autocmd BufWritePre * :%s/\s\+$//e
augroup END
" ----------------------------

" set filetypes --------------
augroup markdown_filetype
    autocmd!
    autocmd BufRead,BufNewFile *.md set ft=markdown
augroup END

augroup ansible_filetype
    autocmd!
    autocmd BufRead,BufNewFile */playbooks/**/*.y*ml,*/roles/**/*.y*ml set ft=yaml.ansible
augroup END
" ----------------------------

" mkdir on parent directory(s) if they don't exist when saving a file
augroup create_parent_dirs
    autocmd!
    autocmd BufWritePre * call s:CreateParentDirs(expand('<afile>'), +expand('<abuf>'))
augroup END
" ----------------------------

" disable netrw --------------
let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1
" ----------------------------

" vimdiff --------------------
highlight DiffAdd cterm=bold ctermbg=green ctermfg=black
highlight DiffChange cterm=bold ctermbg=cyan ctermfg=black
highlight DiffText cterm=bold ctermbg=grey ctermfg=black
highlight DiffDelete cterm=bold ctermbg=red ctermfg=black
" ----------------------------

" spell-checking -------------
highlight SpellCap cterm=undercurl ctermbg=grey ctermfg=black
highlight SpellBad cterm=undercurl ctermbg=red ctermfg=black
highlight SpellRare cterm=undercurl ctermbg=cyan ctermfg=black
" ----------------------------

" pop-up menu ----------------
highlight Pmenu ctermbg=darkgrey ctermfg=white
highlight PmenuSel cterm=bold ctermbg=lightgrey ctermfg=black
" ----------------------------

" line numbers ---------------
set relativenumber
highlight clear LineNr
highlight LineNr ctermfg=darkgrey
" ----------------------------

" cursorline -----------------
set cursorline
highlight clear CursorLine
highlight CursorLineNr ctermfg=black ctermbg=darkgrey cterm=none
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
    autocmd CursorHold * call SetFoldColumn()
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

    " vim-markdown----------------
    let g:markdown_syntax_conceal = 0
    " ----------------------------

    " vim-gitgutter --------------
    nnoremap <Leader>gg :GitGutterToggle<CR>
    highlight GitGutterAdd ctermfg=green
    highlight GitGutterChange ctermfg=cyan
    highlight GitGutterDelete ctermfg=red
    highlight GitGutterChangeDelete ctermfg=red
    " ----------------------------

    " fzf ------------------------
    let g:fzf_action = {
        \ 'enter': 'tab split',
        \ 'ctrl-t': 'tab split',
        \ 'ctrl-x': 'split',
        \ 'ctrl-v': 'vsplit', }
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
function! s:CreateParentDirs(file, buf)
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
