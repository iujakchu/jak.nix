local M = {}

M.get_colors = function(type)
    local name = vim.g.nvchad_theme

    -- theme paths
    local default_path = "themes." .. name

    local present1, default_theme = pcall(require, default_path)

    if present1 then
        return default_theme[type]
    else
        error "No such theme bruh >_< "
    end
end

M.merge_tb = function(table1, table2)
    return vim.tbl_deep_extend("force", table1, table2)
end

M.load_theme = function()
    require("plenary.reload").reload_module "base46.integrations"
    require("plenary.reload").reload_module "base46.chadlights"
    require "base46.chadlights"
end

return M
