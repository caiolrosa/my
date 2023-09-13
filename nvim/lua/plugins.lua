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
  use 'windwp/nvim-autopairs'
  use 'windwp/nvim-ts-autotag'

  use 'shaunsingh/nord.nvim'

  use 'tpope/vim-surround'
  use 'tpope/vim-fugitive'

  use 'nvim-tree/nvim-web-devicons'

  use { 'hoob3rt/lualine.nvim', requires = { 'nvim-tree/nvim-web-devicons', opt = true } }
  use { 'akinsho/bufferline.nvim', requires = 'nvim-tree/nvim-web-devicons' }
  use { 'nvim-tree/nvim-tree.lua', requires = 'nvim-tree/nvim-web-devicons' }
  use { 'nvim-telescope/telescope.nvim', requires = { 'nvim-lua/plenary.nvim' } }

  use {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'dev-v3',
    requires = {
      {'neovim/nvim-lspconfig'},
      {
        'williamboman/mason.nvim',
        run = function() pcall(vim.cmd, 'MasonUpdate') end
      },
      {'williamboman/mason-lspconfig.nvim'},
      {'hrsh7th/nvim-cmp'},
      {'hrsh7th/cmp-nvim-lsp'},
      {'L3MON4D3/LuaSnip'},
      {'hrsh7th/cmp-buffer'},
      {'hrsh7th/cmp-path'}
    }
  }
end)

require('plugins.colorscheme')
require('plugins.line')
require('plugins.tree')
require('plugins.telescope')
require('plugins.treesitter')
require('plugins.autopairs')
require('plugins.lsp')
