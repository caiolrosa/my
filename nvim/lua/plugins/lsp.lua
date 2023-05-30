vim.opt.completeopt = {'menu', 'menuone', 'noselect'}

local lspconfig = require('lspconfig')
local lsp_defaults = lspconfig.util.default_config

lsp_defaults.capabilities = vim.tbl_deep_extend(
  'force',
  lsp_defaults.capabilities,
  require('cmp_nvim_lsp').default_capabilities()
)

local lsp_flags = { debounce_text_changes = 150 }
require('lspconfig').gopls.setup{ flags = lsp_flags }
require('lspconfig').rust_analyzer.setup{
  flags = lsp_flags,
  settings = {
    ["rust-analyzer"] = {
      checkOnSave = {
        command = "clippy"
      }
    }
  }
}
require('lspconfig').solargraph.setup{ flags = lsp_flags, formatting = false }
require('lspconfig').tsserver.setup{ flags = lsp_flags }
require('lspconfig').eslint.setup{ flags = lsp_flags }
require('lspconfig').terraformls.setup{ flags = lsp_flags }

require('luasnip.loaders.from_vscode').lazy_load()

vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
  vim.lsp.handlers.hover,
  {border = 'rounded'}
)

vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
  vim.lsp.handlers.signature_help,
  {border = 'rounded'}
)

vim.diagnostic.config({
  virtual_text = true,
  severity_sort = true,
  float = {
    border = 'rounded',
    source = 'always',
    header = '',
    prefix = '',
  },
})

vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.format()]]
vim.api.nvim_set_keymap('n', '<leader>nf', ':set eventignore=BufWritePre<CR>', { noremap = true, silent = true })
