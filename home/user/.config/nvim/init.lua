vim.g.loaded_netrw       = 1
vim.g.loaded_netrwPlugin = 1

local mapping_opts = { noremap = true, silent = true }

local set_options = function (options, colorscheme)
    for key, value in pairs(options) do
        vim.o[key] = value
    end
    vim.cmd("colorscheme " .. colorscheme)
end


local set_key_mappings = function (leader, normal, insert, visual, command)
    vim.g.mapleader = leader

    for _, mapping in pairs(normal) do
        vim.keymap.set('n', mapping[1], mapping[2], mapping_opts)
    end

    for _, mapping in pairs(insert) do
        vim.keymap.set('i', mapping[1], mapping[2], mapping_opts)
    end

    for _, mapping in pairs(visual) do
        vim.keymap.set('v', mapping[1], mapping[2], mapping_opts)
    end

    for _, mapping in pairs(command) do
        vim.keymap.set('c', mapping[1], mapping[2], mapping_opts)
    end
end

local install_lazy_nvim = function ()
    local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
    if not (vim.uv or vim.loop).fs_stat(lazypath) then
        vim.fn.system({
            "git",
            "clone",
            "--filter=blob:none",
            "https://github.com/folke/lazy.nvim.git",
            "--branch=stable",
            lazypath,
        })
    end
    vim.opt.rtp:prepend(lazypath)
end

local load_plugins = function (plugins)
    require("lazy").setup(plugins)
end

local load_indent_blankline = function ()
    local highlight = {
        "RainbowRed",
        "RainbowYellow",
        "RainbowBlue",
        "RainbowOrange",
        "RainbowGreen",
        "RainbowViolet",
        "RainbowCyan",
    }

    local hooks = require "ibl.hooks"
    hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
        vim.api.nvim_set_hl(0, "RainbowRed", { fg = "red" })
        vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "yellow" })
        vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "blue" })
        vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "orange" })
        vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "green" })
        vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "violet" })
        vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "cyan" })
    end)

    require("ibl").setup { indent = { highlight = highlight }, exclude = {filetypes = {"dashboard"}} }
end

local load_nvim_tree = function ()
    require("nvim-tree").setup({
        view = {
            width = 30,
        },
        renderer = {
            group_empty = true,
        },
        filters = {
            dotfiles = true,
        }
    })
    local api = require("nvim-tree.api")
    vim.keymap.set("n", "<leader>t", function()
        api.tree.toggle({ path = "", find_file = false, update_root = false, focus = true })
    end)
end

local load_dashboard_nvim = function ()
    require('dashboard').setup()
end

local load_nvim_autopairs = function ()
    require('nvim-autopairs').setup({
        enable_check_bracket_line = false
    })
end

local load_comment_nvim = function ()
    require('Comment').setup()
end

local load_presence_nvim = function ()
    require("presence").setup({
        main_image = "file",
        enable_line_number = true,
    })
end

local load_treesitter = function ()
    require'nvim-treesitter.configs'.setup {
        highlight = {
            enable = true,
            additional_vim_regex_highlighting = false,
        },
    }
    vim.cmd("silent TSUpdate")
end

local load_mason = function ()
    require("mason").setup({
        ui = {
            icons = {
                package_installed = "✓",
                package_pending = "➜",
                package_uninstalled = "✗"
            }
        }
    })
    require("mason-lspconfig").setup {
        ensure_installed = {
            'pyright',
            'eslint',
            'tsserver',
            'clangd',
            'html',
            'bashls',
            'cssls',
            'vimls',
            'lua_ls',
            'arduino_language_server',
            'jsonls',
            'omnisharp'
        }
    }
    require("mason-nvim-dap").setup({
        ensure_installed = { "python" },
        handlers = {}
    })
end

local load_luasnip = function ()
    local luasnip = require('luasnip')
    require("luasnip.loaders.from_vscode").lazy_load()
    require('luasnip').filetype_extend("javascript", { "javascriptreact" })
    require('luasnip').filetype_extend("javascript", { "html" })

    return luasnip
