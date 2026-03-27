return {
	{
		"folke/snacks.nvim",
		opts = {
			picker = {
				-- layout = {
				-- 	preset = "sidebar",
				-- 	layout = {
				-- 		position = "right",
				-- 	},
				-- },
			},
			dashboard = {
				preset = {
					header = [[
					 ]],
				},
			},
			scroll = {
				enabled = false,
			},
			explorer = {
				enabled = true,
			},
			dim = {
				enabled = false,
			},
			image = {
				enabled = false,
				backend = "kitty",
			},
			terminal = {
				enabled = true,
				size = {
					height = 0.4,
				},
				win = {
					position = "right",
					width = 0.35,
				},
				shell = "nu",
			},
		},
	},
}
