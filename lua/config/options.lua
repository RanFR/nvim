-- Options

-- Line numbers
vim.o.number = true
vim.o.relativenumber = true

-- Mouse and mode display
vim.o.mouse = 'a'
vim.o.showmode = false

-- Clipboard
vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)

-- Indentation
vim.o.breakindent = true
vim.opt.tabstop = 2
vim.opt.autoindent = true
vim.opt.smartindent = true

-- Persistence
vim.o.undofile = true

-- Search
vim.o.ignorecase = true
vim.o.smartcase = true

-- UI
vim.o.signcolumn = 'yes'
vim.o.updatetime = 3000 -- ms
vim.o.timeoutlen = 1000 -- ms
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.o.inccommand = 'split'
vim.o.cursorline = true
vim.o.scrolloff = 10
vim.o.confirm = true
