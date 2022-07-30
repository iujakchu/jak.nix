local toggleterm = require "toggleterm"
toggleterm.setup {
    size = 20,
    open_mapping = [[<c-\>]],
    hide_numbers = true,
    shade_filetypes = {},
    shade_terminals = true,
    shading_factor = 2,
    start_in_insert = true,
    insert_mappings = true,
    persist_size = true,
    direction = "float",
    close_on_exit = true,
    shell = vim.o.shell,
    float_opts = {
        border = "curved",
        winblend = 0,
        highlights = {
            border = "Normal",
            background = "Normal",
        },
    },
}

local Terminal = require("toggleterm.terminal").Terminal

vim.keymap.set("n", "<leader>og", function()
    local lazygit = Terminal:new { cmd = "lazygit", hidden = true }
    lazygit:toggle()
end)

vim.keymap.set("n", "<leader>od", function()
    local dust = Terminal:new { cmd = "dust", hidden = true, close_on_exit = false }
    dust:toggle()
end)

vim.keymap.set("n", "<leader>ob", function()
    local btm = Terminal:new { cmd = "btm", hidden = true }
    btm:toggle()
end)
