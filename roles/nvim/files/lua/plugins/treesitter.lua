require('nvim-treesitter.configs').setup {
  ensure_installed = { "go", "javascript", "typescript", "tsx" },
  highlight = {
    enable = true,
  },
}
