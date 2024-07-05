return {
    -- coding
    { "hrsh7th/nvim-cmp" },

    -- color scheme
    -- add gruvbox
    { "ellisonleao/gruvbox.nvim" },

    -- Configure LazyVim to load gruvbox
    { "LazyVim/LazyVim" },

    -- change trouble config
    { "folke/trouble.nvim", enabled = true },

    -- change some telescope options and a keymap to browse plugin files
    { "nvim-telescope/telescope.nvim" },

    -- nvim lsp config
    { "neovim/nvim-lspconfig" },

    -- add more treesitter parsers
    { "nvim-treesitter/nvim-treesitter", enabled = true },

    -- the opts function can also be used to change the default opts:
    { "nvim-lualine/lualine.nvim" },

    -- add any tools you want to have installed below
    { "williamboman/mason.nvim" },
}
