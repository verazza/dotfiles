local map = vim.api.nvim_set_keymap
local fmap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- buffer
-- move to the previous/next one
map('n', '<C-j>', '<Cmd>BufferPrevious<CR>', opts)
map('n', '<C-k>', '<Cmd>BufferNext<CR>', opts)
-- move into the previous one
map('n', '<C-H>', '<Cmd>BufferMovePrevious<CR>', opts)
-- move into the next one
map('n', '<C-L>', '<Cmd>BufferMoveNext<CR>', opts)
-- close
map('n', '<leader>ww', '<Cmd>BufferClose<CR>', opts)

-- window
-- close
fmap('n', '<C-w>0', '<Cmd>close<CR>')
-- move by alt key
fmap('n', '<A-Left>', '<C-w>h')
fmap('n', '<A-Down>', '<C-w>j')
fmap('n', '<A-Up>', '<C-w>k')
fmap('n', '<A-Right>', '<C-w>l')

-- tab
fmap('n', '<C-\\><C-_>', function() vim.cmd("tabnext") end, opts)
fmap('t', '<C-\\><C-_>', function() vim.cmd("tabnext") end, opts)
fmap('n', '<C-\\><C-\\>', function() vim.cmd("tabprevious") end, opts)
fmap('t', '<C-\\><C-\\>', function() vim.cmd("tabprevious") end, opts)
fmap('n', '<C-\\><C-w>', function() vim.cmd("tabclose") end, opts)
fmap('t', '<C-\\><C-w>', function() vim.cmd("tabclose") end, opts)
fmap('t', '<C-\\><C-h>', '<C-\\><C-n><C-w>h', opts)
fmap('t', '<C-\\><C-j>', '<C-\\><C-n><C-w>j', opts)
fmap('t', '<C-\\><C-k>', '<C-\\><C-n><C-w>k', opts)
fmap('t', '<C-\\><C-l>', '<C-\\><C-n><C-w>l', opts)

