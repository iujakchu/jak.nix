local cmp = require "cmp"
local luasnip = require "luasnip"
local ls = luasnip
luasnip.config.setup {
    snip_env = {
        s = ls.s,
        sn = ls.sn,
        t = ls.t,
        i = ls.i,
        f = function(func, argnodes, ...)
            return ls.f(function(args, imm_parent, user_args)
                return func(args, imm_parent.snippet, user_args)
            end, argnodes, ...)
        end,
        -- override to enable restore_cursor.
        c = function(pos, nodes, opts)
            opts = opts or {}
            opts.restore_cursor = true
            return ls.c(pos, nodes, opts)
        end,
        d = function(pos, func, argnodes, ...)
            return ls.d(pos, function(args, imm_parent, old_state, ...)
                return func(args, imm_parent.snippet, old_state, ...)
            end, argnodes, ...)
        end,
        isn = require("luasnip.nodes.snippet").ISN,
        l = require("luasnip.extras").lambda,
        dl = require("luasnip.extras").dynamic_lambda,
        rep = require("luasnip.extras").rep,
        r = ls.restore_node,
        p = require("luasnip.extras").partial,
        types = require "luasnip.util.types",
        events = require "luasnip.util.events",
        util = require "luasnip.util.util",
        fmt = require("luasnip.extras.fmt").fmt,
        fmta = require("luasnip.extras.fmt").fmta,
        ls = ls,
        ins_generate = function(nodes)
            return setmetatable(nodes or {}, {
                __index = function(table, key)
                    local indx = tonumber(key)
                    if indx then
                        local val = ls.i(indx)
                        rawset(table, key, val)
                        return val
                    end
                end,
            })
        end,
        parse = ls.parser.parse_snippet,
        n = require("luasnip.extras").nonempty,
        m = require("luasnip.extras").match,
        ai = require "luasnip.nodes.absolute_indexer",
    },
}
local check_backspace = function()
    local col = vim.fn.col "." - 1
    return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
end

--   פּ ﯟ   some other good icons
local kind_icons = {
    Text = "",
    Method = "m",
    Function = "",
    Constructor = "",
    Field = "",
    Variable = "",
    Class = "",
    Interface = "",
    Module = "",
    Property = "",
    Unit = "",
    Value = "",
    Enum = "",
    Keyword = "",
    Snippet = "",
    Color = "",
    File = "",
    Reference = "",
    Folder = "",
    EnumMember = "",
    Constant = "",
    Struct = "",
    Event = "",
    Operator = "",
    TypeParameter = "",
}
-- find more here: https://www.nerdfonts.com/cheat-sheet

cmp.setup {
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body) -- For `luasnip` users.
        end,
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    mapping = {
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        ["<C-n>"] = cmp.mapping.select_next_item(),
        ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
        ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
        ["<C-Space>"] = cmp.config.disable,
        ["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
        ["<C-e>"] = cmp.mapping {
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
        },
        -- Accept currently selected item. If none selected, `select` first item.
        -- Set `select` to `false` to only confirm explicitly selected items.
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.confirm { select = true }
            elseif luasnip.expandable() then
                luasnip.expand()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            elseif check_backspace() then
                fallback()
            else
                fallback()
            end
        end, {
            "i",
            "s",
        }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, {
            "i",
            "s",
        }),
    },
    formatting = {
        fields = { "kind", "abbr", "menu" },
        format = function(entry, vim_item)
            -- Kind icons
            -- vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
            vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
            vim_item.menu = ({
                luasnip = "[Snippet]",
                nvim_lsp = "[LSP]",
                crates = "[crates]",
                buffer = "[Buffer]",
                path = "[Path]",
            })[entry.source.name]
            return vim_item
        end,
    },
    sources = {
        { name = "luasnip" },
        { name = "nvim_lsp" },
        { name = "buffer" },
        { name = "nvim_lua" },
        { name = "path" },
        { name = "crates" },
    },
    confirm_opts = {
        behavior = cmp.ConfirmBehavior.Replace,
        select = false,
    },
    experimental = {
        ghost_text = true,
    },
}
require("luasnip.loaders.from_vscode").lazy_load {}
require("luasnip.loaders.from_lua").lazy_load { paths = vim.fn.stdpath "config" .. "/snippets" }
