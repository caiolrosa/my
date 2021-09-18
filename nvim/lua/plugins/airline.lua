vim.g.airline_powerline_fonts = true
vim.cmd('let g:airline#extensions#tabline#enabled = 1')
vim.cmd('let g:airline#extensions#tabline#buffer_nr_show = 1')
vim.cmd('let g:airline#extensions#tabline#show_tab_nr = 1')
vim.cmd('let g:airline#extensions#tabline#buffer_idx_mode = 1')
vim.cmd('let g:airline#extensions#branch#enabled=1')
vim.cmd('let g:airline#extensions#ale#enabled = 1')
vim.cmd('let g:airline#extensions#tmuxline#enabled = 1')
vim.cmd('let airline#extensions#tmuxline#snapshot_file = "~/.config/tmux-status.conf"')
vim.api.nvim_set_keymap('n', '<leader>1', '<Plug>AirlineSelectTab1', {})
vim.api.nvim_set_keymap('n', '<leader>2', '<Plug>AirlineSelectTab2', {})
vim.api.nvim_set_keymap('n', '<leader>3', '<Plug>AirlineSelectTab3', {})
vim.api.nvim_set_keymap('n', '<leader>4', '<Plug>AirlineSelectTab4', {})
vim.api.nvim_set_keymap('n', '<leader>5', '<Plug>AirlineSelectTab5', {})
vim.api.nvim_set_keymap('n', '<leader>6', '<Plug>AirlineSelectTab6', {})
vim.api.nvim_set_keymap('n', '<leader>7', '<Plug>AirlineSelectTab7', {})
vim.api.nvim_set_keymap('n', '<leader>8', '<Plug>AirlineSelectTab8', {})
vim.api.nvim_set_keymap('n', '<leader>9', '<Plug>AirlineSelectTab9', {})