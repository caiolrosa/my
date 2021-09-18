vim.g.NERDTreeShowHidden = true
vim.cmd('autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif')
vim.api.nvim_set_keymap('n', '<C-n>', ':NERDTreeToggle<CR>', {})
vim.api.nvim_set_keymap('n', '<C-m>', ':NERDTreeFind<CR>', {})
