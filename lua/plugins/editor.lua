return {
  {
    "NvChad/nvim-colorizer.lua",
    event = "BufReadPre",
    opts = {
      user_default_options = {
        tailwind = true,
      },
      cmp_docs = { always_update = true },
    },
    -- config = function()
    --   local colorizer = require("colorizer")
    --
    --   colorizer.setup({
    --     tailwind = true,
    --     tailwind_opts = {
    --       update_names = true,
    --     },
    --     filetypes = {
    --       -- "!python",
    --       "!typescriptreact",
    --     },
    --     buftypes = {
    --       "*",
    --       "!prompt",
    --       "!popup",
    --     },
    --     cmp_docs = { always_update = true },
    --   })
    --   vim.opt.list = true
    --   vim.opt.listchars = {
    --     tab = "| ",
    --     trail = "·",
    --     extends = "…",
    --     precedes = "…",
    --     nbsp = "␣",
    --   }
    -- end,
  },
}
