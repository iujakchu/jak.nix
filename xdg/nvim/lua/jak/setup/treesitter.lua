local parser_configs = require("nvim-treesitter.parsers").get_parser_configs()
parser_configs.norg_meta = {
    install_info = {
        url = "https://github.com/nvim-neorg/tree-sitter-norg-meta",
        files = { "src/parser.c" },
        branch = "main",
    },
}

parser_configs.norg_table = {
    install_info = {
        url = "https://github.com/nvim-neorg/tree-sitter-norg-table",
        files = { "src/parser.c" },
        branch = "main",
    },
}

require("nvim-treesitter.configs").setup {
    ensure_installed = {
        "rust",
        "haskell",
        "fish",
        "javascript",
        "typescript",
        "markdown",
        "org",
        "c",
        "cpp",
        "slint",
        "dart",
        "lua",
        "python",
        "yaml",
        "fennel",
        "nix",
        "cpp",
        "norg",
        "norg_meta",
        "norg_table",
        "glsl",
        "scheme",
        "qmljs",
    }, --
    sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
    ignore_install = { "" }, -- List of parsers to ignore installing
    autopairs = {
        enable = true,
    },
    highlight = {
        enable = true, -- false will disable the whole extension
        disable = { "" }, -- list of language that will be disabled
        additional_vim_regex_highlighting = true,
    },
    indent = { enable = true },
    context_commentstring = {
        enable = true,
        enable_autocmd = false,
    }, --
}
