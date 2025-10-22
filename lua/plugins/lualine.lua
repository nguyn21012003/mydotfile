return {
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy", -- lazy load khi cần
    dependencies = {
      "SmiteshP/nvim-navic",
      "lewis6991/gitsigns.nvim", -- thay git_blame nếu muốn
      "arkav/lualine-lsp-progress", -- nếu bạn dùng lsp_progress plugin
    },
    opts = function()
      local navic = require("nvim-navic")
      local git_blame = require("gitsigns") -- git_blame thay thế
      local colors = {
        yellow = "#ECBE7B",
        cyan = "#008080",
        darkblue = "#081633",
        green = "#98be65",
        orange = "#FF8800",
        violet = "#a9a1e1",
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
          theme = "tokyonight-storm",
          icons_enabled = true,
          component_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },
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
          lualine_a = {
            { "filename", path = 1 },
            {
              function()
                return navic.get_location()
              end,
              cond = function()
                return navic.is_available()
              end,
            },
          },
          lualine_y = {},
        },
        sections = {
          lualine_c = { {} },
          lualine_x = {
            {
              "datetime",
              style = "%a/%d/%m %H:%M",
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
            { progress, color = { fg = colors.magenta, gui = "bold" } },
          },
        },
      }

      -- LSP Progress
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
