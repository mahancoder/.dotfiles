NAME="mappings_loader"
M = {}

local mappings = require("mappings")

local mapping_opts = mappings.mapping_opts

local set_key_mappings = function (leader)
    vim.g.mapleader = leader

    for _, mapping in pairs(mappings.nmaps) do
        vim.keymap.set('n', mapping[1], mapping[2], mapping_opts)
    end

    for _, mapping in pairs(mappings.imaps) do
        vim.keymap.set('i', mapping[1], mapping[2], mapping_opts)
    end

    for _, mapping in pairs(mappings.vmaps) do
        vim.keymap.set('v', mapping[1], mapping[2], mapping_opts)
    end

    for _, mapping in pairs(mappings.cmaps) do
        vim.keymap.set('c', mapping[1], mapping[2], mapping_opts)
    end
end

M.mapping_opts = mapping_opts
M.set_key_mappings = set_key_mappings

return M
