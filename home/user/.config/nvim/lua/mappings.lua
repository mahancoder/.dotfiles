NAME="mappings"

M = {}

local mapping_opts = { noremap = true, silent = true }

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


M.mapping_opts = mapping_opts
M.nmaps = nmaps
M.imaps = imaps
M.vmaps= vmaps
M.cmaps = cmaps
return M
