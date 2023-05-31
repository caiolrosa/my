-- Filetype config --
vim.api.nvim_command('autocmd BufNewFile,BufRead .pryrc set filetype=ruby')

vim.cmd('autocmd Filetype typescript setlocal expandtab tabstop=2 shiftwidth=2')
vim.cmd('autocmd Filetype typescriptreact setlocal expandtab tabstop=2 shiftwidth=2')
vim.cmd('autocmd Filetype javascript setlocal expandtab tabstop=2 shiftwidth=2')
vim.cmd('autocmd Filetype javascriptreact setlocal expandtab tabstop=2 shiftwidth=2')

-- Editor config --
vim.o.guicursor = ''
vim.o.mouse = 'a'
vim.o.splitright = true
vim.o.splitbelow = true
vim.wo.relativenumber = true
vim.wo.wrap = false
vim.bo.syntax = 'ON'
vim.opt.termguicolors = true
vim.opt.incsearch = true
vim.opt.updatetime = 50
vim.cmd('filetype plugin indent on')

vim.api.nvim_set_keymap('n', '<C-j>', ':bprevious<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-k>', ':bnext<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-d>', ':bw<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>cf', ':let @+ = expand("%:p")<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<C-S-c>', '"+y', {})
