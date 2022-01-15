" set settings ---------------------------------------- {{{
let mapleader = "'"
set number
set numberwidth=4
set ttimeoutlen=0
filetype plugin indent on
syntax enable
hi folded ctermbg=8
set noshowmode
set shortmess=F
set foldlevelstart=99
set splitbelow
set splitright
set background=dark
set tabstop=4
set shiftwidth=4
set expandtab
" }}}

" Modifer mappings for Alt Escape sequence------------- {{{
set <M-j>=j
set <M-k>=k
set <M-h>=h
set <M-l>=l
set <M-H>=H
set <M-L>=L
set <M-w>=w
set <M-n>=n
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

" Formatter
noremap <C-I> :Autoformat<cr>

" Wrap/unwrap word/selection in double quotes
nnoremap <leader>" bi"<esc>ea"<esc>
nnoremap <leader>' bi'<esc>ea'<esc>
vnoremap <leader>" <esc>`<i"<esc>`>la"<esc>
vnoremap <leader>' <esc>`<i'<esc>`>la'<esc>
nnoremap <leader>u" F"xf"x
nnoremap <leader>u' F'xf'x
nnoremap <leader>"( F(a"<esc>f)i"<esc>
nnoremap <leader>'( F(a'<esc>f)i'<esc>

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

" Split/buffer/tab key mappings
nnoremap <leader>s :vsplit<cr>
nnoremap <C-n> :tabnew<cr>
nnoremap <leader>n :vnew<cr>
nnoremap <C-l> gt
nnoremap <C-h> gT
nnoremap <C-w> :tabclose<cr>
nnoremap <M-h> :bp<cr>
nnoremap <M-l> :bn<cr>
nnoremap <M-w> :bw<cr>
nnoremap <M-n> :enew<cr>

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
Plug 'preservim/nerdtree'
Plug 'mhinz/vim-startify'
Plug 'jiangmiao/auto-pairs'
Plug 'Chiel92/vim-autoformat'

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

" NERDTree ------------------------------------------- {{{
nnoremap <leader>t :NERDTreeFocus<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>
" }}}
colorscheme gruvbox
