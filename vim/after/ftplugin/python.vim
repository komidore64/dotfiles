" set formatoptions to be the same as ruby

" REMOVING
" Auto-wrap text using textwidth
setlocal formatoptions-=t

" Auto-wrap comments using textwidth, inserting the current
" comment leader automatically.
setlocal formatoptions+=c

" Automatically insert the current comment leader after hitting
" <Enter> in Insert mode.
setlocal formatoptions+=r

" Automatically insert the current comment leader after hitting 'o' or
" 'O' in Normal mode.
setlocal formatoptions+=o

" Allow formatting of comments with 'gq'.
" Note that formatting will not change blank lines or lines containing
" only the comment leader.  A new paragraph starts after such a line,
" or when the comment leader changes.
setlocal formatoptions+=q

" Long lines are not broken in insert mode: When a line was longer than
" 'textwidth' when the insert command started, Vim does not
" automatically format it.
setlocal formatoptions+=l

setlocal tabstop=4

let g:pyindent_open_paren = shiftwidth()
let g:pyindent_continue = shiftwidth()
