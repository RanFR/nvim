local M = {}
function M.register_keys()
    local wk = require("which-key")

    -- 基础快捷键增强
    wk.add({
        {"<leader>w", ":w<CR>", desc = "保存文件" },
        {"<leader>q", ":q<CR>", desc = "退出文件" },
    })

    -- 屏幕管理
    wk.add({
        {"<leader>s", group = "屏幕管理" },
        {"<leader>s-", ":split<CR>", desc = "水平分屏" },
        {"<leader>s+", ":vsplit<CR>", desc = "垂直分屏" },
        {"<leader>sc", ":close<CR>", desc = "关闭当前分屏" },
        {"<leader>sj", "<C-w>j", desc = "移动到下方窗口" },
        {"<leader>sk", "<C-w>k", desc = "移动到上方窗口" },
        {"<leader>sh", "<C-w>h", desc = "移动到左侧窗口" },
        {"<leader>sl", "<C-w>l", desc = "移动到右侧窗口" },
    })

    -- 文件树切换
    wk.add({
        {"<leader>b", ":NvimTreeToggle<CR>", desc = "切换文件树" },
    })

    -- telescope 模糊搜索
    local telescope = require("telescope.builtin")
    wk.add({
        {"<leader>t", group = "模糊搜索" },
        {"<leader>tf", telescope.find_files, desc = "查找文件" },
        {"<leader>tg", telescope.live_grep, desc = "搜索内容" },
        {"<leader>tb", telescope.buffers, desc = "切换缓冲区" },
    })
end

return M
