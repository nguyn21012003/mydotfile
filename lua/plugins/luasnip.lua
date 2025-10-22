return {
  {
    "L3MON4D3/LuaSnip",
    event = "VeryLazy", -- lazy load
    dependencies = {
      "rafamadriz/friendly-snippets", -- nếu muốn dùng snippets có sẵn
    },
    config = function()
      local luasnip = require("luasnip")

      require("luasnip.loaders.from_snipmate").lazy_load({
        paths = { vim.fn.stdpath("config") .. "/snippets" },
      })
    end,
  },
}
