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
	-- AI 补全（minuet + 本地 llama-server）
	{
		"milanglacier/minuet-ai.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"hrsh7th/nvim-cmp",
		},
		config = function()
			require("config.minuet")
		end,
		event = 'BufEnter',
	},

	-- 语法高亮增强（nvim-treesitter main 分支：master 已归档，不兼容 nvim 0.12 的 capture 语义）
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		lazy = false,
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter").setup()
			require("nvim-treesitter").install({ "c", "lua", "rust" })
			-- main 分支不再负责开启高亮：内置 ftplugin 已覆盖 lua/markdown/help 等，
			-- 这里给 rust 等其余语言补上；已有高亮时不重复启动。
			vim.api.nvim_create_autocmd("FileType", {
				callback = function(args)
					if vim.treesitter.highlighter.active[args.buf] then
						return
					end
					pcall(vim.treesitter.start, args.buf)
				end,
			})
		end,
	},

	-- 滚动时在窗口顶部固定当前区块头（类似 VSCode sticky scroll）
	{
		"nvim-treesitter/nvim-treesitter-context",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		event = "VeryLazy",
		config = function()
			require("config.nvim-treesitter-context")
		end,
	},

	-- LSP 管理
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
    -- 关闭不活跃的 LSP
    {
        "zeioth/garbage-day.nvim",
        dependencies = "neovim/nvim-lspconfig",
        event = "VeryLazy",
        opts = {
            -- your options here
        }
    },

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
    },

    -- 自动保存
    {
        'Pocco81/auto-save.nvim',
        config = function()
            require("auto-save").setup {
                -- your custom configuration
            }
        end
    },
    -- error lens
    {
        'mfussenegger/nvim-lint',
        config = function()
            require('config.nvim-lint')
        end
    },

})

