return {
  {
    "karb94/neoscroll.nvim",
    event = "VeryLazy", -- chỉ load khi cần (tối ưu khởi động)
    opts = {
      hide_cursor = true,
      stop_eof = true,
      use_local_scrolloff = false,
      respect_scrolloff = false,
      cursor_scrolls_alone = true,
      mappings = {
        "<C-u>",
        "<C-d>",
        "<C-b>",
        "<C-f>",
        "<C-y>",
        "<C-e>",
        "zt",
        "zz",
        "zb",
      },
    },
  },
}