end

local load_nvim_cmp = function ()
    local luasnip = load_luasnip()
    local cmp_autopairs = require('nvim-autopairs.completion.cmp')
    local cmp_kinds = {
        Text = '  ',
        Method = '  ',
        Function = '  ',
        Constructor = '  ',
        Field = '  ',
        Variable = '  ',
        Class = '  ',
        Interface = '  ',
        Module = '  ',
        Property = '  ',
        Unit = '  ',
        Value = '  ',
        Enum = '  ',
        Keyword = '  ',
        Snippet = '  ',
        File = '  ',
        Reference = '  ',
        Folder = '  ',
        EnumMember = '  ',
        Constant = '  ',
        Struct = '  ',
        Event = '  ',
        Operator = '  ',
        TypeParameter = '  ',
    }

    local cmp = require("cmp")
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
        sources = cmp.config.sources({
            { name = 'nvim_lsp' },
            { name = 'luasnip' },
        },{
            { name = 'buffer' },
        }),
        formatting = {
            format = function(_, vim_item)
                vim_item.kind = (cmp_kinds[vim_item.kind] or '') .. vim_item.kind
                return vim_item
            end
        }
    }
    cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
end

local set_lsp_mappings = function ()
    vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, mapping_opts)
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, mapping_opts)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, mapping_opts)
    vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, mapping_opts)

    local on_attach = function(client, bufnr)
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
    end
    return on_attach
end

local load_lsp = function ()
    load_nvim_cmp()

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

    local lspconfig = require('lspconfig')
    local on_attach = set_lsp_mappings()

    require("mason-lspconfig").setup_handlers {
        function (server_name)
            lspconfig[server_name].setup {
                on_attach = on_attach,
                capabilities = capabilities,
                handlers = {
                    ["textDocument/publishDiagnostics"] = vim.lsp.with(
                    vim.lsp.diagnostic.on_publish_diagnostics, {
                        virtual_text = false,
                        underline = true,
                        signs = false,
                        update_in_insert = true
                    })
                }
            }
        end
    }
end

local set_dap_mappings = function ()
    local dap = require("dap")
    vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, mapping_opts)
    vim.keymap.set("n", "<leader>ds", dap.continue, mapping_opts)
    vim.keymap.set("n", "<leader>dt", dap.terminate, mapping_opts)
    vim.keymap.set("n", "<leader>dn", dap.step_over, mapping_opts)
    vim.keymap.set("n", "<leader>di", dap.step_into, mapping_opts)
end

local set_dapui_mappings = function ()
    local dapui = require("dapui")
    vim.keymap.set("n", "<leader>do", dapui.open, mapping_opts)
    vim.keymap.set("n", "<leader>dc", dapui.close, mapping_opts)
    vim.keymap.set("n", "<leader>dd", dapui.toggle, mapping_opts)
    vim.keymap.set("n", "<Space>d", function() dapui.float_element("scopes") end, mapping_opts)
end

local load_dap = function ()
    set_dap_mappings()
    set_dapui_mappings()
    require("dapui").setup()
    require("nvim-dap-virtual-text").setup()
end

local load_fzflua = function ()
    local fzflua = require("fzf-lua")
    fzflua.setup({})
    vim.keymap.set("n", "<Space>f", fzflua.files, mapping_opts)
end

local load_lualine = function ()
    require("lualine").setup({
        options = {
            theme = "onedark"
        }
    })
end

local load_rainbow = function ()
    require('rainbow-delimiters.setup').setup()
end

local options = {
    mouse="a", -- Mouse enabled on all modes
    number=true,
    showmode=false, -- Disable --MODE-- thingy

    splitbelow=true,
    splitright=true,

    tabstop=4, -- Tab sapce count
    expandtab = true, -- Replace <Tab> by spaces
    shiftwidth = 0, -- >> and << space count (equal to tabstop if 0)

    termguicolors = true -- 24-bit colors
}

