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
        },
        border = "single",
      },
    },
    "neovim/nvim-lspconfig",
  },
}
