-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.opt.guicursor = { "a:ver25" }
vim.opt.scrolloff = 10

vim.api.nvim_set_keymap("n", "<C-q>", ":bw<CR>", { noremap = true, silent = true })
