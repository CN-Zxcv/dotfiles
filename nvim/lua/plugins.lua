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
        },
        config = function()
			require("config.nvim-telescope")
        end,
    },
    -- 最近打开的文件
    {
        -- "ThanhKhoaIT/moiday.nvim",
        "cn-zxcv/moiday.nvim",
        config = function()
            require('config.nvim-moiday')
        end,
    },
    {
        "dcampos/nvim-snippy",
        -- config = function()
        --     require('config.nvim-snippy')
        -- end,
    }

})

