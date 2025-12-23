-- File searcher configuration

-- Search
-- Add the telescope plugin and its dependency plenary
vim.pack.add {
  {
    src = 'https://github.com/nvim-telescope/telescope.nvim',
    name = 'telescope',
  },
  -- dependency
  {
    src = 'https://github.com/nvim-lua/plenary.nvim',
    name = 'plenary',
  },
}
-- Set keymap for telescope find files
local builtin = require 'telescope.builtin'
vim.keymap.set(
  'n',
  '<C-p>',
  builtin.find_files,
  { desc = 'Telescope find files' }
)
