NAME = "lsp_loader"
M = {}

local mapping_opts = require("mappings").mapping_opts

local load_neodev = function()
    require("neodev").setup({
        library = { plugins = { "nvim-dap-ui" }, types = true }
    })
end

local load_luasnip = function()
    local luasnip = require('luasnip')
    require("luasnip.loaders.from_vscode").lazy_load()

    -- Add react and html snippets to js files for react jsx
    require('luasnip').filetype_extend("javascript", { "javascriptreact" })
    require('luasnip').filetype_extend("javascript", { "html" })

    return luasnip
end

local load_nvim_cmp = function()
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
        }, {
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

local set_lsp_mappings = function()
    vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, mapping_opts)
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, mapping_opts)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, mapping_opts)
    vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, mapping_opts)

    local on_attach = function(_, bufnr)
        local bufopts = { noremap = true, silent = true, buffer = bufnr }
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
        vim.keymap.set('n', '<leader>f', vim.lsp.buf.format, bufopts)
    end
    return on_attach
end

local load_lsp = function()
    load_nvim_cmp()

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

    load_neodev()

    local lspconfig = require('lspconfig')
    local on_attach = set_lsp_mappings()

    require("mason-lspconfig").setup_handlers {
        function(server_name)
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

M.load_lsp = load_lsp

return M
