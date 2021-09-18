vim.g.coc_global_extensions = {
  'coc-sh',
  'coc-yaml',
  'coc-tsserver',
  'coc-solargraph',
  'coc-json',
  'coc-java',
  'coc-go',
  'coc-prettier',
  'coc-eslint',
  'coc-rust-analyzer'
}

vim.g.ale_disable_lsp = true

vim.cmd('inoremap <silent><expr> <c-space> coc#refresh()')

vim.api.nvim_set_keymap('n', 'gd', '<Plug>(coc-definition)', { silent = true })
vim.api.nvim_set_keymap('n', 'gy', '<Plug>(coc-type-definition)', { silent = true })
vim.api.nvim_set_keymap('n', 'gi', '<Plug>(coc-implementation)', { silent = true })
vim.api.nvim_set_keymap('n', 'gr', '<Plug>(coc-references)', { silent = true })
vim.api.nvim_set_keymap('n', '<leader>rn', '<Plug>(coc-rename)', {})
vim.api.nvim_set_keymap('n', '<leader>ac', '<Plug>(coc-codeaction)', {})
vim.api.nvim_set_keymap('n', '<leader>qf', '<Plug>(coc-fix-current)', {})
vim.cmd('inoremap <nowait><expr> <C-f> coc#float#has_scroll() ? "<c-r>=coc#float#scroll(1, 1)<cr>" : "<Right>"')
vim.cmd('inoremap <nowait><expr> <C-b> coc#float#has_scroll() ? "<c-r>=coc#float#scroll(0, 1)<cr>" : "<Left>"')
