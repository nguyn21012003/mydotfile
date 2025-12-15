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
      },
      buftypes = {
        "*",
        "!prompt",
        "!popup",
      },
    },
  },
}
