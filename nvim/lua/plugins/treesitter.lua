require('nvim-treesitter.configs').setup {
  ensure_installed = {
    "ruby",
    "rust",
    "go",
    "javascript",
    "typescript",
    "tsx",
    "hcl",
  },
  highlight = {
    enable = true,
  },
  ident = {
    enable = true,
  }
}
