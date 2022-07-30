require("formatter").setup {
    filetype = {
        rust = { -- Rustfmt
            function()
                return { exe = "rustfmt", args = { "--emit=stdout" }, stdin = true }
            end,
        },
        nix = {
            function()
                return { exe = "alejandra", args = { "-q" }, stdin = true }
            end,
        },
        python = {
            function()
                return {
                    exe = "python -m autopep8",
                    args = {
                        "--in-place --aggressive --aggressive",
                        vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)),
                    },
                    stdin = false,
                }
            end,
        },
        lua = { -- luafmt
            function()
                return { exe = "stylua", stdin = false }
            end,
        },
        cpp = { -- clang-format
            function()
                return {
                    exe = "clang-format",
                    args = {
                        '-style="{IndentWidth: 4,TabWidth: 4}"',
                        "--assume-filename",
                        vim.api.nvim_buf_get_name(0),
                    },
                    stdin = true,
                    cwd = vim.fn.expand "%:p:h", -- Run clang-format in cwd of the file.
                }
            end,
        },
        c = { -- clang-format
            function()
                return {
                    exe = "clang-format",
                    args = {
                        '-style="{IndentWidth: 4,TabWidth: 4}"',
                        "--assume-filename",
                        vim.api.nvim_buf_get_name(0),
                    },
                    stdin = true,
                    cwd = vim.fn.expand "%:p:h", -- Run clang-format in cwd of the file.
                }
            end,
        },
        json = {
            -- prettier
            function()
                return {
                    exe = "deno fmt",
                    args = { vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)) },
                    stdin = false,
                }
            end,
        },
        javascript = { -- deno fmt
            function()
                return {
                    exe = "deno fmt",
                    args = { vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)) },
                    stdin = false,
                }
            end,
        },
        typescript = { -- deno fmt
            function()
                return {
                    exe = "deno fmt",
                    args = { vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)) },
                    stdin = false,
                }
            end,
        },
        dart = {
            function()
                return {
                    exe = "dart format",
                    args = { vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)) },
                    stdin = false,
                }
            end,
        },
    },
}

vim.api.nvim_create_augroup("FormatAutogroup", {
    clear = true,
})
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
    pattern = "*.ts,*.js,*.rs,*.lua,*.cpp,*.hpp,*.h,*.c,*.json,*.dart,*.nix",
    command = "FormatWrite",
})
