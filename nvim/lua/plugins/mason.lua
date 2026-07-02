return {
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = vim.tbl_filter(function(p)
        return not vim.tbl_contains({ "shfmt" }, p)
      end, opts.ensure_installed)
    end,
  },
  { "mason-org/mason-lspconfig.nvim" },
}
