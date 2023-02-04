local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local cmp = require('cmp')
cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())

local luasnip = require('luasnip')

local select_opts = { behavior = cmp.SelectBehavior.Select }

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end
  },
  sources = {
    { name = 'nvim_lsp', keyword_length = 3 },
    { name = 'luasnip', keyword_length = 2 },
    { name = 'path' },
    { name = 'buffer', keyword_length = 3 },
  },
  window = {
    documentation = cmp.config.window.bordered()
  },
  formatting = {
    format = function(entry, item)
      local kind_icons = {
        Text = "",
        Method = "",
        Function = "",
        Constructor = "",
        Field = "",
        Variable = "",
        Class = "ﴯ",
        Interface = "",
        Module = "",
        Property = "ﰠ",
        Unit = "",
        Value = "",
        Enum = "",
        Keyword = "",
        Snippet = "",
        Color = "",
        File = "",
        Reference = "",
        Folder = "",
        EnumMember = "",
        Constant = "",
        Struct = "",
        Event = "",
        Operator = "",
        TypeParameter = ""
      }
      local menu_icon = {
        nvim_lsp = 'L',
        luasnip = 'S',
        buffer = 'B',
        path = 'P',
      }

      item.kind = string.format('%s %s', kind_icons[item.kind], item.kind)
      item.menu = menu_icon[entry.source.name]
      return item
    end,
  },
  mapping = {
    ['<Up>'] = cmp.mapping.select_prev_item(select_opts),
    ['<Down>'] = cmp.mapping.select_next_item(select_opts),
    ['<C-k>'] = cmp.mapping.select_prev_item(select_opts),
    ['<C-j>'] = cmp.mapping.select_next_item(select_opts),
    ['<C-l>'] = cmp.mapping.scroll_docs(-4),
    ['<C-m>'] = cmp.mapping.scroll_docs(4),
    ['<Tab>'] = cmp.mapping.confirm({ select = true }),
    ['<C-o>'] = cmp.mapping(function(fallback)
      local col = vim.fn.col('.') - 1

      if cmp.visible() then
        cmp.select_next_item(select_opts)
      elseif col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        fallback()
      else
        cmp.complete()
      end
    end, {'i', 's'}),
  },
})
