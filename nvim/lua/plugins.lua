require('autoload_packer')

require('packer').startup(function()
  use 'wbthomason/packer.nvim'

  use 'williamboman/mason.nvim'
  use "williamboman/mason-lspconfig.nvim"
  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'saadparwaiz1/cmp_luasnip'
  use 'L3MON4D3/LuaSnip'

  use 'shaunsingh/nord.nvim'
  use 'kyazdani42/nvim-web-devicons'

  -- use { 'neoclide/coc.nvim', branch = 'release', run = function() vim.fn['coc#util#install']() end }
  -- use 'dense-analysis/ale'

  use 'tpope/vim-endwise'
  use 'Raimondi/delimitMate'
  use 'alvan/vim-closetag'
  use 'tpope/vim-fugitive'
  use 'tpope/vim-surround'
  use { 'iamcco/markdown-preview.nvim', run = 'cd app && yarn install' }
  use 'vimwiki/vimwiki'

  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use { 'hoob3rt/lualine.nvim', requires = { 'kyazdani42/nvim-web-devicons', opt = true } }
  use { 'akinsho/bufferline.nvim', requires = 'kyazdani42/nvim-web-devicons' }
  use { 'kyazdani42/nvim-tree.lua', requires = 'kyazdani42/nvim-web-devicons' }
  use { 'nvim-telescope/telescope.nvim', requires = { 'nvim-lua/plenary.nvim' } }

end)

require('plugins.colorscheme')
require('plugins.line')
require('plugins.tree')
require('plugins.telescope')
-- require('plugins.coc')
require('plugins.mason')
require('plugins.lsp')
require('plugins.treesitter')
require('plugins.vim_close_tag')
