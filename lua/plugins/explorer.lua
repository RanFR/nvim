-- Explorer configuration

-- Explorer - NeoTree
vim.pack.add {
  {
    src = 'https://github.com/nvim-neo-tree/neo-tree.nvim',
    name = 'neo-tree',
  },
  -- dependencies
  {
    src = 'https://github.com/nvim-lua/plenary.nvim',
    name = 'plenary',
  },
  { src = 'https://github.com/MunifTanjim/nui.nvim', name = 'nui' },
  -- optional, but recommended
  {
    src = 'https://github.com/nvim-tree/nvim-web-devicons',
    name = 'nvim-web-devicons',
  },
}
-- NeoTree setup
-- Neo-tree 配置
require('neo-tree').setup {
  filesystem = {
    bind_to_cwd = false,
    follow_current_file = { enabled = true },
    use_libuv_file_watcher = true,
  },
  window = {
    mappings = {
      ['l'] = 'open',
      ['h'] = 'close_node',
      ['<C-e>'] = 'close_window',
      ['p'] = { 'toggle_preview', config = { use_float = false } },
    },
  },
}
-- Ctrl+e: Reveal NeoTree
vim.keymap.set(
  'n',
  '<C-e>',
  '<Cmd>Neotree reveal<CR>',
  { desc = 'NeoTree reveal' }
)
-- Ctrl+b: Toggle NeoTree
vim.keymap.set(
  'n',
  '<C-b>',
  '<Cmd>Neotree toggle<CR>',
  { desc = 'NeoTree toggle' }
)
