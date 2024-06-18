local NAME="plugins"

local M = {}

local plugin_loaders = require("loaders.plugin_loaders")

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


local plugins = {
    -- UI
    {'nvim-lualine/lualine.nvim', dependencies = { 'nvim-tree/nvim-web-devicons' }, config = plugin_loaders.load_lualine},
    {'nvim-tree/nvim-tree.lua', config = plugin_loaders.load_nvim_tree},

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
    {'nvim-treesitter/nvim-treesitter', config = plugin_loaders.load_treesitter},
    {'windwp/nvim-ts-autotag', config = true, dependencies = {'nvim-treesitter/nvim-treesitter'}},
    {'HiPhish/rainbow-delimiters.nvim', config = plugin_loaders.load_rainbow, dependencies = {'nvim-treesitter/nvim-treesitter'}},
    {'windwp/nvim-autopairs', event = 'InsertEnter', config = plugin_loaders.load_nvim_autopairs},
    {'lukas-reineke/indent-blankline.nvim', main = 'ibl', config = plugin_loaders.load_indent_blankline},
    {'numToStr/Comment.nvim', config = plugin_loaders.load_comment_nvim},

    {'ibhagwan/fzf-lua', dependencies = { "nvim-tree/nvim-web-devicons" }, config = plugin_loaders.load_fzflua},

    -- Theming
    'olimorris/onedarkpro.nvim',
    {'nvimdev/dashboard-nvim', event = 'VimEnter', config = plugin_loaders.load_dashboard_nvim},

    -- Status apps
    'ActivityWatch/aw-watcher-vim',
    {'andweeb/presence.nvim', config = plugin_loaders.load_presence_nvim},

    -- Internal libs
    'nvim-neotest/nvim-nio',
    'nvim-tree/nvim-web-devicons',
}

local load_plugins = function ()
    require("lazy").setup(plugins)
end

M.install_lazy_nvim = install_lazy_nvim
M.load_plugins = load_plugins

return M
