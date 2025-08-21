return {
    -- 语法高亮
    "nvim-treesitter/nvim-treesitter",
    -- 确保安装或更新插件后自动运行命令，语法解析器最新
    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter.configs").setup {
            -- 安装的语言
            ensure_installed = { "bash", "c", "cpp", "lua", "markdown", "python", "yaml" },
            -- 启用高亮
            highlight = { enable = true },
    }
    end
}
