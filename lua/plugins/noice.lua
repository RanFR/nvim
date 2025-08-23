-- UI 增强
return {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
        "MunifTanjim/nui.nvim",
        "rcarriga/nvim-notify",
    },
    config = function()
        require("noice").setup({
            cmdline = {
                enabled = true,
                view = "cmdline_popup", -- 命令行弹窗样式
                format = {
                    cmdline = { icon = "" },
                    search_down = { kind = "search", pattern = "/ ", icon = " " },
                    search_up = { kind = "search", pattern = "\\? ", icon = " " },
                },
            },
            messages = { enabled = true },
            popupmenu = { enabled = true },
        })
    end,
}

