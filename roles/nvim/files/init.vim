let $NVIM_CONFIG_DIR = expand('$HOME/.config/nvim')

if has('nvim-0.5')
  lua require 'init'
else
  source $NVIM_CONFIG_DIR/stable.vim
endif
