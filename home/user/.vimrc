" set settings ---------------------------------------- {{{
let mapleader = ","
set number
set numberwidth=4
set ttimeoutlen=0
filetype plugin on
syntax enable
hi folded ctermbg=8
set noshowmode
set shortmess=F
set foldlevelstart=99
set splitbelow
set splitright
set background=dark
" }}}

" Modifer mappings for Alt Escape sequence------------- {{{
set <M-j>=j
set <M-k>=k
set <M-h>=h
set <M-l>=l
set <M-H>=H
set <M-L>=L
" }}}

" Key mappings for normal mode movement --------------- {{{
inoremap <M-h> <Left>
inoremap <M-j> <Down>
inoremap <M-k> <Up>
inoremap <M-l> <Right>
inoremap <M-H> <C-c>0i
inoremap <M-L> <C-c>$i
" }}}

" Key mappings for command mode movement -------------- {{{
cnoremap <M-h> <Left>
cnoremap <M-j> <Down>
cnoremap <M-k> <Up>
cnoremap <M-l> <Right>
" }}}

" .vimrc related key mappings ------------------------- {{{
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>vr :source $MYVIMRC<cr>
" }}}

" Key mapping to exit visual and command mode faster -- {{{
vnoremap <Esc> <C-c>
" }}}

" Quality of life mappings ---------------------------- {{{
" Wrap word/selection in double quotes
nnoremap <leader>" bi"<esc>ea"<esc>
vnoremap <leader>" <esc>`<i"<esc>`>la"<esc>

" Map H and L to line start and end
nnoremap H 0
nnoremap L $

" Map jk to normal mode
inoremap jk <esc>

" Force myself to discard bad habits
inoremap <Left> <nop>
inoremap <Right> <nop>
inoremap <Up> <nop>
inoremap <Down> <nop>

" Split key mappings
nnoremap <leader>s :vsplit<cr>
nnoremap <C-n> :vnew<cr>

" Motion mappings
onoremap @ :<c-u>execute "normal! Bv/@\rh"<cr>
onoremap o@ :<c-u>execute "normal! Bv/@\rlE"<cr>
" }}}

" Folding--------- ----------------------------------- {{{
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END
" }}}

" Vim-Plug ------------------------------------------- {{{
call plug#begin()

Plug 'preservim/nerdcommenter'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'rafi/awesome-vim-colorschemes'
Plug 'Yggdroot/indentLine'

call plug#end()
" }}}

" Airline -------------------------------------------- {{{
let g:airline_powerline_fonts=1
let g:airline_theme='gruvbox'
let g:airline#extensions#tabline#enabled = 1
" }}}

" indentLine ----------------------------------------- {{{
let g:indentLine_char_list = ['|', '¦', '┆', '┊']
" }}}
colorscheme gruvbox
