" set settings {{{
set nocompatible
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
set mouse+=a
set shiftwidth=4
set expandtab
set guifont=DroidSansMono\ Nerd\ Font\ 14
set hidden
set nobackup
set nowritebackup
set cmdheight=2
set signcolumn=number
set completeopt=menu,menuone,noselect

" }}}

" Key mappings for normal mode movement {{{
inoremap <M-h> <Left>
inoremap <M-j> <Down>
inoremap <M-k> <Up>
inoremap <M-l> <Right>
inoremap <M-H> <C-c>0i
inoremap <M-L> <C-c>$i
" }}}

" Key mappings for command mode movement {{{
cnoremap <M-h> <Left>
cnoremap <M-j> <Down>
cnoremap <M-k> <Up>
cnoremap <M-l> <Right>
" }}}

" .vimrc related key mappings {{{
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>vr :source $MYVIMRC<cr>
" }}}

" Key mapping to exit visual and command mode faster {{{
vnoremap <Esc> <C-c>
" }}}

" gVim copy/cut/paste {{{
vmap <C-c> "+yi
vmap <C-x> "+c
vmap <C-v> c<ESC>"+p
imap <C-v> <C-r><C-o>+"
" }}}

" Folding {{{
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END
" }}}

" Auto saving {{{
augroup autosave
    autocmd!
    autocmd CursorHold,CursorHoldI * silent update
augroup END
" }}}

" Vim-Plug {{{
call plug#begin()

Plug 'preservim/nerdcommenter'
Plug 'vim-airline/vim-airline'
"Plug 'vim-airline/vim-airline-themes'
"Plug 'rafi/awesome-vim-colorschemes'
Plug 'Yggdroot/indentLine'
Plug 'preservim/nerdtree'
Plug 'mhinz/vim-startify'
Plug 'jiangmiao/auto-pairs'
Plug 'vim-autoformat/vim-autoformat'
Plug 'Nopik/vim-nerdtree-direnter'
Plug 'xolox/vim-session'
Plug 'xolox/vim-misc'
"Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'andweeb/presence.nvim'
Plug 'sheerun/vim-polyglot'
"Plug 'OmniSharp/omnisharp-vim'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'L3MON4D3/LuaSnip'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'mfussenegger/nvim-dap'
Plug 'rcarriga/nvim-dap-ui'
Plug 'mfussenegger/nvim-dap-python'
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'ibhagwan/fzf-lua', {'branch': 'main'}
Plug 'kyazdani42/nvim-web-devicons'
Plug 'p00f/nvim-ts-rainbow'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }
Plug 'williamboman/nvim-lsp-installer'
Plug 'neovim/nvim-lspconfig'
Plug 'rafamadriz/friendly-snippets'
Plug 'windwp/nvim-ts-autotag'
Plug 'joshdick/onedark.vim'
Plug 'navarasu/onedark.nvim'
Plug 'kyazdani42/nvim-tree.lua'

call plug#end()
" }}}

" Airline- {{{
let g:airline_powerline_fonts=1
let g:airline_theme='onedark'
let g:airline#extensions#tabline#enabled = 1
" }}}

" indentLine {{{
let g:indentLine_char_list = ['|', '¦', '┆', '┊']
" }}}

" NvimTree {{{
nnoremap <leader>t :NvimTreeToggle<CR>
"nnoremap <C-t> :NvimTreeToggle<CR>
"nnoremap <Space>f :NvimTreeFindFile<CR>
"let NERDTreeMapOpenInTab='<ENTER>'
"let NERDTreeCustomOpenArgs={'file':{'where': 't'}}
" }}}

" AutoPairs {{{
let g:AutoPairsShortcutJump = ''
" }}}

" Themeing {{{
colorscheme onedark
" Enable true color
if (empty($TMUX))
  if (has("nvim"))
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  if (has("termguicolors"))
    set termguicolors
  endif
endif
"hi Normal guibg=NONE ctermbg=NONE
" }}}

" Quality of life mappings {{{

" Formatter
noremap <leader>f :Autoformat<cr>

" Wrap/unwrap word/selection in double quotes
nnoremap <leader>" Bi"<esc>Ea"<esc>
nnoremap <leader>' Bi'<esc>Ea'<esc>
vnoremap <leader>" <esc>`<i"<esc>`>la"<esc>
vnoremap <leader>' <esc>`<i'<esc>`>la'<esc>
nnoremap <leader>u" F"xf"x
nnoremap <leader>u' F'xf'x
nnoremap <leader>(" F(a"<esc>f)i"<esc>
nnoremap <leader>(' F(a'<esc>f)i'<esc>

" Map H and L to line start and end
nnoremap H 0
nnoremap L $
nnoremap <leader>h H
nnoremap <leader>l L

" Map jk to normal mode
inoremap jk <esc>

