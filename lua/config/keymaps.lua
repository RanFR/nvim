-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.g.mapleader = " "

local keymap = vim.keymap

-- normal mode --
keymap.set("n", "<leader>sv", "<C-w>v") -- vertically split window
keymap.set("n", "<leader>sh", "<C-w>s") -- horizontally split window
