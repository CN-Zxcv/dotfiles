-- define common options
local opts = {
    noremap = true,      -- non-recursive
    silent = true,       -- do not show message
}

-----------------
-- Normal mode --
-----------------

-- Hint: see `:h vim.map.set()`
-- Better window navigation
vim.keymap.set('n', '<C-h>', '<C-w>h', opts)
vim.keymap.set('n', '<C-j>', '<C-w>j', opts)
vim.keymap.set('n', '<C-k>', '<C-w>k', opts)
vim.keymap.set('n', '<C-l>', '<C-w>l', opts)

-- Resize with arrows
-- delta: 2 lines
vim.keymap.set('n', '<C-Up>', ':resize -2<CR>', opts)
vim.keymap.set('n', '<C-Down>', ':resize +2<CR>', opts)
vim.keymap.set('n', '<C-Left>', ':vertical resize -2<CR>', opts)
vim.keymap.set('n', '<C-Right>', ':vertical resize +2<CR>', opts)

-- nvim-tree
vim.keymap.set('n', '<C-n>', ':NvimTreeFindFileToggle<CR>', opts)

-----------------
-- Visual mode --
-----------------

-- Hint: start visual mode with the same area as the previous area and the same mode
vim.keymap.set('v', '<', '<gv', opts)
vim.keymap.set('v', '>', '>gv', opts)

-- 代码注释
-- <C-_> == (ctrl /) 传统终端发送的字节是 0x1F
-- 新版 nvim(0.9+) + Windows Terminal 走 CSI-u, 会识别为独立的 <C-/>
-- 两种都绑上, 保证在 VM 和 WSL 都能生效
vim.keymap.set('n', '<C-_>', ':normal gcc<CR>', opts)
vim.keymap.set('v', '<C-_>', '<Esc>:normal gvgc<CR>', opts)
vim.keymap.set('n', '<C-/>', ':normal gcc<CR>', opts)
vim.keymap.set('v', '<C-/>', '<Esc>:normal gvgc<CR>', opts)
