
local actions = require('telescope.actions')
local telescope = require('telescope')
telescope.setup({
    defaults = {
        mappings = {
            i = {
                ['<C-j>'] = actions.move_selection_next,
                ['<C-k>'] = actions.move_selection_previous,
                ['<esc>'] = actions.close,
            }
        },
        file_ignore_patterns = { 'node_modules', '.git', 'dbdata', '.log'},
        path_display = {'filename_first', 'smart'},
    }
})
telescope.load_extension('live_grep_args')

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<C-p>', builtin.find_files, {})
vim.keymap.set('n', '<C-f>', builtin.live_grep, {})
vim.keymap.set('n', '<S-f>', builtin.grep_string, {})

local expand = vim.fn.expand

-- lua 搜索快捷键
vim.api.nvim_create_autocmd("FileType", {
    pattern = "lua",
    callback = function()
        -- IGG KEYMAPS --
        do
            -- 方法/值定义的地方
            local function find_def()
                local reg = 'function.*[ :.]<cword> *\\(|[ .:^]<cword> *=|message <cword>[ {]'
                local str = string.gsub(reg, '<cword>', vim.fn.expand('<cword>'))
                require('telescope.builtin').live_grep({ default_text = str })
            end
            vim.keymap.set('n', '<C-]>', find_def, {})

            -- 方法调用的地方
            local function find_call()
                local reg = '-P "(?<!function )<cword>\\(.*\\)"'
                local str = string.gsub(reg, '<cword>', vim.fn.expand('<cword>'))
                telescope.extensions.live_grep_args.live_grep_args({ default_text = str })
            end
            vim.keymap.set('n', '<C-\\>', find_call, {})
        end

    end,
})

