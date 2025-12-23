-- Color scheme configuration

-- Add the catppuccin color scheme plugin
vim.pack.add {
  { src = 'https://github.com/catppuccin/nvim', name = 'catppuccin' },
}
-- Set the color scheme
vim.cmd 'colorscheme catppuccin-mocha'
