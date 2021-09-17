require('nvim-treesitter.configs').setup {
  ensure_installed = {
    "ruby",
    "rust",
    "go",
    "javascript",
    "typescript",
    "tsx",
  },
  highlight = {
    enable = true,
  },
}
