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
          pyright = {
            filetypes = { "python" },
            root_markers = {
              ".git",
            } or vim.fn.getcwd(),
            cmd = { "pyright-langserver", "--stdio" },
          },
          clangd = {
            cmd = {
              "clangd",
              "--query-driver=C:/Users/Nguyen/scoop/apps/mingw/current/bin/g++.exe",
              "--header-insertion=never",
              "--all-scopes-completion",
            },
          },
          copilot = {},
          fortls = {},
          lua_ls = {
            root_markers = {
              ".git",
              "stylua.toml",
              ".stylua.toml",
              ".luarc.json",
              ".luarc.jsonc",
              ".luacheckrc",
              "selene.toml",
              "selene.yml",
            },
            settings = {
              Lua = {
                diagnostics = { globals = { "vim" } },
                workspace = {
                  library = {},
                  checkThirdParty = false,
                  ignoreDir = {
                    "C:/Users/Nguyen/Documents/",
                    "C:/Users/Nguyen/Downloads/",
                    "C:/Users/Nguyen/AppData/Roaming/",
                    "C:/Users/Nguyen/.cache/",
                    "C:/",
                  },
                },
                telemetry = { enable = false },
              },
            },
          },
        },
        diagnostics = {
          float = {
            border = "rounded",
            style = "minimal",
            source = "always",
          },
        },
      },
    },
  },
}
