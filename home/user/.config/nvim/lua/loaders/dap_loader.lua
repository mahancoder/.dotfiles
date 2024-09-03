NAME="dap_loader"
M = {}

local mapping_opts = require("mappings").mapping_opts

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

M.load_dap = load_dap

return M
