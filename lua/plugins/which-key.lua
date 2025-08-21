-- 快捷键查看
return {
  "folke/which-key.nvim",
  dependencies = { "echasnovski/mini.icons" },
  event = "VeryLazy",
  config = function()
    -- 加载按键映射配置
    require("config.keymap").register_keys()
  end,
}
