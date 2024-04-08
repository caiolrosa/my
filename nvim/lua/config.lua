-- Editor config --
vim.o.guicursor = ''
vim.o.mouse = 'a'
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.scrolloff = 10
vim.o.number = true
vim.o.relativenumber = true
vim.o.wrap = false
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.smartindent = true
vim.o.syntax = 'ON'
vim.o.termguicolors = true
vim.o.incsearch = true
vim.o.updatetime = 50
vim.o.swapfile = false
vim.o.backup = false

vim.cmd('filetype plugin indent on')

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("n", "<C-j>", "<C-d>zz")
vim.keymap.set("n", "<C-k>", "<C-u>zz")

vim.api.nvim_set_keymap('n', '<C-q>', ':bw<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>cf', ':let @+ = expand("%:p")<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<C-S-c>', '"+y', {})

-- Filetype config --
vim.api.nvim_command('autocmd BufNewFile,BufRead .pryrc set filetype=ruby')

vim.cmd('autocmd Filetype typescript setlocal expandtab tabstop=2 shiftwidth=2')
vim.cmd('autocmd Filetype typescriptreact setlocal expandtab tabstop=2 shiftwidth=2')
vim.cmd('autocmd Filetype javascript setlocal expandtab tabstop=2 shiftwidth=2')
vim.cmd('autocmd Filetype javascriptreact setlocal expandtab tabstop=2 shiftwidth=2')
vim.cmd('autocmd Filetype vue setlocal expandtab tabstop=2 shiftwidth=2')

