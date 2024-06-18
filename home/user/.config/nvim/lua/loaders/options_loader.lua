NAME="options_loader"
M = {}

local set_options = function (options, colorscheme)
    for key, value in pairs(options) do
        vim.o[key] = value
    end
    vim.cmd("colorscheme " .. colorscheme)
end

M.set_options = set_options

return M
