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

-- 最近编辑的文件
vim.keymap.set('n', '-', ':MoidayFiles<CR>', opts)

-----------------
-- Visual mode --
-----------------

-- Hint: start visual mode with the same area as the previous area and the same mode
vim.keymap.set('v', '<', '<gv', opts)
vim.keymap.set('v', '>', '>gv', opts)

-- 代码注释
-- <C-_> == (ctrl /)
-- 不知道为啥不能直接用 '/'; (ctrl v) + (ctrl /) 看到的输出是 _
vim.keymap.set('n', '<C-_>', ':normal gcc<CR>', opts)
vim.keymap.set('v', '<C-_>', ':normal gvgc<CR>', opts)
