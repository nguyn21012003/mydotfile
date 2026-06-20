return {
	"stevearc/conform.nvim",
	event = "VeryLazy",
	opts = {
		formatters = {
			-- isort = { args = { "--profile", "black" } },
			-- black = { args = { "--fast", "-q", "-l", "120" } },
		},
		formatters_by_ft = {
			-- python = { "black", "ruff_organize_imports" },
			python = { "ruff_format", "ruff_organize_imports" },
			fortran = { "fprettify" },
		},
		-- default_format_opts = { async = true, lsp_fallback = true },
	},
}
