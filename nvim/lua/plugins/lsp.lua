vim.opt.completeopt = {'menu', 'menuone', 'noselect'}

local lsp = require('lsp-zero').preset()

local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local cmp = require('cmp')
cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())

cmp.setup({
  mapping = cmp.mapping.preset.insert({
    ['<Tab>'] = cmp.mapping.confirm({ select = true }),
    ['<CR>'] = cmp.mapping.confirm({ select = true })
  })
})

lsp.on_attach(function(_client, bufnr)
  local opts = { buffer = bufnr, remap = false }

  lsp.default_keymaps({buffer = bufnr})

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

lsp.extend_cmp()

require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = {'tsserver', 'lua_ls'},
  handlers = {
    lsp.default_setup,
    lua_ls = function()
      require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())
    end,
  },
})

lsp.format_on_save({
  format_opts = {
    async = true,
    timemout_ms = 10000
  },
  servers = {
    ['rust_analyzer'] = {'rust'},
    ['standardrb'] = {'ruby'},
    ['tsserver'] = {'javascript', 'typescript', 'typescriptreact'},
  }
})

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
