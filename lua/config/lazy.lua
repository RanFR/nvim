-- 插件管理（lazy.nvim）
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
-- 判断路径是否存在，如果不存在则安装lazy.nvim
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--branch=stable",
    lazyrepo,
    lazypath,
  })
  -- 读取 clone 结果，如果失败则输出错误信息并退出
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- 设定基础配置
require("config.basic")

-- 设置 leader 按键
vim.g.mapleader = " " -- 设置 <leader> 键为空格

-- 设置 lazy.nvim
require("lazy").setup({
    spec = {
        -- 导入插件配置文件
        { import = "plugins" }
    },
    -- 安装插件时的配色方案
    install = { colorscheme = { "tokyonight" } },
    -- 自动检查插件升级
    checker = { enabled = true },
})
