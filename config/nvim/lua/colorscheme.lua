-- define your colorscheme here
-- local colorscheme = 'monokai_pro'
-- local colorscheme = 'wombat_lush'
-- local colorscheme = 'tokyonight-storm'
local colorscheme = 'wombat256mod'

local is_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not is_ok then
    vim.notify('colorscheme ' .. colorscheme .. ' not found!')
    return
end

-- 清除斜体
vim.cmd([[
    highlight Comment gui=none
    highlight String gui=none
    highlight Todo gui=none
    highlight StatusLine gui=none
]])
