return {
	{
		"folke/tokyonight.nvim",
		lazy = true,
		opts = {
			style = "night",
			transparent = true,
			styles = {
				comment = { italic = true },
				floats = "transparent",
				sidebars = "transparent",
			},
			on_highlights = function(hl, c)
				hl.LspKindVariable = { fg = c.orange, italic = true }
				hl.LspKindText = { fg = c.green, italic = false }
			end,
		},
	},
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = {
			"rcarriga/nvim-notify",
			"MunifTanjim/nui.nvim",
		},
		opts = {
			notify = {
				enabled = true,
				view = "notify",
				opts = { timeout = 1000 },
			},
			cmdline = {
				enabled = true,
				view = "cmdline_popup",
				format = {
					cmdline = {
						-- icon = ":",
					},
				},
			},
			presets = {
				command_palette = false,
				bottom_search = false,
			},
			messages = {
				enabled = true,
				timeout = 1,
			},
			popupmenu = {
				enabled = true,
				backend = "cmp",
			},
			lsp = {
				progress = { enabled = true },
				signature = { enabled = false },
				hover = { enabled = true, opts = { border = "rounded" } },
				presets = {
					lsp_doc_border = false,
				},
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
				},
			},
		},
	},
	{
		"akinsho/bufferline.nvim",
		opts = {
			options = {
				show_buffer_close_icons = false,
				always_show_bufferline = true,
				numbers = "ordinal",
			},
		},
	},
	{
		"sphamba/smear-cursor.nvim",
		enabled = false,
		opts = {},
	},
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		enabled = true,
		dependencies = {
			"SmiteshP/nvim-navic",
			"lewis6991/gitsigns.nvim",
			"arkav/lualine-lsp-progress",
		},
		opts = function()
			local navic = require("nvim-navic")
			local git_blame = require("gitsigns")
			local colors = {
				yellow = "#ECBE7B",
				cyan = "#008080",
				darkblue = "#081633",
				green = "#98be65",
				orange = "#FF8800",
				violet = "#1a1b26",
				magenta = "#c678dd",
				blue = "#51afef",
				red = "#ec5f67",
			}

			local progress = function()
				local current_line = vim.fn.line(".")
				local total_lines = vim.fn.line("$")
				local chars = { "__", "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██" }
				local line_ratio = current_line / total_lines
				local index = math.ceil(line_ratio * #chars)
				return chars[index]
			end

			local config = {
				options = {
					disabled_filetypes = {
						statusline = { "NvimTree", "packer", "alpha" },
						winbar = { "help", "qf", "Trouble", "SearchBoxPrompt", "tex" },
					},
					theme = "tokyonight-moon",
					icons_enabled = true,
					component_separators = { left = "", right = "" },
					-- section_separators = { left = "", right = "" },
					section_separators = { left = " ", right = " " },
				},
				inactive_winbar = {},
				inactive_sections = {
					lualine_a = {},
					lualine_b = {},
					lualine_c = { "filename" },
					lualine_x = { "location" },
					lualine_y = {},
					lualine_z = {},
				},
				winbar = {
					-- lualine_a = {
					--   { "filename", path = 1 },
					--   {
					--     function()
					--       return navic.get_location()
					--     end,
					--     cond = function()
					--       return navic.is_available()
					--     end,
					--   },
					-- },
					-- lualine_y = {},
				},
				sections = {
					lualine_c = {
						{
							"selectioncount",
						},
					},
					lualine_x = {
						-- {
						--   "datetime",
						--   style = "%a/%d/%m %H:%M",
						-- },
						{
							"location",
						},
					},
					lualine_y = {
						{
							"filetype",
							colored = true,
							icon_only = true,
						},
					},
					lualine_z = {
						-- { progress, color = { fg = colors.yellow, gui = "bold" } },
						{
							"datetime",
							style = "%a/%d/%m %H:%M",
						},
					},
				},
			}
			table.insert(config.sections.lualine_x, {
				"lsp_progress",
				display_components = { "lsp_client_name", "spinner", { "title", "percentage", "message" } },
				colors = {
					percentage = colors.cyan,
					title = colors.cyan,
					message = colors.cyan,
					spinner = colors.cyan,
					lsp_client_name = colors.magenta,
					use = true,
				},
				separators = {
					component = " ",
					progress = " | ",
					message = { pre = "(", post = ")" },
					percentage = { pre = "", post = "%% " },
					title = { pre = "", post = ": " },
					lsp_client_name = { pre = "[", post = "]" },
					spinner = { pre = "", post = "" },
				},
				timer = { progress_enddelay = 500, spinner = 1000, lsp_client_name_enddelay = 1000 },
				spinner_symbols = { "🌑 ", "🌒 ", "🌓 ", "🌔 ", "🌕 ", "🌖 ", "🌗 ", "🌘 " },
			})

			return config
		end,
	},
}
