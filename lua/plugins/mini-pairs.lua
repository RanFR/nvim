-- Auto pairs
return {
    "echasnovski/mini.pairs",
    event = "VeryLazy",
    opts = {
        modes = { insert = true, command = true, terminal = false },
        -- 光标后面如果是这些字符，就跳过自动补全
        skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
        -- 在 treesitter 的 string 节点里禁用补全
        skip_ts = { "string" },
        -- 如果右括号/右引号数量比左边多，就不要补全
        skip_unbalanced = true,
        -- 特别处理 markdown 代码块
        markdown = true,
    },
    config = function(_, opts)
        require("mini.pairs").setup(opts)
    end,
}

