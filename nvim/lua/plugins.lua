local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	-- 自动补全
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"lspkind.nvim",
			"hrsh7th/cmp-nvim-lsp", -- lsp auto-completion
			"hrsh7th/cmp-buffer", -- buffer auto-completion
			"hrsh7th/cmp-path", -- path auto-completion
			"hrsh7th/cmp-cmdline", -- cmdline auto-completion
			-- "L3MON4D3/LuaSnip",
			"onsails/lspkind.nvim",
            -- 代码片段
            "dcampos/cmp-snippy",
		},
		config = function()
			require("config.nvim-cmp")
		end,
	},
	-- AI 补全
	{
		"Exafunction/codeium.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"hrsh7th/nvim-cmp",
		},
		config = function()
			require("codeium").setup({
			})
		end,
		event = 'BufEnter',
	},

	-- 语法高亮增强
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup {
				ensure_installed = { "c", "lua", "rust" },
				highlight = { enable = true, }
			}
		end
	},

	-- LSP 管理
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",

	-- 主题
	"michalbachowski/vim-wombat256mod",

	-- 侧边文件管理
	{
		"nvim-tree/nvim-tree.lua",
		config = function()
			require("config.nvim-tree")
		end,
	},

    -- 文件搜索
    {
        "nvim-telescope/telescope.nvim",
        dependencies = { 
            'nvim-lua/plenary.nvim', 
            'nvim-telescope/telescope-live-grep-args.nvim', 
            { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
            -- 'smartpde/telescope-recent-files',
            'mollerhoj/telescope-recent-files.nvim',
        },
        config = function()
			require("config.nvim-telescope")
        end,
    },
    {
        "dcampos/nvim-snippy",
        -- config = function()
        --     require('config.nvim-snippy')
        -- end,
    },
    -- 修改默认的注释符号
    -- https://github.com/neovim/neovim/pull/29085
    -- 已经修改了，但是发布版本还没更新, 这里找个插件处理
    {
        "folke/ts-comments.nvim",
        -- opts = {
        --     lang = {
        --
        --     }
        -- },
        event = "VeryLazy",
        enabled = vim.fn.has("nvim-0.10.0") == 1,
    },
    -- 代码对齐
    -- {
    --     "Vonr/align.nvim",
    --     branch = "v2",
    --     lazy = true,
    --     init = function()
    --         require("config.nvim-align")
    --     end
    -- },
    {
        "junegunn/vim-easy-align",
        config = function()
            require('config.nvim-align')
        end,
    }


})

