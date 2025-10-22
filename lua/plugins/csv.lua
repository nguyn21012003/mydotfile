return {
  {
    "hat0uma/csvview.nvim",
    cmd = { "CsvViewEnable", "CsvViewDisable" }, -- chỉ load khi gọi lệnh
    config = function()
      require("csvview").setup({
        sticky_header = { enabled = true },
        display_mode = "highlight",
        delimiter = {
          ft = {
            csv = " | ",
            tsv = " | ",
            dat = " | ",
          },
        },
      })
    end,
  },
}
