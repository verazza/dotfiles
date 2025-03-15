local api = require("nvim-tree.api")

local function open_and_return()
    api.node.open.edit()  -- ファイルを開く
    vim.cmd("wincmd p")   -- 直前のウィンドウ（ツリー）に戻る
end

local function my_on_attach(bufnr)
    local function opts(desc)
        return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end

    local map = vim.keymap.set

    -- デフォルトの `on_attach` も実行（必要に応じてカスタマイズ）
    api.config.mappings.default_on_attach(bufnr)

    -- "O" キーに open_and_return をマッピング
    map("n", "O", open_and_return, opts("Open and Return to Tree"))
    -- "z" キーで全フォルダ折りたたみ
    map("n", "z", api.tree.collapse_all, opts("Collapse All"))
end

require("nvim-tree").setup({
    on_attach = my_on_attach,  -- on_attach を指定
    diagnostics = {
        enable = true,  -- LSPの診断情報を有効化
        show_on_dirs = true,  -- ディレクトリにもエラー表示
        debounce_delay = 50,
        icons = {
            hint = "",
            info = "",
            warning = "",
            error = "",
        },
    },
    view = {
        adaptive_size = true,
        width = math.floor(vim.fn.winwidth(0) * 0.15),
        side = "left",
        float = {
            enable = false,
        },
    },
    renderer = {
        group_empty = true -- 空のフォルダをまとめて折りたたむ
    },
})

