-- 滚动时在窗口顶部固定当前所在区块的头（类似 VSCode 的 sticky scroll）
-- 依赖 nvim-treesitter 的 parser：该语言没有 parser 时不会生效
local context = require("treesitter-context")

context.setup({
	enable = true,          -- 可用 :TSContext enable|disable|toggle 随时开关
	max_lines = 3,          -- 顶部最多显示几行（嵌套多层区块时的上限）
	min_window_height = 0,  -- 窗口矮于多少行时禁用；0 表示不限制
	line_numbers = true,
	multiline_threshold = 20, -- 单个区块头超过多少行就折叠成摘要
	trim_scope = "outer",   -- 超出 max_lines 时优先裁掉最外层
	mode = "topline",        -- 按光标所在位置判断上下文；"topline" 则按窗口首行判断
	separator = nil,        -- 例如 "-" 可在区块头与正文间加一条分隔线
	zindex = 20,
	on_attach = nil,        -- function(bufnr) 返回 false 可让某个 buffer 不启用
})

-- 临时开关
vim.keymap.set("n", "<leader>ut", function()
	context.toggle()
end, { noremap = true, silent = true, desc = "Toggle treesitter context (sticky scroll)" })

-- 跳到当前区块头（默认留空，需要时取消注释自行绑定）
-- vim.keymap.set("n", "<leader>uc", function()
-- 	context.go_to_context()
-- end, { noremap = true, silent = true, desc = "Go to context header" })