" Split/buffer/tab key mappings
nnoremap <leader>s :vsplit<cr>
nnoremap <leader>hs :split<cr>
nnoremap <M-n> :tabnew<cr>
nnoremap <leader>n :vnew<cr>
nnoremap <M-l> gt
nnoremap <M-h> gT
nnoremap <M-w> :bw!<cr>
nnoremap <C-h> :bp!<cr>
nnoremap <C-l> :bn!<cr>
nnoremap <C-n> :enew!<cr>

" Motion mappings
onoremap @ :<c-u>execute "normal! Bv/@\rh"<cr>
onoremap o@ :<c-u>execute "normal! Bv/@\rlE"<cr>

" Location list mappings
nnoremap <leader>ec :lclose<cr>
nnoremap <leader>eo :lopen<cr><C-w>k
nnoremap <leader>en :lne<cr>
nnoremap <leader>ep :lp<cr>

" Copy to clipboard
vnoremap  <leader>y  "+y
nnoremap  <leader>Y  "+yg_
nnoremap  <leader>y  "+y

" Paste from clipboard
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p
vnoremap <leader>P "+P

" End search mappings
nnoremap <leader><Esc> :noh<cr>

" Map PageDown and PageUp to D and U
nnoremap D Lz<cr>
nnoremap U Hzb

" Open HTML/XML tags on enter
function EnterOrIndentTag()
    let line = getline(".")
    let col = getpos(".")[2]
    let before = line[col-2]
    let after = line[col-1]

    if before == ">" && after == "<"
        return "\<Enter>\<C-o>O\<Tab>"
    endif
    return "\<Enter>"
endfunction

inoremap <expr> <Enter> EnterOrIndentTag()

" Map Ctrl + BackSpace to delete word
imap <C-BS> <C-W>
" }}}

" Syntastic {{{
nnoremap <leader>e :SyntasticCheck<cr>
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
highlight link SyntasticErrorLine error
highlight link SyntasticWarningLine todo
" }}}

" gVim {{{
set go=""
" }}}

" vim-session {{{
let g:session_autosave = 'yes'
let g:session_autoload = 'yes'
let g:session_default_overwrite = 1
let g:session_autosave_periodic = 5
" }}}

" CoC {{{
" Key mappings {{{
" Use tab for trigger completion with characters ahead and navigate.
"inoremap <silent><expr> <TAB>
            "\ pumvisible() ? "\<C-n>" :
            "\ CheckBackspace() ? "\<TAB>" :
            "\ coc#refresh()
"inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
"function! CheckBackspace() abort
    "let col = col('.') - 1
    "return !col || getline('.')[col - 1]  =~# '\s'
"endfunction

"" Use <c-space> to trigger completion.
"inoremap <silent><expr> <c-space> coc#refresh()

"" Make <CR> auto-select the first completion item and notify coc.nvim to
"" format on enter
"inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
            "\: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

"" Use `[g` and `]g` to navigate diagnostics
"nmap <silent> [g <Plug>(coc-diagnostic-prev)
"nmap <silent> ]g <Plug>(coc-diagnostic-next)

"" GoTo code navigation.
"nmap <silent> gd <Plug>(coc-definition)
"nmap <silent> gy <Plug>(coc-type-definition)
"nmap <silent> gi <Plug>(coc-implementation)
"nmap <silent> gr <Plug>(coc-references)

"" Use K to show documentation in preview window.
"nnoremap <silent> K :call ShowDocumentation()<CR>

"function! ShowDocumentation()
    "if CocAction('hasProvider', 'hover')
        "call CocActionAsync('doHover')
    "else
        "call feedkeys('K', 'in')
    "endif
"endfunction

"" Highlight the symbol and its references when holding the cursor.
"autocmd CursorHold * silent call CocActionAsync('highlight')

"" Symbol renaming.
"nmap <leader>rn <Plug>(coc-rename)

"" Map function and class text objects
"xmap if <Plug>(coc-funcobj-i)
"omap if <Plug>(coc-funcobj-i)
"xmap af <Plug>(coc-funcobj-a)
"omap af <Plug>(coc-funcobj-a)
"xmap ic <Plug>(coc-classobj-i)
"omap ic <Plug>(coc-classobj-i)
"xmap ac <Plug>(coc-classobj-a)
"omap ac <Plug>(coc-classobj-a)

"" Remap <C-f> and <C-b> for scroll float windows/popups.
"nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
"nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
"inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
"inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
"vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
"vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"

"" Add `:OR` command for organize imports of the current buffer.
"command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

