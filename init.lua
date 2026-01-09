-- ============================================================================
-- 1. Basic Settings
-- ============================================================================

-- leader key
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- netrw
vim.g.netrw_liststyle = 0 -- thin/long/wide/tree
vim.g.netrw_banner = 0 -- do not display banner

-- line number
vim.o.number = true
vim.o.relativenumber = true

-- enable mouse mode
vim.o.mouse = "a"

-- disable mode show
vim.o.showmode = false

-- clipboard
vim.o.clipboard = vim.env.SSH_CONNECTION and "" or "unnamedplus"

-- enable break indent
vim.o.breakindent = true

-- save undo history
vim.o.undofile = true

-- case-insenstive searching
vim.o.ignorecase = true
vim.o.smartcase = true

-- update time
vim.o.updatetime = 3000

-- mapped sequence wait time
vim.o.timeoutlen = 1500

-- configure how new splits should be opened
vim.o.splitright = true
vim.o.splitbelow = true

-- enable listchars
vim.o.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- show current cursor line
vim.o.cursorline = true

-- minimal number of screen lines to keep above/below/left/right
vim.o.scrolloff = 10
vim.o.sidescrolloff = 8

-- confirm if not saved a file
vim.o.confirm = true

-- wrap
vim.o.wrap = true

-- tab indent
vim.o.tabstop = 2
vim.o.softtabstop = 2

-- tab complete
vim.opt.completeopt = { "menu", "menuone", "noselect" }

-- ============================================================================
-- 2. Helper Functions
-- ============================================================================

-- create self group
local function augroup(name)
  return vim.api.nvim_create_augroup("self_" .. name, { clear = true })
end

-- safe load plugin with pcall protection
local function safe_load(plugin_name)
  local ok, err = pcall(require, plugin_name)
  if not ok then
    vim.notify("Failed to load " .. plugin_name .. ": " .. tostring(err), vim.log.levels.WARN)
    return nil
  end
  return err
end

-- function to cleanup unused plugins
local function pack_clean()
  local active_plugins = {}
  local unused_plugins = {}

  for _, plugin in ipairs(vim.pack.get()) do
    active_plugins[plugin.spec.name] = plugin.active
  end

  for _, plugin in ipairs(vim.pack.get()) do
    if not active_plugins[plugin.spec.name] then
      table.insert(unused_plugins, plugin.spec.name)
    end
  end

  if #unused_plugins == 0 then
    print("No unused plugins.")
    return
  end

  local choice = vim.fn.confirm("Remove unused plugins?\n" .. table.concat(unused_plugins, "\n\n"), "&Yes\n&No", 2)
  if choice == 1 then
    vim.pack.del(unused_plugins)
  end
end

-- function to update plugins
local function pack_update()
  local active_plugins = {}

  for _, plugin in ipairs(vim.pack.get()) do
    if plugin.active then
      table.insert(active_plugins, plugin.spec.name)
    end
  end

  if #active_plugins == 0 then
    print("No active plugins to update.")
    return
  end

  local choice = vim.fn.confirm("Update plugins?\n" .. table.concat(active_plugins, "\n"), "&Yes\n&No", 2)

  if choice == 1 then
    vim.pack.update(active_plugins)
    print("Plugins updated!")
  else
    print("Update cancelled.")
  end
end

-- ============================================================================
-- 3. Plugin Management
-- ============================================================================

