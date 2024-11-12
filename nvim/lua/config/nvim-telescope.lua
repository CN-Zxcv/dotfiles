
local actions = require('telescope.actions')
require('telescope').setup({
    defaults = {
        mappings = {
            i = {
                ['<C-j>'] = actions.move_selection_next,
                ['<C-k>'] = actions.move_selection_previous,
            }
        },
        file_ignore_patterns = { 'node_modules', '.git', 'dbdata', '.log'},
        path_display = {'truncate'},

    }
})

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<C-p>', builtin.find_files, {})
vim.keymap.set('n', '<C-f>', builtin.live_grep, {})
vim.keymap.set('n', '<S-f>', builtin.grep_string, {})

local expand = vim.fn.expand

vim.api.nvim_create_autocmd("FileType", {
    pattern = "lua",
    callback = function()
        -- 生成查询代码
        local function makestr(reg)
            local str = string.format([[:lua 
            local reg = '%s'
            local str = string.gsub(reg, '<cword>', vim.fn.expand('<cword>'))
            require('telescope.builtin').live_grep({ default_text = str })
            <CR>]], reg)
            return string.gsub(str, '\n', ' ')
        end

        -- 定义的地方
        local reg = 'function.*[ :.]<cword> *\\\\(|[ .:^]<cword> *=|message <cword>[ {]'
        vim.keymap.set('n', '<C-]>', makestr(reg), {})

        -- 调用的地方
        local reg = '[ .:^]<cword>\\\\(.*\\\\)'
        vim.keymap.set('n', '<C-\\>', makestr(reg), {})

    end,
})

