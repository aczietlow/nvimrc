-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.keymap.set('n', '<leader>pv', vim.cmd.Ex, { desc = 'Navigate back to project file tree' })

-- Execute go file.
vim.keymap.set('n', '<leader>gr', function()
  local file = vim.fn.expand '%'
  local first_line = vim.fn.getline(1)
  if string.match(first_line, '^//') or string.match(file, '%.go$') then
    local escaped_file = vim.fn.shellescape(file)
    vim.cmd 'vsplit'
    vim.cmd('terminal go run ' .. escaped_file)
    -- vim.cmd("startinsert")
  else
    vim.cmd "echo 'Not a Go file.'"
  end
end, { desc = 'Execute current Go file' })
--vim.keymap.set('n', '<leader>pv'vim.cmd.Ex)
