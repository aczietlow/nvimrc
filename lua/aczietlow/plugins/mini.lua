return { -- Collection of various small independent plugins/modules
  'echasnovski/mini.nvim',
  config = function()
    -- Better Around/Inside textobjects
    --
    -- Examples:
    --  - va)  - [V]isually select [A]round [)]paren
    --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
    --  - ci'  - [C]hange [I]nside [']quote
    require('mini.ai').setup { n_lines = 500 }

    -- Add/delete/replace surroundings (brackets, quotes, etc.)
    --
    -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
    -- - sd'   - [S]urround [D]elete [']quotes
    -- - sr)'  - [S]urround [R]eplace [)] [']
    require('mini.surround').setup()

    require('mini.pairs').setup {
      -- In which modes mappings from this `config` should be created
      modes = { insert = true, command = false, terminal = false },
      mappings = {
        ['('] = false,
        ['['] = false,
        ['{'] = { action = 'open', pair = '{}', neigh_pattern = '[^\\].' },

        [')'] = false,
        [']'] = false,
        ['}'] = { action = 'close', pair = '{}', neigh_pattern = '[^\\].' },

        -- ['"'] = { action = 'closeopen', pair = '""', neigh_pattern = '[^\\].', register = { cr = false } },
        ['"'] = false,
        ["'"] = false,
        ['`'] = false,
      },
    }

    -- Simple and easy statusline.
    --  You could remove this setup call if you don't like it,
    --  and try some other statusline plugin
    local statusline = require 'mini.statusline'
    -- set use_icons to true if you have a Nerd Font
    statusline.setup { use_icons = vim.g.have_nerd_font }

    -- You can configure sections in the statusline by overriding their
    -- default behavior. For example, here we set the section for
    -- cursor location to LINE:COLUMN
    ---@diagnostic disable-next-line: duplicate-set-field
    statusline.section_location = function()
      return '%2l:%-2v'
    end

    ---@diagnostic disable-next-line: duplicate-set-field
    statusline.section_git = function()
      return '%{FugitiveStatusline()}'
    end
  end,
}
