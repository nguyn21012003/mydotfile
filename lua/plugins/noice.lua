return {
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "rcarriga/nvim-notify",
      "MunifTanjim/nui.nvim",
    },
    config = function()
      local notify_conf = require("notify")
      -- notify_conf.setup({ timeout = 1000, stages = "fade" })

      require("noice").setup({
        notify = {
          enabled = true,
          view = "notify",
          opts = { timeout = 1000 },
        },
        cmdline = {
          enabled = true,
          view = "cmdline_popup",
        },
        presets = {
          command_palette = false,
        },
        messages = {
          enabled = true,
          timeout = 1,
        },
        popupmenu = {
          enabled = true,
          backend = "cmp",
        },
        routes = {
          {
            filter = {
              event = "notify",
              find = "No information available",
            },
            opts = { skip = true },
          },
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
      })
    end,
  },
}
