" set settings
let mapleader = ","
set number
set numberwidth=4
set ttimeoutlen=0

" --------------------------------------------------

"Modifer mappings for Alt Escape sequence
set <M-j>=j
set <M-k>=k
set <M-h>=h
set <M-l>=l

" --------------------------------------------------

" Key mappings for normal mode movement
inoremap <M-h> <Left>
inoremap <M-j> <Down>
inoremap <M-k> <Up>
inoremap <M-l> <Right>

" --------------------------------------------------

" Key mappings for command mode movement
cnoremap <M-h> <Left>
cnoremap <M-j> <Down>
cnoremap <M-k> <Up>
cnoremap <M-l> <Right>
nnoremap <leader>" viw<esc>a"<esc>bi"<esc>lel

" --------------------------------------------------

" .vimrc related key mappings
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

" --------------------------------------------------

" Key mapping to exit visual and command mode faster
vnoremap <Esc> <C-c>
cnoremap <Esc> <C-c>

" --------------------------------------------------

" Quality of life mappings

" Wrap word/selection in double quotes
noremap <leader>" bi"<esc>ea"<esc>
vnoremap <leader>" <esc>`<i"<esc>`>la"<esc>

" Map H and L to line start and end
nnoremap <S-h> 0
nnoremap <S-l> $

" Map jk to normal mode
inoremap jk <esc>

" Force myself to discard bad habits
inoremap <esc> <nop>
inoremap <Left> <nop>
inoremap <Right> <nop>
inoremap <Up> <nop>
inoremap <Down> <nop>