local leader = "'"
local colorscheme = "onedark"

local nmaps = {
    -- Edit and reload init.lua
    {"<leader>ve", function() vim.cmd("e $MYVIMRC") end},
    {"<leader>vr", function() vim.cmd("luafile $MYVIMRC") end},

    {"<leader>y", "\"+y"},
    {"<leader>p", "\"+p"},
    {"<leader>Y", "\"+yg_"},
    {"<leader>P", "\"+P"},

    {"<leader><Esc>", function() vim.cmd("noh") end}
}

local imaps = {
    -- ALt-hjkl to move in insert mode
    {"<M-h>", "<Left>"},
    {"<M-j>", "<Down>"},
    {"<M-k>", "<Up>"},
    {"<M-l>", "<Right>"},

    -- Alt-H and Alt-L to jump to line beginning/end in insert mode
    {"<M-H>", "<C-c>0i"},
    {"<M-L>", "<C-c>$a"},


}

local cmaps = {
    -- Alt-hjkl to move in command mode
    {"<M-h>", "<Left>"},
    {"<M-j>", "<Down>"},
    {"<M-k>", "<Up>"},
    {"<M-l>", "<Right>"},
}

local vmaps = {
    {"<leader>y", "\"+y"},
    {"<leader>p", "\"+p"},
    {"<leader>P", "\"+P"},
}

local plugins = {
    -- UI
    {'nvim-lualine/lualine.nvim', dependencies = { 'nvim-tree/nvim-web-devicons' }, config = load_lualine},
    {'nvim-tree/nvim-tree.lua', config = load_nvim_tree},

    -- 'vim-autoformat/vim-autoformat',
    -- 'xolox/vim-session',
    -- 'xolox/vim-misc',

    -- Mason
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    "jay-babu/mason-nvim-dap.nvim",

    -- LSP
    'neovim/nvim-lspconfig',
    'hrsh7th/nvim-cmp',
    'hrsh7th/cmp-nvim-lsp',
    'L3MON4D3/LuaSnip',
    'rafamadriz/friendly-snippets',
    'saadparwaiz1/cmp_luasnip',

    -- DAP
    'mfussenegger/nvim-dap',
    'rcarriga/nvim-dap-ui',
    'theHamsta/nvim-dap-virtual-text',

    -- Treesitter, delimiters, autopairs, commenting, indentline, etc.
    {'nvim-treesitter/nvim-treesitter', config = load_treesitter},
    {'windwp/nvim-ts-autotag', config = true, dependencies = {'nvim-treesitter/nvim-treesitter'}},
    {'HiPhish/rainbow-delimiters.nvim', config = load_rainbow, dependencies = {'nvim-treesitter/nvim-treesitter'}},
    {'windwp/nvim-autopairs', event = 'InsertEnter', config = load_nvim_autopairs},
    {'lukas-reineke/indent-blankline.nvim', main = 'ibl', config = load_indent_blankline},
    {'numToStr/Comment.nvim', config = load_comment_nvim},

    {'ibhagwan/fzf-lua', dependencies = { "nvim-tree/nvim-web-devicons" }, config = load_fzflua},

    -- Theming
    'olimorris/onedarkpro.nvim',
    {'nvimdev/dashboard-nvim', event = 'VimEnter', config = load_dashboard_nvim},

    -- Status apps
    'ActivityWatch/aw-watcher-vim',
    {'andweeb/presence.nvim', config = load_presence_nvim},

    -- Internal libs
    'nvim-neotest/nvim-nio',
    'nvim-tree/nvim-web-devicons',
}

set_key_mappings(leader, nmaps, imaps, vmaps, cmaps)
install_lazy_nvim()
load_plugins(plugins)
set_options(options, colorscheme)
load_mason()
load_lsp()
load_dap()
