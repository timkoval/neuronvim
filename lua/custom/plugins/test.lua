-- Testing
return {
  'vim-test/vim-test',
  dependencies = {
    'preservim/vimux', -- for running tests in tmux
  },
  keys = {
    { '<Leader>rs', ':w<CR>:TestSuite<CR>' },
    { '<Leader>rf', ':w<CR>:TestFile<CR>' },
    { '<Leader>rl', ':w<CR>:TestLast<CR>' },
    { '<Leader>rn', ':w<CR>:TestNearest<CR>' },
    { '<Leader>rv', ':w<CR>:TestVisit<CR>' },
  },
  config = function()
    vim.keymap.set('n', '<Leader>rs', ':w<CR>:TestSuite<CR>', { noremap = true, silent = true })
    vim.keymap.set('n', '<Leader>rf', ':w<CR>:TestFile<CR>', { noremap = true, silent = true })
    vim.keymap.set('n', '<Leader>rl', ':w<CR>:TestLast<CR>', { noremap = true, silent = true })
    vim.keymap.set('n', '<Leader>rn', ':w<CR>:TestNearest<CR>', { noremap = true, silent = true })
    vim.keymap.set('n', '<Leader>rv', ':w<CR>:TestVisit<CR>', { noremap = true, silent = true })
    vim.cmd "let test#strategy = 'vimux'" -- Use vimux for running tests in tmux
  end,
}
-- vim: ts=2 sts=2 sw=2 et
