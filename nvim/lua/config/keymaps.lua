-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.api.nvim_set_keymap("n", "<C-q>", ":bw<CR>", { noremap = true, silent = true })

-- Bufferline --
vim.keymap.set("n", "<leader>b1", "<Cmd>BufferLineGoToBuffer 1<CR>")
vim.keymap.set("n", "<leader>b2", "<Cmd>BufferLineGoToBuffer 2<CR>")
vim.keymap.set("n", "<leader>b3", "<Cmd>BufferLineGoToBuffer 3<CR>")
vim.keymap.set("n", "<leader>b4", "<Cmd>BufferLineGoToBuffer 4<CR>")
vim.keymap.set("n", "<leader>b5", "<Cmd>BufferLineGoToBuffer 5<CR>")
vim.keymap.set("n", "<leader>b6", "<Cmd>BufferLineGoToBuffer 6<CR>")
vim.keymap.set("n", "<leader>b7", "<Cmd>BufferLineGoToBuffer 7<CR>")
vim.keymap.set("n", "<leader>b8", "<Cmd>BufferLineGoToBuffer 8<CR>")
vim.keymap.set("n", "<leader>b9", "<Cmd>BufferLineGoToBuffer 9<CR>")
