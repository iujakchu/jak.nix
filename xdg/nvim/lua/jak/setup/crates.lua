vim.cmd [[
nnoremap <silent> ct :lua require('crates').toggle()<cr>
nnoremap <silent> cr :lua require('crates').reload()<cr>

nnoremap <silent> cv :lua require('crates').show_versions_popup()<cr>
nnoremap <silent> cf :lua require('crates').show_features_popup()<cr>

nnoremap <silent> cu :lua require('crates').update_crate()<cr>
vnoremap <silent> cu :lua require('crates').update_crates()<cr>
nnoremap <silent> ca :lua require('crates').update_all_crates()<cr>
nnoremap <silent> cU :lua require('crates').upgrade_crate()<cr>
vnoremap <silent> cU :lua require('crates').upgrade_crates()<cr>
nnoremap <silent> cA :lua require('crates').upgrade_all_crates()<cr>
]]
require("crates").setup()
