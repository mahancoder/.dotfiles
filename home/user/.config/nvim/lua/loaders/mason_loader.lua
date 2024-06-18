NAME="mason_loader"
M = {}

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
        ensure_installed = { "python", "cpptools" },
        handlers = {}
    })
end

M.load_mason =load_mason
return M
