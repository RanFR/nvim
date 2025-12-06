-- 主题
return {
    "catppuccin/nvim",
    name="catppuccin", -- 避免名称冲突
    lazy = false, -- 确保在启动时候加载
    priority = 1000, -- 确保主题优先加载
    config = function()
        -- 加载主题
        vim.cmd([[colorscheme catppuccin-mocha]])
    end,
}
