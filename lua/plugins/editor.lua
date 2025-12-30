return {
  {
    "NvChad/nvim-colorizer.lua",
    event = "BufReadPre",
    opts = {
      user_default_options = {
        tailwind = true,
      },
      cmp_docs = { always_update = true },
      filetypes = {
        "!python",
        "!tex",
      },
      buftypes = {
        "*",
        "!prompt",
        "!popup",
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      highlight = {
        -- disable = { "latex", "tex" },
      },
    },
  },
}
