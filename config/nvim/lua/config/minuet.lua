-- minuet AI 补全（本地 llama-server）
require("minuet").setup({
	provider = 'openai_fim_compatible',
	n_completions = 1,        -- 本地模型，只要一条候选
	context_window = 2048,    -- 字符数，小模型别喂太多，减少延迟
	debounce = 300,
	throttle = 800,
	provider_options = {
		openai_fim_compatible = {
			api_key = 'TERM',
			name = 'llama-server',
			end_point = 'http://10.23.50.170:1234/v1/completions',
			model = 'PLACEHOLDER',
			optional = {
				max_tokens = 128,
				top_p = 0.9,
				temperature = 0,
			},
			-- llama.cpp 不支持 suffix 参数，手动拼 FIM 特殊 token
			template = {
				prompt = function(context_before_cursor, context_after_cursor, _)
					return '<|fim_prefix|>'
						.. context_before_cursor
						.. '<|fim_suffix|>'
						.. context_after_cursor
						.. '<|fim_middle|>'
				end,
				suffix = false,
			},
		},
	},
})
