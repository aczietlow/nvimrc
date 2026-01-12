return {
  'norcalli/nvim-colorizer.lua',
  event = 'BufReadPre',
  config = function()
    require('colorizer').setup {
      css = {
        rgb_fn = true, -- rgb(), rgba()
        hsl_fn = true, -- hsl(), hsla()
        names = true, -- "red", "blue"
      },
      html = {
        names = true,
      },
      scss = {
        rgb_fn = true,
        hsl_fn = true,
      },
      -- enable for everything else if you want
      -- '*',
    }
  end,
}
