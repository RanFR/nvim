-- Formatter configuration

-- Conform
vim.pack.add {
  { src = 'https://github.com/stevearc/conform.nvim', name = 'conform' },
}
-- Setup conform
require('conform').setup {
  formatters_by_ft = {
    bash = { 'shfmt' },
    c = { 'clang-format' },
    cpp = { 'clang-format' },
    json = { 'prettier' },
    lua = { 'stylua' },
    python = { 'ruff_format' },
    yaml = { 'prettier' },
    -- Fallback formatters
    ['*'] = { 'trim_whitespace', 'trim_newlines' },
  },
  format_on_save = {
    timeout_ms = 1000,
    lsp_fallback = true,
    async = true,
  },
}
-- Keymap to format manually
vim.keymap.set({ 'n', 'v' }, '<leader>f', function()
  require('conform').format {
    lsp_fallback = true,
    async = true,
    timeout_ms = 1000,
  }
end, { desc = 'Format file' })
