-- 主题
return {
    "folke/tokyonight.nvim",
    lazy = false, -- 确保在启动时候加载
    priority = 1000, -- 确保主题优先加载
    config = function()
        -- 加载主题
        vim.cmd([[colorscheme tokyonight]])
    end,
}
