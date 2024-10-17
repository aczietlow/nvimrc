return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local harpoon = require 'harpoon'

    harpoon:setup()

    -- basic telescope configuration
    local conf = require('telescope.config').values
    local function toggle_telescope(harpoon_files)
      local file_paths = {}
      for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
      end

      require('telescope.pickers')
        .new({}, {
          prompt_title = 'Harpoon',
          finder = require('telescope.finders').new_table {
            results = file_paths,
          },
          previewer = conf.file_previewer {},
          sorter = conf.generic_sorter {},
        })
        :find()
    end

    vim.keymap.set('n', '<leader>a', function()
      harpoon:list():add()
    end, { desc = 'Harpoon: Add to List' })

    vim.keymap.set('n', '<C-e>', function()
      toggle_telescope(harpoon:list())
    end, { desc = 'Harpoon: List' })

    vim.keymap.set('n', '<C-1>', function()
      harpoon:list():select(1)
    end, { desc = 'Harpoon: Select 1' })
    vim.keymap.set('n', '<C-2>', function()
      harpoon:list():select(2)
    end, { desc = 'Harpoon: Select 2' })
    vim.keymap.set('n', '<C-3>', function()
      harpoon:list():select(3)
    end, { desc = 'Harppon: Select 3' })
    vim.keymap.set('n', '<C-4>', function()
      harpoon:list():select(4)
    end, { desc = 'Harppon: Select 4' })

    --[====[ 
    vim.keymap.set('n', '<leader><C-h>', function()
      harpoon:list():replace_at(1)
    end, { desc = 'Harppon: Replace 1' })
    vim.keymap.set('n', '<leader><C-t>', function()
      harpoon:list():replace_at(2)
    end, { desc = 'Harppon: Replace 2' })
    vim.keymap.set('n', '<leader><C-n>', function()
      harpoon:list():replace_at(3)
    end, { desc = 'Harppon: Replace 3' })
    vim.keymap.set('n', '<leader><C-s>', function()
      harpoon:list():replace_at(4)
    end, { desc = 'Harppon: Replace 4' })
    --]====]
  end,
}
