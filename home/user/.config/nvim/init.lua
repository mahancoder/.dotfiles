local mappings_loader = require("loaders.mappings_loader")
local lsp_loader = require("loaders.lsp_loader")
local mason_loader = require("loaders.mason_loader")
local plugins = require("plugins")
local options_loader = require("loaders.options_loader")
local dap_loader = require("loaders.dap_loader")

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

mappings_loader.set_key_mappings(leader)
options_loader.set_options(options)
plugins.load_plugins()
mason_loader.load_mason()
lsp_loader.load_lsp()
dap_loader.load_dap()

