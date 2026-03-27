return {
	"mason-org/mason-lspconfig.nvim",
	lazy = true,
	opts = {
		-- ensure_installed = {
		--   -- "ts_ls",
		--   -- "lua_ls",
		--   -- "pyright",
		--   -- "fortls",
		--   -- "tailwindcss",
		--   -- "clangd",
		-- },
	},
	dependencies = {
		{
			"mason-org/mason.nvim",
			opts = {
				ui = {
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗",
					},
					border = "rounded",
				},
			},
		},
		{
			"ray-x/lsp_signature.nvim",
			event = "InsertEnter",
			opts = {
				bind = true,
				floating_window = false,
				handler_opts = { border = "rounded" },
				doc_lines = 10,
				max_height = 8,
				hint_prefix = { above = "↙ ", current = "← ", below = "↖ " },
				hint_scheme = "Comment",
			},
		},
		{
			"rachartier/tiny-inline-diagnostic.nvim",
			event = "VeryLazy",
			priority = 1000,
			config = function()
				require("tiny-inline-diagnostic").setup({ preset = "classic" })
				vim.diagnostic.config({ virtual_text = false }) -- Disable Neovim's default virtual text diagnostics
			end,
		},
		{
			"neovim/nvim-lspconfig",
			lazy = true,
			opts = {
				servers = {
					tailwindcss = {
						filetypes = { "html", "css", "scss", "sass", "typescript", "typescriptreact", "vue" },
						root_markers = {
							"tailwind.config.js",
							"postcss.config.js",
							"package.json",
							".git",
						},
					},
					ruff = {
						on_attach = function(client)
							client.server_capabilities.hoverProvider = false
						end,
						init_options = {
							settings = {
								organizeImports = true,
								lint = {
									select = { "F841", "ARG", "F401", "A", "RUF059", "F", "PTH" },
									ignore = { "PTH123" },
									rule = {
										F841 = "hint",
										F401 = "hint",
										ARG001 = "hint",
										A001 = "warning",
										RUF059 = "hint",
									},
								},
							},
						},
					},
					clangd = {
						cmd = {
							"clangd",
							"--query-driver=C:/Users/Nguyen/scoop/apps/mingw/current/bin/g++.exe",
							"--header-insertion=never",
							"--all-scopes-completion",
						},
					},
					ty = {
						enabled = true,
						on_attach = function(client)
							client.server_capabilities.inlayHintProvider = false
						end,
						settings = {
							ty = {
								diagnostics = {
									disable = { "not-iterable" },
								},
							},
						},
					},
					jedi = {
						enabled = false,
					},
					-- copilot = {},
					fortls = {},
					-- lua_ls = {
					--   root_markers = {
					--     ".git",
					--     "stylua.toml",
					--     ".stylua.toml",
					--     ".luarc.json",
					--     ".luarc.jsonc",
					--     ".luacheckrc",
					--     "selene.toml",
					--     "selene.yml",
					--   },
					--   settings = {
					--     Lua = {
					--       version = "LuaJit",
					--       diagnostics = { globals = { "vim" } },
					--       workspace = {
					--         library = {},
					--         checkThirdParty = false,
					--         ignoreDir = {
					--           "C:/Users/Nguyen/Documents/",
					--           "C:/Users/Nguyen/Downloads/",
					--           "C:/Users/Nguyen/AppData/Roaming/",
					--           "C:/Users/Nguyen/.cache/",
					--           "C:/",
					--         },
					--       },
					--       telemetry = { enable = false },
					--     },
					--   },
					-- },
				},
				diagnostics = {
					virtual_text = false,
					-- virtual_lines = true,
					float = {
						border = "rounded",
						style = "minimal",
						-- source = "always",
					},
				},
			},
		},
	},
}
