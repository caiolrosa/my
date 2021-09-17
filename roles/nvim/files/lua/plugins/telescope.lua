local opts = { noremap = true }
vim.api.nvim_set_keymap('n', '<C-f>', '<cmd>Telescope find_files<CR>', opts)
vim.api.nvim_set_keymap('n', '<C-i>', '<cmd>Telescope live_grep<CR>', opts)

local actions = require('telescope.actions')
require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ['<c-j>'] = actions.move_selection_next,
        ['<c-k>'] = actions.move_selection_previous
      }
    }
  }
}
