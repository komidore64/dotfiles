set nocompatible "make vim more fun

filetype plugin on
filetype plugin indent on
syntax enable "syntax highlighting

set showmode "display the current mode
set showcmd "show the commands in realtime

set hlsearch "highlight search matches
set incsearch "realtime search matching

set ignorecase "ignore case when searching
set smartcase "for smarter searching

set ruler "show row/column of cursor
set cursorline "highlight current line
highlight CursorLine cterm=none ctermbg=DarkGrey

set tabstop=4 "default tab length of 4
set shiftwidth=4 "default shifting (block indentation) length of 4
set expandtab "replace tabs with spaces

set wildmode=list:longest "show tab-completions for file-paths

autocmd BufWritePre * :%s/\s\+$//e "remove trailing whitespace
