return {
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter", "CmdlineEnter" }, -- CmdlineEnterを追加
    dependencies = {
        { "hrsh7th/cmp-nvim-lsp" },
        { "hrsh7th/cmp-vsnip" },
        { "hrsh7th/vim-vsnip" },
        { "hrsh7th/cmp-buffer" }, -- 追加
        { "hrsh7th/cmp-path" },   -- 追加
        { "hrsh7th/cmp-cmdline" }, -- 追加
    },
    opts = function()
        local cmp = require("cmp")
        local conf = {
            sources = cmp.config.sources({ -- sourcesを修正
                { name = "nvim_lsp" },
                { name = "vsnip" },
                { name = "buffer" }, -- 追加
                { name = "path" },   -- 追加
                { name = "cmdline" }, -- こっちへ移動
            }),
            snippet = {
                expand = function(args)
                    -- Comes from vsnip
                    vim.fn["vsnip#anonymous"](args.body)
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ["<Tab>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }), -- 追加
                ["<S-Tab>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }), -- 追加
                ["<C-Space>"] = cmp.mapping.complete(), -- 追加
                ["<CR>"] = cmp.mapping.confirm({ select = true }),
            }),
        }

        cmp.setup.cmdline({ "/", "?" }, {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
                { name = "buffer" },
            },
        })

        cmp.setup.cmdline(":", {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
                { name = "cmdline" },
            },
        })

        return conf
    end
}
