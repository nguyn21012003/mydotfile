return {
  {
    "NvChad/nvim-colorizer.lua",
    event = "BufReadPre",
    config = function()
      local colorizer = require("colorizer")

      colorizer.setup({
        tailwind = true,
        tailwind_opts = {
          update_names = true,
        },
        filetypes = {
          -- "!python",
          "!typescriptreact",
        },
        buftypes = {
          "*",
          "!prompt",
          "!popup",
        },
        cmp_docs = { always_update = true },
      })

      -- require("smear_cursor").setup({
      --   stiffness = 1.0,
      --   trailing_stiffness = 0.5,
      --   distance_stop_animating = 0.5,
      -- })

      vim.opt.list = true
      vim.opt.listchars = {
        tab = "| ",
        trail = "·",
        extends = "…",
        precedes = "…",
        nbsp = "␣",
      }
    end,
  },
}
