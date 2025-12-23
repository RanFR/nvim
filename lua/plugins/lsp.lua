-- LSP

-- Add nvim-lspconfig plugin
vim.pack.add {
  { src = 'https://github.com/neovim/nvim-lspconfig', name = 'nvim-lspconfig' },
}

-- Setup diagnostics
vim.diagnostic.config {
  -- Alternatively, customize specific options
  virtual_lines = {
    -- Only show virtual line diagnostics for the current cursor line
    current_line = true,
  },
}

-- Better handlers for hover and signature help
vim.lsp.handlers['textDocument/hover'] = vim.lsp.handlers.hover
vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.handlers.signature_help

-- Global config for LSP
vim.lsp.config('*', {
  -- Keymaps
  on_attach = function(client, bufnr)
    local bufmap = function(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
    end

    bufmap('n', 'gd', vim.lsp.buf.definition, 'Go to Definition')
    bufmap('n', 'K', vim.lsp.buf.hover, 'Hover Documentation')
    bufmap('n', 'gr', vim.lsp.buf.references, 'References')
    bufmap('n', '<leader>rn', vim.lsp.buf.rename, 'Rename')
    bufmap('n', '<leader>ca', vim.lsp.buf.code_action, 'Code Action')
  end,
})

-- Setup LSP servers
vim.lsp.enable {
  'bashls', -- bash
  'clangd', -- c/c++
  'cmake', -- cmake
  'jsonls', -- json
  'lua_ls', -- lua
  'pyright', -- python
  'yamlls', -- yaml
}
