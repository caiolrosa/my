require('autoload_packer')

require('packer').startup(function()
  use 'wbthomason/packer.nvim'

  use 'preservim/nerdtree'
  use 'Xuyuanp/nerdtree-git-plugin'
  use 'tiagofumo/vim-nerdtree-syntax-highlight'
  use 'ryanoasis/vim-devicons'
  use { 'junegunn/fzf', run = function() vim.fn['fzf#install']() end }
  use 'junegunn/fzf.vim'
  use 'arcticicestudio/nord-vim'
  use 'vim-airline/vim-airline'
  use 'edkolev/tmuxline.vim'
  use { 'neoclide/coc.nvim', branch = 'release', run = function() vim.fn['coc#util#install']() end }
  use 'tpope/vim-endwise'
  use 'leafgarland/typescript-vim'
  use 'peitalin/vim-jsx-typescript'
  use { 'styled-components/vim-styled-components', branch = 'main' }
  use 'jparise/vim-graphql'
  use 'Raimondi/delimitMate'
  use 'alvan/vim-closetag'
  use 'tpope/vim-fugitive'
  use 'tpope/vim-surround'
  use 'dense-analysis/ale'
  use { 'iamcco/markdown-preview.nvim', run = 'cd app && yarn install' }
  use 'vimwiki/vimwiki'
  use 'mhinz/vim-startify'

  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

end)

require('plugins.airline')
require('plugins.coc')
require('plugins.fzf')
require('plugins.nerd_tree')
require('plugins.treesitter')
require('plugins.vim_close_tag')
require('plugins.startify')
