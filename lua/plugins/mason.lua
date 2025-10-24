return {
  "mason-org/mason-lspconfig.nvim",
  opts = {
    ensure_installed = {
      "ts_ls",
      "lua_ls",
      "pyright",
      "fortls",
      "tailwindcss",
      "clangd",
    },
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
      "neovim/nvim-lspconfig",
      opts = function(_, opts)
        -- Giữ lại server config cũ
        opts.servers = vim.tbl_extend("force", opts.servers or {}, {
          tailwindcss = {},
          pyright = {},
        })

        -- Thêm style cho cửa sổ diagnostics
        opts.diagnostics = vim.tbl_deep_extend("force", opts.diagnostics or {}, {
          float = {
            border = "rounded",
            style = "minimal",
            source = "always",
          },
        })
      end,
    },
  },
}