"" Mappings for CoCList
"" Show all diagnostics.
"nnoremap <silent><nowait> <Space>a  :<C-u>CocList diagnostics<cr>
"" Manage extensions.
"nnoremap <silent><nowait> <Space>e  :<C-u>CocList extensions<cr>
"" Show commands.
"nnoremap <silent><nowait> <Space>c  :<C-u>CocList commands<cr>
"" Find symbol of current document.
"nnoremap <silent><nowait> <Space>o  :<C-u>CocList outline<cr>
"" Search workspace symbols.
"nnoremap <silent><nowait> <Space>s  :<C-u>CocList -I symbols<cr>
"" Do default action for next item.
"nnoremap <silent><nowait> <Space>j  :<C-u>CocNext<CR>
"" Do default action for previous item.
"nnoremap <silent><nowait> <Space>k  :<C-u>CocPrev<CR>
"" Resume latest coc list.
"nnoremap <silent><nowait> <Space>p  :<C-u>CocListResume<CR>
" }}}
" }}}

" nvim-cmp (auto-completion) and lsp (language server) {{{
lua << EOF
-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('i', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  -- vim.keymap.set('n', '<space>f', vim.lsp.buf.formatting, bufopts)
end

local lsp_flags = {
  -- This is the default in Nvim 0.7+
  debounce_text_changes = 150,
}
-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

local lspconfig = require('lspconfig')

-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
local servers = {'pyright', 'eslint', 'tsserver', 'ccls', 'html', 'bashls'}
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities,
  }
end

-- luasnip setup
local luasnip = require 'luasnip'
require("luasnip.loaders.from_vscode").lazy_load()
require('luasnip').filetype_extend("javascript", { "javascriptreact" })
require('luasnip').filetype_extend("javascript", { "html" })

-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
	vim.lsp.diagnostic.on_publish_diagnostics, {
		virtual_text = false,
		underline = true,
		signs = false,
        update_in_insert = true
	}
)

local pid = vim.fn.getpid()
local omnisharp_bin = "/usr/bin/omnisharp"
require'lspconfig'.omnisharp.setup{
    cmd = { omnisharp_bin, "--languageserver" , "--hostPID", tostring(pid) };
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities,
}
EOF
" }}}

" DAP (Debugging) {{{
lua << EOF
local dap = require('dap')
-- require('dap-python').setup('~/.virtualenvs/debugpy/bin/python')
dap.adapters.cppdbg = {
  id = 'cppdbg',
  type = 'executable',
  command = '/home/mahan/.vscode/extensions/ms-vscode.cpptools-1.11.5-linux-x64/debugAdapters/bin/OpenDebugAD7',
}
dap.configurations.cpp = {
  {
    name = "Launch file",
    type = "cppdbg",
    request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = true,
    externalTerminal = true
  },
  {
    name = 'Attach to gdbserver :1234',
    type = 'cppdbg',
    request = 'launch',
    MIMode = 'gdb',
    miDebuggerServerAddress = 'localhost:1234',
    miDebuggerPath = '/usr/bin/gdb',
    cwd = '${workspaceFolder}',
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
  },
}
dap.configurations.c = dap.configurations.cpp
require("dapui").setup()
EOF
nnoremap <leader>db :DapToggleBreakpoint<cr>
nnoremap <leader>ds :DapContinue<cr>
nnoremap <leader>dt :DapTerminate<cr>
nnoremap <leader>dn :DapStepOver<cr>
nnoremap <leader>di :DapStepInto<cr>

nnoremap <leader>do :lua require("dapui").open()<cr>
nnoremap <leader>dc :lua require("dapui").close()<cr>
nnoremap <leader>dd :lua require("dapui").toggle()<cr>
nnoremap <space>d :lua require("dapui").float_element("scopes")<cr>
" }}}

" nvim-treesitter {{{
lua << EOF
require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
  ensure_installed = {},

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- List of parsers to ignore installing (for "all")
  ignore_install = {},

  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    disable = {},

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = true,
  },
  rainbow = {
    enable = true,
    -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
    extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    max_file_lines = nil, -- Do not enable for files with more than n lines, int
    -- colors = {}, -- table of hex strings
    -- termcolors = {} -- table of colour name strings
  },
  autotag = {
    enable = true,
  }
}
EOF
" }}}

" ranbow (parentheses) {{{
let g:rainbow_active = 1
" }}}

" nvim-lsp-installer {{{
lua require("nvim-lsp-installer").setup {}
" }}}

" onedark.nvim {{{
lua require('onedark').load()
" }}}

" NvimTree {{{
lua << EOF
-- examples for your init.lua

-- empty setup using defaults
require("nvim-tree").setup()

-- OR setup with some options
require("nvim-tree").setup({
  sort_by = "case_sensitive",
  view = {
    adaptive_size = true,
    mappings = {
      list = {
        { key = "u", action = "dir_up" },
        { key = "<CR>", action = "tabnew" },
      },
    },
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
})
EOF
" }}}

" FzfLua {{{
nnoremap <Space>f :FzfLua files<CR>
" }}}

" Discord Rich Presence {{{
lua << EOF
require("presence"):setup({
    main_image          = "file",                   -- Main image display (either "neovim" or "file")
    enable_line_number  = true,                      -- Displays the current line number instead of the current project
})
EOF
" }}}

