return {
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
}
