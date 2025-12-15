return {
  {
    "folke/tokyonight.nvim",
    lazy = true,
    -- priority = 1000,
    opts = {
      style = "night",
      transparent = false,
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
    "akinsho/bufferline.nvim",
    opts = {
      options = {
        show_buffer_close_icons = false,
        always_show_bufferline = true,
        numbers = "ordinal",
      },
    },
  },
}
