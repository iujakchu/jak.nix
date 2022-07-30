local packer = require "packer"
local plugins = {
    { "wbthomason/packer.nvim" },
    { "tpope/vim-surround" },
    { "tpope/vim-eunuch" },
    { "lewis6991/impatient.nvim" },
    {
        "nvim-neorg/neorg",
        config = function()
            require("neorg").setup {
                load = {
                    ["core.defaults"] = {},
                    ["core.norg.dirman"] = {
                        config = {
                            workspaces = {
                                notes = "~/notes",
                            },
                        },
                    },
                    ["core.gtd.base"] = { config = { workspace = "notes" } },
                    ["core.norg.concealer"] = {},
                    ["core.norg.completion"] = { config = { engine = "nvim-cmp" } },
                    ["core.norg.journal"] = { config = { workspace = "notes" } },
                    ["core.norg.qol.toc"] = {},
                    ["core.presenter"] = { config = { zen_mode = "zen-mode" } },
                    ["core.export.markdown"] = {},
                    ["core.export"] = {},
                    ["external.kanban"] = {},
                },
            }
            vim.keymap.set("n", "\\\\", ":NeorgStart<CR>")
        end,
        requires = { "nvim-lua/plenary.nvim", "nvim-neorg/neorg-telescope", "max397574/neorg-kanban" },
    },
    {
        "feline-nvim/feline.nvim",
        after = "nvim-web-devicons",
        config = function()
            require "jak.setup.statusline"
        end,
    },
    {
        "CRAG666/code_runner.nvim",
        requires = "nvim-lua/plenary.nvim",
        config = function()
            require("code_runner").setup {
                filetype = {
                    python = "python3 -u",
                    typescript = "deno run",
                    rust = "cargo run",
                },
            }
            vim.keymap.set("n", "<C-R>", ":RunCode<CR>", { silent = false })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            require "jak.setup.lspconfig"
        end,
    },
    {
        "hrsh7th/nvim-cmp",
        requires = {
            "neovim/nvim-lspconfig",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-nvim-lua",
            "hrsh7th/nvim-cmp",
            "hrsh7th/cmp-cmdline",
            "Saecki/crates.nvim",
            "f3fora/cmp-spell",
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
            "rafamadriz/friendly-snippets",
        },
        config = function()
            require "jak.setup.cmp"
        end,
    },

    -- TODO:
    {
        "simrat39/rust-tools.nvim",
        ft = "rust",
        config = function()
            require("rust-tools").setup {}
            vim.keymap.set("n", "<leader>rr", require("rust-tools.runnables").runnables)
        end,
    },
    {
        "windwp/nvim-autopairs",
        config = function()
            require("nvim-autopairs").setup { map_cr = true }
        end,
    },

    {
        "mbbill/undotree",
        config = function()
            vim.keymap.set("n", "<leader>u", ":UndotreeToggle<CR>")
        end,
    },
    {
        "mhartington/formatter.nvim",
        config = function()
            require "jak.setup.formatter"
        end,
    },

    {
        "nvim-telescope/telescope.nvim",
        requires = {
            "nvim-lua/plenary.nvim",
            "benfowler/telescope-luasnip.nvim",
            "mrjones2014/tldr.nvim",
            "xiyaowong/telescope-emoji.nvim",
            "AckslD/nvim-neoclip.lua",
            "nvim-telescope/telescope-ui-select.nvim",
            "chip/telescope-software-licenses.nvim",
            "nvim-telescope/telescope-file-browser.nvim",
            "nvim-telescope/telescope-ui-select.nvim",
            "LinArcX/telescope-env.nvim",
            "olacin/telescope-gitmoji.nvim",
            "LinArcX/telescope-ports.nvim",
        },
        config = function()
            require "jak.setup.telescope"
            vim.keymap.set("n", "<leader>ff", function()
                require("telescope.builtin").find_files {
                    require("telescope.themes").get_ivy {},
                    find_command = { "rg", "--hidden", "--glob", "!.git", "--files" },
                }
            end)
            vim.keymap.set("n", "<leader>fs", function()
                require("telescope.builtin").live_grep {
                    require("telescope.themes").get_ivy {},
                    find_command = { "rg", "--hidden", "--glob", "!.git", "--files" },
                }
            end)
            vim.keymap.set("n", "<leader><leader>", ":Telescope help_tags<CR>")
            vim.keymap.set("n", "<leader>n", ":Telescope neoclip<CR>")
            vim.keymap.set("n", "<leader>j", ":Telescope emoji<CR>")
            vim.keymap.set("n", "<leader>,", ":Telescope file_browser<CR>")
            vim.keymap.set("n", "<leader>fp", ":Telescope projects<CR>")
            vim.keymap.set("n", "<leader>fl", ":Telescope software-licenses find<CR>")
            vim.keymap.set("n", "<leader>ft", ":Telescope tldr<CR>")
            vim.keymap.set("v", "<leader>rf", "<ESC>:Telescope refactoring refactors<CR>")
        end,
    },
    {
        "ahmedkhalf/project.nvim",
        config = function()
            require("project_nvim").setup()
        end,
    },
    -- TODO: try this
    {
        "pwntester/octo.nvim",
        requires = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim",
            "kyazdani42/nvim-web-devicons",
        },
        config = function()
            require("octo").setup()
        end,
    },
    {
        "ThePrimeagen/harpoon",
        requires = "nvim-telescope/telescope.nvim",
        config = function()
            vim.keymap.set("n", "ma", require("harpoon.mark").add_file)
            vim.keymap.set("n", "ms", ":Telescope harpoon marks<CR>")
        end,
    },
    {
        "p00f/nvim-ts-rainbow",
        config = function()
            require "jak.setup.nvim-ts-rainbow"
        end,
        requires = { "nvim-treesitter/nvim-treesitter" },
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        config = function()
            require "jak.setup.indent"
        end,
    },
    {
        "numToStr/Comment.nvim",
        config = function()
            require("Comment").setup {
                toggler = {
                    line = "<leader>cc",
                    block = "<leader>cc",
                },
                opleader = {
                    line = "<leader>c",
                    block = "<leader>c",
                },
                extra = {
                    above = "<leader>cO",
                    below = "<leader>co",
                    eol = "<leader>cA",
                },
            }
        end,
    },
    {
        "NvChad/nvim-colorizer.lua",
        config = function()
            require("colorizer").setup()
        end,
    },
    {
        "goolord/alpha-nvim",
        config = function()
            require "jak.setup.alpha"
        end,
    },
    { "nkrkv/nvim-treesitter-rescript" },
    {
        "nvim-treesitter/nvim-treesitter",
        before = "neorg",
        run = ":TSUpdate",
        config = function()
            require "jak.setup.treesitter"
        end,
    },
    --TODO: git scm
    {
        "lewis6991/gitsigns.nvim",
        requires = { "nvim-lua/plenary.nvim" },
        config = function()
            require("gitsigns").setup {
                signs = {
                    add = { hl = "DiffAdd", text = "+", numhl = "GitSignsAddNr" },
                    change = { hl = "DiffChange", text = "👻", numhl = "GitSignsChangeNr" },
                    delete = { hl = "DiffDelete", text = "-", numhl = "GitSignsDeleteNr" },
                    topdelete = { hl = "DiffDelete", text = "😈", numhl = "GitSignsDeleteNr" },
                    changedelete = { hl = "DiffChangeDelete", text = "💩", numhl = "GitSignsChangeNr" },
                },
            }
        end,
    },
    --TODO: how about leap
    {
        "phaazon/hop.nvim",
        config = function()
            vim.keymap.set("n", "<leader>w", "<cmd>HopWord<CR>")
            vim.keymap.set("n", "<leader>l", "<cmd>HopLine<CR>")
            require("hop").setup()
        end,
    },
    {
        "sindrets/diffview.nvim",
        config = function()
            require("diffview").setup()
            vim.keymap.set("n", "\\d", ":DiffviewOpen<CR>")
        end,
    },
    {
        "akinsho/toggleterm.nvim",
        config = function()
            require "jak.setup.toggleterm"
        end,
    },
    --TODO: how about working with neorg?
    {
        "rcarriga/nvim-notify",
        config = function()
            require("notify").setup {
                background_colour = "#000000",
            }
        end,
    },
    { "antoinemadec/FixCursorHold.nvim" },
    {
        "max397574/which-key.nvim",
        config = function()
            require("which-key").setup {
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
            }
        end,
    },
    {
        "akinsho/bufferline.nvim",
        requires = "kyazdani42/nvim-web-devicons",
        config = function()
            vim.keymap.set("n", "<TAB>", ":bnext<CR>")
            vim.keymap.set("n", "<S-TAB>", ":bNext<CR>")
            require("bufferline").setup()
        end,
    },
    -- TODO:
    {
        "saecki/crates.nvim",
        event = { "BufRead Cargo.toml" },
        requires = { { "nvim-lua/plenary.nvim" } },
        config = function()
            require "jak.setup.crates"
        end,
    },
    {
        "weilbith/nvim-code-action-menu",
        cmd = "CodeActionMenu",
        config = function()
            vim.keymap.set("n", "<leader>a", ":CodeActionMenu<CR>")
        end,
    },
    {
        "voldikss/vim-translator",
        config = function()
            vim.keymap.set("", "s", ":TranslateW <CR>")
            require "jak.setup.translator"
        end,
    },
    { "gcmt/wildfire.vim" },
    -- { "stevearc/dressing.nvim" },
    {
        "klen/nvim-test",
        config = function()
            require("nvim-test").setup()
            vim.keymap.set("n", "ts", ":TestSuite<CR>")
        end,
    },
    {
        "ellisonleao/glow.nvim",
        ft = "markdown",
        config = function()
            vim.keymap.set("n", "<leader>pg", ":Glow<CR>", { silent = true })
        end,
    },
    -- TODO: try to use lspsaga's floaterm
    {
        "glepnir/lspsaga.nvim",
        branch = "main",
        config = function()
            local saga = require "lspsaga"
            saga.init_lsp_saga {
                symbol_in_winbar = {
                    in_custom = true,
                    click_support = function(node, clicks, button, modifiers)
                        -- To see all avaiable details: vim.pretty_print(node)
                        local st = node.range.start
                        local en = node.range["end"]
                        if button == "l" then
                            if clicks == 2 then
                            -- double left click to do nothing
                            else -- jump to node's starting line+char
                                vim.fn.cursor(st.line + 1, st.character + 1)
                            end
                        elseif button == "r" then
                            if modifiers == "s" then
                                print "lspsaga" -- shift right click to print "lspsaga"
                            end -- jump to node's ending line+char
                            vim.fn.cursor(en.line + 1, en.character + 1)
                        elseif button == "m" then
                            -- middle click to visual select node
                            vim.fn.cursor(st.line + 1, st.character + 1)
                            vim.cmd "normal v"
                            vim.fn.cursor(en.line + 1, en.character + 1)
                        end
                    end,
                },
            }
            vim.keymap.set("n", "<leader>s", ":LSoutlineToggle<CR>", { silent = true, noremap = true })
        end,
    },
    {
        "folke/trouble.nvim",
        requires = { "kyazdani42/nvim-web-devicons", "folke/lsp-colors.nvim" },
        config = function()
            require("trouble").setup {}
            vim.keymap.set("n", "tt", ":TroubleToggle<CR>")
            vim.keymap.set("n", "td", ":TodoTelescope<CR>")
        end,
    },
    {
        "folke/todo-comments.nvim",
        requires = "nvim-lua/plenary.nvim",
        config = function()
            require "jak.setup.todo-comments"
        end,
    },
    {
        "folke/zen-mode.nvim",
        config = function()
            require("zen-mode").setup {}
        end,
    },
    {
        "anuvyklack/pretty-fold.nvim",
        requires = "anuvyklack/nvim-keymap-amend",
        config = function()
            require("pretty-fold").setup()
        end,
    },
    {
        "anuvyklack/fold-preview.nvim",
        requires = "anuvyklack/keymap-amend.nvim",
        config = function()
            require("fold-preview").setup()
        end,
    },
    -- WARNING: no ready to use
    {
        "mfussenegger/nvim-dap",
        config = function()
            require "jak.setup.dap"
        end,
    },
    {
        "rcarriga/nvim-dap-ui",
        requires = { "mfussenegger/nvim-dap" },
        config = function()
            require("dapui").setup()
        end,
    },
    { "michaelb/sniprun", run = "bash ./install.sh" },
    {
        "nvim-orgmode/orgmode",
        config = function()
            require("orgmode").setup_ts_grammar()
            require("orgmode").setup()
        end,
    },
    { "elkowar/yuck.vim" },
    {
        "RRethy/vim-illuminate",
        config = function()
            vim.api.nvim_set_keymap(
                "n",
                "<C-n>",
                '<cmd>lua require"illuminate".next_reference{wrap=true}<cr>',
                { noremap = true }
            )
            vim.api.nvim_set_keymap(
                "n",
                "<C-p>",
                '<cmd>lua require"illuminate".next_reference{reverse=true,wrap=true}<cr>',
                { noremap = true }
            )
            vim.api.nvim_command [[ hi def link LspReferenceText Search ]]
            vim.api.nvim_command [[ hi def link LspReferenceWrite Search ]]
            vim.api.nvim_command [[ hi def link LspReferenceRead Search ]]
        end,
    },
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v2.x",
        requires = {
            "nvim-lua/plenary.nvim",
            "kyazdani42/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
        },
        config = function()
            vim.keymap.set("n", "<leader>e", ":NeoTreeFloatToggle<CR>")
        end,
    },
    {
        "kevinhwang91/nvim-ufo",
        requires = "kevinhwang91/promise-async",
        config = function()
            vim.keymap.set("n", "zR", require("ufo").openAllFolds)
            vim.keymap.set("n", "zM", require("ufo").closeAllFolds)
            require("ufo").setup {
                provider_selector = function(bufnr, filetype)
                    return { "treesitter", "indent" }
                end,
            }
        end,
    },
    {
        "ThePrimeagen/refactoring.nvim",
        requires = {
            { "nvim-lua/plenary.nvim" },
            { "nvim-treesitter/nvim-treesitter" },
        },
        config = function()
            require("refactoring").setup {
                prompt_func_return_type = {
                    cpp = true,
                    hpp = false,
                    cxx = false,
                },
                prompt_func_param_type = {
                    cpp = true,
                    hpp = false,
                    cxx = false,
                },
                printf_statements = {},
                print_var_statements = {},
            }
        end,
    },
    { "marko-cerovac/material.nvim" },
    {
        "karb94/neoscroll.nvim",
        config = function()
            require("neoscroll").setup()
        end,
    },
    {
        "iamcco/markdown-preview.nvim",
        run = "cd app && npm install",
        setup = function()
            vim.g.mkdp_filetypes = { "markdown" }
            vim.g.mkdp_open_to_the_world = 0
            vim.g.mkdp_browser = "firefox"
            vim.keymap.set("n", "<leader>pp", ":MarkdownPreviewToggle<CR>", { silent = true })
        end,
        ft = { "markdown" },
    },
    {
        "olimorris/persisted.nvim",
        --module = "persisted", -- For lazy loading
        config = function()
            require("persisted").setup {
                save_dir = vim.fn.expand(vim.fn.stdpath "data" .. "/sessions/"), -- directory where session files are saved
                command = "VimLeavePre", -- the autocommand for which the session is saved
                use_git_branch = false, -- create session files based on the branch of the git enabled repository
                autosave = true, -- automatically save session files when exiting Neovim
                autoload = true, -- automatically load the session for the cwd on Neovim startup
                allowed_dirs = nil, -- table of dirs that the plugin will auto-save and auto-load from
                ignored_dirs = nil, -- table of dirs that are ignored when auto-saving and auto-loading
                before_save = nil, -- function to run before the session is saved to disk
                after_save = nil, -- function to run after the session is saved to disk
                after_source = nil, -- function to run after the session is sourced
                telescope = { -- options for the telescope extension
                    before_source = nil, -- function to run before the session is sourced via telescope
                    after_source = nil, -- function to run after the session is sourced via telescope
                },
            }
            require("telescope").load_extension "persisted" -- To load the telescope extension
        end,
    },
    {
        "max397574/colortils.nvim",
        cmd = "Colortils",
        config = function()
            require("colortils").setup()
        end,
    },
    { "famiu/bufdelete.nvim" },
}
packer.startup(function(use)
    for _, v in ipairs(plugins) do
        use(v)
    end
end)
