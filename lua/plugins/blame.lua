return {
  "f-person/git-blame.nvim",
  event = "VeryLazy",
  opts = {
    enabled = true, -- if you want to enable the plugin
    message_template = "<author> • <date> • <summary>",
    date_format = "%d/%m/%Y",
    virtual_text_column = 0,
  },
  enabled = false,
}
