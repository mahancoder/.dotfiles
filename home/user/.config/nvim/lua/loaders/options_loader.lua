NAME="options_loader"
M = {}

local set_options = function (options)
    for key, value in pairs(options) do
        vim.o[key] = value
    end
end

M.set_options = set_options

return M
