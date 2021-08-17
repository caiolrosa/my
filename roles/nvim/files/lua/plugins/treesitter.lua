require('nvim-treesitter.configs').setup {
  ensure_installed = { "javascript", "typescript", "tsx" },
  highlight = {
    enable = true,
  },
}
