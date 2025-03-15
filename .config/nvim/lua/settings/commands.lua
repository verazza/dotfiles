local diagnostics = require("settings.diagnostics")

-- QuickfixウィンドウにLSPエラーを表示する関数
function ShowLspDiagnosticsInQuickfix()
    vim.diagnostic.setqflist({ severity = vim.diagnostic.severity.ERROR })
end
function CopyLspErrorsToClipboard()
    -- 現在のバッファのエラーを取得
    local diagnostics = vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
    if vim.tbl_isempty(diagnostics) then
        print("No LSP errors found")
        return
    end

    -- エラーを整形
    local errors = {}
    for _, diag in ipairs(diagnostics) do
        table.insert(errors, string.format("%s:%d:%d: %s",
            vim.api.nvim_buf_get_name(0), diag.lnum + 1, diag.col + 1, diag.message))
    end

    -- クリップボードにコピー
    local error_text = table.concat(errors, "\n")
    vim.fn.setreg("+", error_text) -- システムクリップボード("+")にセット
    print("LSP errors copied to clipboard")
end

vim.api.nvim_set_keymap("n", "<leader>fe", "<cmd>lua CopyLspErrorsToClipboard()<CR>", { noremap = true, silent = true })
-- コマンドを定義
vim.api.nvim_create_user_command('LspErrorsQuickfix', 'lua ShowLspDiagnosticsInQuickfix()', {})
-- `:TelescopeDiagnostics` コマンドを作成
vim.api.nvim_create_user_command("LspErrorTelescope", diagnostics.show_error_files, {})
vim.cmd [[
  highlight Normal ctermbg=NONE guibg=NONE
]]
vim.cmd [[
  command! -nargs=* T split | wincmd j | resize 10 | terminal <args>
]]
vim.api.nvim_create_autocmd("TermOpen", {
  callback = function()
    vim.cmd [[ startinsert ]]
  end,
})
