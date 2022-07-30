if vim.g.neovide == nil then
    return
end
-- nushell does not support on windows
local sys = vim.loop.os_uname().sysname
if sys == "Windows_NT" then
    vim.o.shell = "cmd"
end
vim.g.neovide_transparency = 0.8
vim.g.neovide_floating_blur_amount_x = 2.0
vim.g.neovide_floating_blur_amount_y = 2.0
vim.g.neovide_fullscreen = true
vim.g.neovide_cursor_vfx_mode = "railgun"
vim.o.guifont = "Iosevka:h15"
