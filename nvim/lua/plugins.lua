require('autoload_packer')
require('packer').startup(function()
  use 'wbthomason/packer.nvim'

  use {
    'nvim-treesitter/nvim-treesitter',
    run = function()
      local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
      ts_update()
    end,
  }
  use 'williamboman/mason.nvim'
  use 'williamboman/mason-lspconfig.nvim'
  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'saadparwaiz1/cmp_luasnip'
  use 'L3MON4D3/LuaSnip'
  use 'windwp/nvim-autopairs'
  use 'windwp/nvim-ts-autotag'
  use { "glepnir/lspsaga.nvim", branch = "main", requires = { { "nvim-tree/nvim-web-devicons" } } }

  use 'shaunsingh/nord.nvim'
  use 'nvim-tree/nvim-web-devicons'

  use 'tpope/vim-surround'
  use 'vimwiki/vimwiki'

  use { 'hoob3rt/lualine.nvim', requires = { 'nvim-tree/nvim-web-devicons', opt = true } }
  use { 'akinsho/bufferline.nvim', requires = 'nvim-tree/nvim-web-devicons' }
  use { 'nvim-tree/nvim-tree.lua', requires = 'nvim-tree/nvim-web-devicons' }
  use { 'nvim-telescope/telescope.nvim', requires = { 'nvim-lua/plenary.nvim' } }

end)

require('plugins.colorscheme')
require('plugins.line')
require('plugins.tree')
require('plugins.telescope')
require('plugins.treesitter')
require('plugins.autopairs')
require('plugins.mason')
require('plugins.lsp')
require('plugins.cmp')
require('plugins.saga')
require('plugins.vimwiki')
