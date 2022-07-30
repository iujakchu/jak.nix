vim.api.nvim_create_user_command("LuaSnipEdit", function()
    require("luasnip.loaders.from_lua").edit_snippet_files()
end, {})
vim.api.nvim_create_autocmd("TextYankPost", {
    pattern = "*",
    callback = function()
        vim.highlight.on_yank { higroup = "WildMenu", timeout = 400 }
    end,
})
-- Highlight Yanked Text
--[[ vim.api.nvim_create_autocmd({ "TextYankPost" }, {
    callback = function()
        vim.highlight.on_yank { higroup = "CursorLineFold", timeout = 400 }
    end,
}) ]]
vim.api.nvim_create_autocmd("FileType", {
    pattern = "alpha",
    callback = function()
        vim.opt.laststatus = 0
    end,
})

vim.api.nvim_create_autocmd("BufUnload", {
    buffer = 0,
    callback = function()
        vim.opt.laststatus = 3
    end,
})
-- vim.api.nvim_create_autocmd("BufRead", {
--     pattern = "*",
--     callback = function()
--         local cursor_at = vim.fn.line '`"'
--         if vim.fn.line "$" >= cursor_at and cursor_at > 1 then
--             vim.api.nvim_command 'g`"'
--         end
--     end,
-- })
-- vim.api.nvim_create_autocmd("FileType", {
--     pattern = "help",
--     callback = function()
--         vim.cmd "colorscheme torte"
--         vim.keymap.set("n", "<C-P>", "<C-]>")
--         vim.opt_local.conceallevel = 0
--         vim.api.nvim_command [[
--             hi link HelpBar Normal
--             hi link HelpStar Normal
--         ]]
--     end,
-- })
-- set shada path
--vim.schedule(function()
--    vim.opt.shadafile = vim.fn.stdpath "data" .. "/shada/main.shada"
--    vim.cmd [[ silent! rsh ]]
--end)
vim.api.nvim_create_autocmd("BufEnter", {
    pattern = "*",
    command = "set fo-=o",
})
--HACK: tmp workaround for MatchParen highlight group
vim.schedule(function()
    vim.cmd "hi clear MatchWord"
    vim.cmd "hi clear MatchParen"
    vim.cmd "hi MatchParen guibg=LightRed"
end)
-- HACK: winbar lspsaga
-- Example:
local function get_file_name(include_path)
    local file_name = require("lspsaga.symbolwinbar").get_file_name()
    if vim.fn.bufname "%" == "" then
        return ""
    end
    if include_path == false then
        return file_name
    end
    -- Else if include path: ./lsp/saga.lua -> lsp > saga.lua
    local sep = vim.loop.os_uname().sysname == "Windows" and "\\" or "/"
    local path_list = vim.split(string.gsub(vim.fn.expand "%:~:.:h", "%%", ""), sep)
    local file_path = ""
    for _, cur in ipairs(path_list) do
        file_path = (cur == "." or cur == "~") and "" or file_path .. cur .. " " .. "%#LspSagaWinbarSep#>%*" .. " %*"
    end
    return file_path .. file_name
end

local function config_winbar()
    local exclude = {
        ["teminal"] = true,
        ["toggleterm"] = true,
        ["prompt"] = true,
        ["NvimTree"] = true,
        ["help"] = true,
    } -- Ignore float windows and exclude filetype
    if vim.api.nvim_win_get_config(0).zindex or exclude[vim.bo.filetype] then
        vim.wo.winbar = ""
    else
        local ok, lspsaga = pcall(require, "lspsaga.symbolwinbar")
        local sym
        if ok then
            sym = lspsaga.get_symbol_node()
        end
        local win_val = ""
        win_val = get_file_name(true) -- set to true to include path
        if sym ~= nil then
            win_val = win_val .. sym
        end
        vim.wo.winbar = win_val
    end
end

local events = { "BufEnter", "BufWinEnter", "CursorMoved" }

vim.api.nvim_create_autocmd(events, {
    pattern = "*",
    callback = function()
        config_winbar()
    end,
})

vim.api.nvim_create_autocmd("User", {
    pattern = "LspsagaUpdateSymbol",
    callback = function()
        config_winbar()
    end,
})
