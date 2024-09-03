NAME = "plugin_loaders"
M = {}

local mapping_opts = require("mappings").mapping_opts

local load_indent_blankline = function()
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

    require("ibl").setup { indent = { highlight = highlight }, exclude = { filetypes = { "dashboard" } } }
end

local load_nvim_tree = function()
    -- Disable netrw for nvim-tree (see :help nvim-tree-netrw)
    vim.g.loaded_netrw       = 1
    vim.g.loaded_netrwPlugin = 1
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
    end, mapping_opts)
end

local load_dashboard_nvim = function()
    require('dashboard').setup()
end

local load_nvim_autopairs = function()
    require('nvim-autopairs').setup({
        enable_check_bracket_line = false
    })
end

local load_comment_nvim = function()
    require('Comment').setup()
end

local load_presence_nvim = function()
    require("presence").setup({
        main_image = "file",
        enable_line_number = true,
    })
end

local load_treesitter = function()
    -- Neovim doesn't detect rasi (rofi styling) files by default
    vim.filetype.add {
        extension = {
            rasi = 'rasi',
        },
    }
    require 'nvim-treesitter.configs'.setup {
        highlight = {
            enable = true,
            additional_vim_regex_highlighting = false,
        },
    }
    vim.cmd("silent TSUpdate")
end

local load_fzflua = function()
    local fzflua = require("fzf-lua")
    fzflua.setup({})
    vim.keymap.set("n", "<Space>f", fzflua.files, mapping_opts)
end

local load_lualine = function()
    require("lualine").setup({
        options = {
            theme = "onedark"
        }
    })
end

local load_rainbow = function()
    require('rainbow-delimiters.setup').setup()
end

local load_theme = function()
    require("onedarkpro").setup({
        highlights = {
            NvimDapVirtualText = { link = "Comment" }
        }
    })
    vim.cmd("colorscheme onedark")
end

M.load_indent_blankline = load_indent_blankline
M.load_nvim_tree = load_nvim_tree
M.load_dashboard_nvim = load_dashboard_nvim
M.load_nvim_autopairs = load_nvim_autopairs
M.load_comment_nvim = load_comment_nvim
M.load_presence_nvim = load_presence_nvim
M.load_treesitter = load_treesitter
M.load_fzflua = load_fzflua
M.load_lualine = load_lualine
M.load_rainbow = load_rainbow
M.load_theme = load_theme

return M
