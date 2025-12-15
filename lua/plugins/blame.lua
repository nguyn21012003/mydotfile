return {
  "f-person/git-blame.nvim",
  -- event = "VeryLazy",
  cmd = { "GitBlameEnable", "GitBlameDisable" },
  opts = {
    message_template = "<author> • <date> • <summary>",
    date_format = "%d/%m/%Y",
    virtual_text_column = 0,
  },
}
