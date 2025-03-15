require("mason").setup()

require("mason-lspconfig").setup({
    ensure_installed = { "lua_ls", "jdtls", "bashls", "clangd", "ts_ls", "jsonls", "pylsp", "html", },
    automatic_installation = true,
})

require("mason-lspconfig").setup_handlers({
    function (server_name)
        if server_name == "jdtls" then
            -- 以下、javaファイルを開いた際にnvim-metalsを競合しないために必要
            local current_file = vim.api.nvim_buf_get_name(0)
            local current_dir = vim.fn.expand("%:p:h")
            local scala_files = vim.fn.glob(current_dir .. "/**/*.scala", true, true)

            if #scala_files > 0 then
                -- .scalaファイルが存在する場合、jdtlsを起動しない
                return
            end


            require("settings.lsp.env").set_env()
            require('java').setup({})

            require('lspconfig').jdtls.setup({
                -- cmd = { JDTLS_CMD },
                 root_dir = require('lspconfig').util.root_pattern('.git', 'pom.xml', 'build.gradle', 'settings.gradle'),
            })
        elseif server_name == "clangd" then
            require('lspconfig').clangd.setup({
                -- 必要に応じてclangdの設定を追加
                -- 例: コンパイルフラグの指定
                -- cmd = { "clangd", "--compile-flags=-I/usr/local/include" },
            })
        else
            require("lspconfig")[server_name].setup({})
        end
    end,
})

-- 以下は LS から受け取ったエラーなどの診断情報を表示するのに必要
vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    update_in_insert = false,
    underline = true,
    severity_sort = true,
    float = {
        source = "always",
    },
})

