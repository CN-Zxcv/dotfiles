require("nvim-tree").setup({
    on_attach = function(bufnr)
        local api = require("nvim-tree.api")
        api.config.mappings.default_on_attach(bufnr)
        vim.cmd([[
            :hi NvimTreeExecFile ctermfg=252 ctermbg=234
        ]])
        -- vim.keymap.set('n', '<C-n>', ':NvimTreeToggle<CR>', opts)
    end,
    -- renderer = {
    --     icons = {
    --         glyphs = {
    --             default = "",
    --             -- highlight_opened_files = "name",
    --             folder = {
    --                 arrow_closed = "▶",
    --                 arrow_open = "▼",
    --                 default = "□",
    --                 open = "◰",
    --                 empty = "□",
    --                 empty_open = "□",
    --             },
    --         }         
    --     }
    -- }
})

