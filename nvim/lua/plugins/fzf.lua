vim.api.nvim_set_keymap('n', '<C-f>', ':GFiles<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-i>', ':Rg<CR>', { noremap = true, silent = true })
vim.g.fzf_layout = { window = { width = 0.9, height = 0.9 } }