-- add plugins
vim.pack.add({
  { src = "https://github.com/catppuccin/nvim", name = "catppuccin.nvim" },
  { src = "https://github.com/nvim-lua/plenary.nvim" },
  { src = "https://github.com/nvim-telescope/telescope.nvim" },
  { src = "https://github.com/mason-org/mason.nvim" },
  { src = "https://github.com/neovim/nvim-lspconfig" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
  { src = "https://github.com/stevearc/conform.nvim" },
  { src = "https://github.com/nvim-lualine/lualine.nvim" },
  { src = "https://github.com/nvim-tree/nvim-web-devicons" },
  { src = "https://github.com/nvim-mini/mini.nvim" },
})

-- ============================================================================
-- 4. Plugin Configuration
-- ============================================================================

-- set colorscheme
vim.cmd.colorscheme("catppuccin-mocha")

-- setup status line
local lualine = safe_load("lualine")
if lualine then
  lualine.setup()
end

-- setup notify
local mini_notify = safe_load("mini.notify")
if mini_notify then
  mini_notify.setup()
end

-- setup starter
local mini_starter = safe_load("mini.starter")
if mini_starter then
  mini_starter.setup({
    evaluate_single = true,
    items = {
      { name = "Find Files", action = "Telescope find_files", section = "Telescope" },
      { name = "Live Grep", action = "Telescope live_grep", section = "Telescope" },
      { name = "Recent Files", action = "Telescope oldfiles", section = "Telescope" },
      { name = "New File", action = "enew", section = "Basic" },
      { name = "Quit", action = "qall", section = "Basic" },
    },
    content_hooks = {
      mini_starter.gen_hook.adding_bullet("» ", false),
      mini_starter.gen_hook.aligning("center", "center"),
    },
    silent = true,
  })
end

-- setup indentscope
local mini_indentscope = safe_load("mini.indentscope")
if mini_indentscope then
  mini_indentscope.setup()
end

-- configure Mason to manage LSP/DAP/Formatter
local mason = safe_load("mason")
if mason then
  mason.setup()
end

-- configure Telescope
local telescope = safe_load("telescope")
if telescope then
  telescope.setup()
end

-- configure mini.comment to set comment keymap
local mini_comment = safe_load("mini.comment")
if mini_comment then
  mini_comment.setup({
    mappings = {
      comment_line = "<Leader>cc",
    },
  })
end

-- ============================================================================
-- 5. Tree-sitter Configuration
-- ============================================================================

-- define Tree-sitter parsers to install
local install_languages = {
  "bash",
  "c",
  "cpp",
  "json",
  "lua",
  "markdown",
  "markdown_inline",
  "python",
  "toml",
  "vim",
  "xml",
  "yaml",
}

-- install Tree-sitter parsers with pcall protection
local treesitter = safe_load("nvim-treesitter")
if treesitter then
  local ok, err = pcall(treesitter.install, install_languages)
  if not ok then
    vim.notify("Failed to install Tree-sitter parsers: " .. tostring(err), vim.log.levels.WARN)
  end
end

-- define Tree-sitter highlight (FileType)
local highlight_languages = {
  "bash",
  "c",
  "cpp",
  "lua",
  "markdown",
  "python",
  "sh",
}
-- create auto highlight based on tree-sitter
vim.api.nvim_create_autocmd("FileType", {
  pattern = highlight_languages,
  callback = function(args)
    vim.treesitter.start(args.buf)
  end,
})

-- ============================================================================
-- 6. LSP Configuration
-- ============================================================================

-- create autocmd of LSP
vim.api.nvim_create_autocmd("LspAttach", {
  group = augroup("lsp"),
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client and client:supports_method("textDocument/completion") then
      vim.lsp.completion.enable(true, client.id, args.buf, {
        autotrigger = true,
      })
    end
  end,
})

-- configure custom LSP keymaps
vim.keymap.set({ "n", "i" }, "<Leader>ca", vim.lsp.buf.code_action, { desc = "Action" })
vim.keymap.set("n", "<Leader>cd", vim.lsp.buf.definition, { desc = "Definition" })
vim.keymap.set("n", "<Leader>cr", vim.lsp.buf.references, { desc = "References" })
vim.keymap.set("n", "<Leader>ci", vim.lsp.buf.implementation, { desc = "Implementation" })
vim.keymap.set("n", "<Leader>ct", vim.lsp.buf.type_definition, { desc = "Type Definition" })
vim.keymap.set("n", "<Leader>ch", vim.lsp.buf.signature_help, { desc = "Signature Help" })

-- enable LSP servers
vim.lsp.enable({
  "bashls",
  "clangd",
  "jsonls",
  "lua_ls",
  "pyright",
  "yamlls",
})
vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" }, -- set vim as global variable
      },
    },
  },
})

-- ============================================================================
-- 7. Auto Format Configuration
-- ============================================================================

-- auto format by conform
local conform = safe_load("conform")
if conform then
  conform.setup({
    formatters_by_ft = {
      bash = { "shfmt" },
      c = { "clang-format" },
      cpp = { "clang-format" },
      json = { "prettier" },
      lua = { "stylua" },
      markdown = { "prettier" },
      python = { "ruff_format" },
      yaml = { "prettier" },
    },
    format_on_save = {
      timeout_ms = 3000,
      lsp_format = "fallback",
    },
  })
  vim.api.nvim_create_autocmd("BufWritePre", {
    group = augroup("format_on_save"),
    pattern = "*",
    callback = function(args)
      conform.format({ bufnr = args.buf })
    end,
  })
end

-- ============================================================================
-- 8. Autocommands
-- ============================================================================

-- check if we need to reload the file when it changed
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
  group = augroup("checktime"),
  callback = function()
    if vim.o.buftype ~= "nofile" then
      vim.cmd("checktime")
    end
  end,
})

-- highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup("highlight_yank"),
  callback = function()
    (vim.hl or vim.highlight).on_yank()
  end,
})

-- close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("close_with_q"),
  pattern = {
    "checkhealth",
    "help",
    "lspinfo",
    "nvim-pack",
    "qf",
    "TelescopePrompt",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.schedule(function()
      vim.keymap.set("n", "q", function()
        vim.cmd("close")
        pcall(vim.api.nvim_buf_delete, event.buf, { force = true })
      end, {
        buffer = event.buf,
        silent = true,
      })
    end)
  end,
})

-- ============================================================================
-- 9. Filetype Configuration
-- ============================================================================

-- treat .launch files as xml
vim.filetype.add({
  extension = {
    launch = "xml",
  },
})

-- ============================================================================
-- 10. Keymaps
-- ============================================================================

local map = vim.keymap.set
local telescope_builtin = safe_load("telescope.builtin")

-- better up/down
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })
map({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })

-- move to window using the <Ctrl> hjkl keys
map("n", "<C-h>", "<C-w>h", { desc = "Window Left", remap = true })
map("n", "<C-j>", "<C-w>j", { desc = "Window Down", remap = true })
map("n", "<C-k>", "<C-w>k", { desc = "Window Up", remap = true })
map("n", "<C-l>", "<C-w>l", { desc = "Window Right", remap = true })

-- move lines
map("n", "<A-j>", "<Cmd>execute 'move .+' . v:count1<CR>==", { desc = "Line Move Down" })
map("n", "<A-k>", "<Cmd>execute 'move .-' . (v:count1 + 1)<CR>==", { desc = "Line Move Up" })
map("i", "<A-k>", "<Esc><Cmd>m .-2<CR>==gi", { desc = "Line Move Up" })
map("i", "<A-j>", "<Esc><Cmd>m .+1<CR>==gi", { desc = "Line Move Down" })
map("v", "<A-j>", ":<C-u>execute \"'<,'>move '>+\" . v:count1<CR>gv=gv", { desc = "Line Move Down" })
map("v", "<A-k>", ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", { desc = "Line Move Up" })

-- buffers
map("n", "<S-h>", "<Cmd>bprevious<CR>", { desc = "Previous Buffer" })
map("n", "<S-l>", "<Cmd>bnext<CR>", { desc = "Next Buffer" })
map("n", "<Leader>bb", "<Cmd>e #<CR>", { desc = "Alternate Buffer" })
map("n", "<Leader>bd", "<Cmd>bdelete<CR>", { desc = "Delete Buffer" })

-- delete all buffers except current
local function delete_other_buffers()
  local current_buf = vim.api.nvim_get_current_buf()
  local buffers = vim.api.nvim_list_bufs()
  for _, buf in ipairs(buffers) do
    if buf ~= current_buf and vim.api.nvim_buf_is_loaded(buf) then
      vim.api.nvim_buf_delete(buf, { force = true })
    end
  end
end
map("n", "<Leader>bo", delete_other_buffers, { desc = "Delete Other Buffers" })

-- plugin management
map("n", "<Leader>pc", pack_clean, { desc = "Plugins Clean" })
map("n", "<Leader>pu", pack_update, { desc = "Plugins Update" })

-- clear search, diff update and redraw
map("n", "<Leader>ur", "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>", { desc = "Clear Search & Diff" })
map("n", "<Leader>uh", "<Cmd>nohlsearch<CR>", { desc = "Clear Search" })

-- save files
map({ "i", "x", "n", "s" }, "<C-s>", "<Cmd>w<CR><Esc>", { desc = "Save File" })

-- find files by telescope
if telescope_builtin then
  map("n", "<Leader>ff", telescope_builtin.find_files, { desc = "Find Files" })
  map("n", "<Leader>fg", telescope_builtin.live_grep, { desc = "Live Grep" })
  map("n", "<Leader>fk", telescope_builtin.keymaps, { desc = "Keymaps" })
  map("n", "<Leader>fs", telescope_builtin.grep_string, { desc = "Grep String" })
end

-- quick press jk as <Esc>
map("i", "jk", "<Esc>", { desc = "Escape" })

-- write file
map({ "n", "i" }, "<Leader>w", "<Esc><Cmd>write<CR>", { desc = "Write" })
map("n", "<Leader>q", "<Cmd>quit<CR>", { desc = "Quit" })

-- open Explore
map("n", "<Leader>e", "<Cmd>Explore<CR>", { desc = "Open Explore" })
