-- MINI.NVIM configuration

-- Add the mini.nvim plugin
vim.pack.add {
  { src = 'https://github.com/nvim-mini/mini.nvim', name = 'mini' },
}

-- Setup statusline
require('mini.statusline').setup {
  use_icon = vim.g.have_nerd_font,
}

-- Setup pairs
require('mini.pairs').setup()
