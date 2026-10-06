return { -- Higlight, edit, and navigate code
  'nvim-treesitter/nvim-treesitter',
  branch = 'main', -- the rewrite; `master` is the frozen legacy branch
  lazy = false, -- nvim-treesitter `main` does not support lazy-loading
  build = ':TSUpdate',
  -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
  config = function()
    local ts = require 'nvim-treesitter'

    -- WORKAROUND: Command Line Tools 26.6 ship an `ld` that cannot read the
    -- newer MacOSX27.0.sdk that `xcrun` selects by default, so linking every
    -- parser fails. Point the compiler at the SDK matching the linker.
    -- Remove this once `softwareupdate --install "Command Line Tools for Xcode 27.0-27.0"` has run.
    local sdk = '/Library/Developer/CommandLineTools/SDKs/MacOSX26.5.sdk'
    if not vim.env.SDKROOT and vim.uv.fs_stat(sdk) then
      vim.env.SDKROOT = sdk
    end

    ts.setup()

    ts.install {
      'bash',
      'c',
      'diff',
      'html',
      'lua',
      'luadoc',
      'markdown',
      'markdown_inline',
      'query',
      'toml',
      'vim',
      'vimdoc',
      'yaml',
    }

    -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
    --  If you are experiencing weird indenting issues, add the language to
    --  `vim_regex_highlighting` and `indent_disabled` below.
    local vim_regex_highlighting = { 'markdown' }
    local indent_disabled = { 'markdown' }

    -- `main` dropped the module system: highlighting and indentation are now
    -- enabled per buffer, and there is no `auto_install` option.
    local available ---@type string[]?

    vim.api.nvim_create_autocmd('FileType', {
      group = vim.api.nvim_create_augroup('aczietlow-treesitter', { clear = true }),
      callback = function(args)
        local lang = vim.treesitter.language.get_lang(args.match)
        if not lang then
          return
        end

        local function enable()
          if not vim.api.nvim_buf_is_valid(args.buf) or not pcall(vim.treesitter.start, args.buf) then
            return
          end
          if vim.tbl_contains(vim_regex_highlighting, args.match) then
            vim.bo[args.buf].syntax = 'ON'
          end
          if not vim.tbl_contains(indent_disabled, args.match) then
            vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end
        end

        if vim.tbl_contains(ts.get_installed 'parsers', lang) then
          enable()
          return
        end

        -- Stands in for the old `auto_install`: fetch the parser on first use.
        available = available or ts.get_available()
        if vim.tbl_contains(available, lang) then
          ts.install(lang):await(function()
            vim.schedule(enable)
          end)
        end
      end,
    })
  end,
  -- There are additional nvim-treesitter modules that you can use to interact
  -- with nvim-treesitter. You should go explore a few and see what interests you:
  --
  --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
  --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
}
