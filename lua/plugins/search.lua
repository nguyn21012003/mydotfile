return {
  {
    "VonHeikemen/searchbox.nvim",
    event = "VeryLazy",
    config = function()
      require("searchbox").setup({
        defaults = {
          reverse = false,
          exact = false,
          prompt = " ",
          modifier = "disabled",
          confirm = "off",
          clear_matches = true,
          show_matches = false,
        },
        popup = {
          relative = "editor",
          position = {
            row = "10%",
            col = "95%",
          },
          size = 40,
          border = {
            style = "rounded",
            text = {
              top = " Search ",
              top_align = "left",
            },
          },
          win_options = {
            winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
          },
        },
      })
    end,
  },
}
