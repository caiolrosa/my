require('nvim-tree').setup()
local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap('n', '<C-n>', ':NvimTreeToggle<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>r', ':NvimTreeRefresh<CR>', opts)
vim.api.nvim_set_keymap('n', '<C-l>', ':NvimTreeFindFile<CR>', opts)

vim.g.nvim_tree_quit_on_open = 1
vim.g.nvim_tree_git_hl = 1
