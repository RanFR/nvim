-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local opt = vim.opt

-- font
opt.guifont = { "Cascadia Code NF", "HarmonyOS Sans SC" }

-- line number
opt.relativenumber = true
opt.number = true

-- indentation
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = true

-- wrap
opt.wrap = false

-- cursor
opt.cursorline = true

-- set default window right below
opt.splitright = true
opt.splitbelow = true

-- appearance
opt.termguicolors = true
opt.signcolumn = "yes"
