-- local NS = { noremap = true, silent = true }
--
-- local align = require('align')
--
-- -- Aligns to 1 character
-- vim.keymap.set( 'x', 'aa', function() align.align_to_char({ length = 1, }) end, NS)
--
-- -- Aligns to 2 characters with previews
-- vim.keymap.set( 'x', 'ad', function() align.align_to_char({ preview = true, length = 2, }) end, NS)
--
-- -- Aligns to a string with previews
-- vim.keymap.set( 'x', 'aw', function() align.align_to_string({ preview = true, regex = false, }) end, NS)
--
-- -- Aligns to a Vim regex with previews
-- vim.keymap.set( 'x', 'ar', function() align.align_to_string({ preview = true, regex = true, }) end, NS)
--
-- -- Example gawip to align a paragraph to a string with previews
-- vim.keymap.set( 'n', 'gaw', function() align.operator( align.align_to_string, { regex = false, preview = true, }) end, NS)
--
-- -- Example gaaip to align a paragraph to 1 character
-- vim.keymap.set( 'n', 'gaa', function() align.operator(a.align_to_char) end, NS)
--
--

vim.g.easy_align_delimiters = {
    ['-'] = {
        pattern = '--',
        ignore_groups = { '!Comment' },
        filter = 'g/^.*\\S\\+.*--/',
    },
    ['/'] = {
        pattern = '//',
        ignore_groups = { '!Comment' },
        filter = 'g/^.*\\S\\+.*\\/\\//',
    },
}
