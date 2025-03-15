local map = vim.api.nvim_set_keymap
local fmap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- indent
fmap('n', 'O', function()
    local current_line = vim.fn.line('.')
    vim.api.nvim_command(current_line .. 'put =' .. 'repeat(nr2char(10), 1)')
    vim.api.nvim_win_set_cursor(0, {current_line + 1, 0})
end, opts)
-- by tab
map('v', '<Tab>', '>gv', opts)
map('v', '<S-Tab>', '<gv', opts)
map('n', '<Tab>', '>>', opts)
map('n', '<S-Tab>', '<<', opts)

-- search
-- delete highlight
map("n", "<leader>hh", '<Cmd>nohlsearch<CR>', opts)
