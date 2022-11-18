vim.opt.completeopt = {'menu', 'menuone', 'noselect'}

local lspconfig = require('lspconfig')
local lsp_defaults = lspconfig.util.default_config

lsp_defaults.capabilities = vim.tbl_deep_extend(
  'force',
  lsp_defaults.capabilities,
  require('cmp_nvim_lsp').default_capabilities()
)

vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  callback = function()
    local bufmap = function(mode, lhs, rhs)
      local opts = {buffer = true}
      vim.keymap.set(mode, lhs, rhs, opts)
    end

    bufmap('n', '<leader>gh', '<cmd>lua vim.lsp.buf.hover()<cr>')
    bufmap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<cr>')
    bufmap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<cr>')
    bufmap('n', '<leader>gd', '<cmd>lua vim.lsp.buf.definition()<cr>')
    bufmap('n', '<leader>gD', '<cmd>lua vim.lsp.buf.declaration()<cr>')
    bufmap('n', '<leader>gr', '<cmd>lua vim.lsp.buf.references()<cr>')
    bufmap('n', '<leader>do', '<cmd>lua vim.diagnostic.open_float()<cr>')
    bufmap('n', '<leader>[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>')
    bufmap('n', '<leader>]d', '<cmd>lua vim.diagnostic.goto_next()<cr>')
  end
})

require('lspconfig').gopls.setup{}
require('lspconfig').rust_analyzer.setup{}
require('lspconfig').solargraph.setup{}
require('lspconfig').tsserver.setup{}

require('luasnip.loaders.from_vscode').lazy_load()

local cmp = require('cmp')
local luasnip = require('luasnip')

local select_opts = {behavior = cmp.SelectBehavior.Select}

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end
  },
  sources = {
    { name = 'path' },
    { name = 'nvim_lsp', keyword_length = 3 },
    { name = 'buffer', keyword_length = 3 },
    { name = 'luasnip', keyword_length = 2 },
  },
  window = {
    documentation = cmp.config.window.bordered()
  },
  formatting = {
    format = function(entry, item)
      local menu_icon = {
        nvim_lsp = 'L',
        luasnip = 'S',
        buffer = 'B',
        path = 'P',
      }

      item.menu = menu_icon[entry.source.name]
      return item
    end,
  },
  mapping = {
    ['<C-o>'] = cmp.mapping.complete(),
    ['<Up>'] = cmp.mapping.select_prev_item(select_opts),
    ['<Down>'] = cmp.mapping.select_next_item(select_opts),
    ['<C-k>'] = cmp.mapping.select_prev_item(select_opts),
    ['<C-j>'] = cmp.mapping.select_next_item(select_opts),
    ['<C-l>'] = cmp.mapping.scroll_docs(-4),
    ['<C-m>'] = cmp.mapping.scroll_docs(4),
    ['<TAB>'] = cmp.mapping.confirm({ select = false }),
    ['<CR>'] = cmp.mapping.confirm({ select = false }),
  },
})
