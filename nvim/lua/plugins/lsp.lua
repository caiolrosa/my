vim.opt.completeopt = {'menu', 'menuone', 'noselect'}

local lsp = require('lsp-zero').preset('recommended')
lsp.ensure_installed({
  'tsserver',
  'eslint',
  'lua_ls'
})

local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local cmp = require('cmp')
cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())

local cmp_mappings = lsp.defaults.cmp_mappings({
  ['<Tab>'] = cmp.mapping.confirm({ select = true }),
  ['<CR>'] = cmp.mapping.confirm({ select = true })
})

lsp.setup_nvim_cmp({ mapping = cmp_mappings })

lsp.on_attach(function(_client, bufnr)
  local opts = { buffer = bufnr, remap = false }

  vim.keymap.set('n', 'gd', function() vim.lsp.buf.definition() end, opts)
  vim.keymap.set('n', 'K', function() vim.lsp.buf.hover() end, opts)
  vim.keymap.set('n', '<leader>do', function() vim.diagnostic.open_float() end, opts)
  vim.keymap.set('n', '[d', function() vim.diagnostic.goto_next() end, opts)
  vim.keymap.set('n', ']d', function() vim.diagnostic.goto_prev() end, opts)
  vim.keymap.set('n', '<leader>ac', function() vim.lsp.buf.code_action() end, opts)
  vim.keymap.set('n', '<leader>cr', function() vim.lsp.buf.references() end, opts)
  vim.keymap.set('n', '<leader>rn', function() vim.lsp.buf.rename() end, opts)
  vim.keymap.set('n', '<leader>fm', function() vim.lsp.buf.format() end, opts)
end)

lsp.format_on_save({
  format_opts = {
    async = false,
    timemout_ms = 10000
  },
  servers = {
    ['rust_analyzer'] = {'rust'},
    ['standardrb'] = {'ruby'},
    ['tsserver'] = {'typescript'}
  }
})

require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())
require('lspconfig').rust_analyzer.setup({
  settings = {
    ['rust-analyzer'] = {
      checkOnSave = {
        command = 'clippy'
      },
    },
  },
})

vim.api.nvim_set_keymap('n', '<leader>nf', ':set eventignore=BufWritePre<CR>', { noremap = true, silent = true })
lsp.setup()
