require('autoload_packer')

require('packer').startup(function()
  use 'wbthomason/packer.nvim'

  use 'shaunsingh/nord.nvim'
  use 'edkolev/tmuxline.vim'
  use { 'neoclide/coc.nvim', branch = 'release', run = function() vim.fn['coc#util#install']() end }
  use 'tpope/vim-endwise'
  use 'Raimondi/delimitMate'
  use 'alvan/vim-closetag'
  use 'tpope/vim-fugitive'
  use 'tpope/vim-surround'
  use 'dense-analysis/ale'
  use { 'iamcco/markdown-preview.nvim', run = 'cd app && yarn install' }
  use 'vimwiki/vimwiki'
  use 'mhinz/vim-startify'

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
require('plugins.coc')
require('plugins.treesitter')
require('plugins.vim_close_tag')
require('plugins.startify')
