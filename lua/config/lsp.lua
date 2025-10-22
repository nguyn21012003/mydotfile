vim.lsp.config("lua_ls", {
  cmd = { "lua-language-server" },
  filetypes = { "lua" },
  root_markers = {
    ".git",
    "stylua.toml",
    ".stylua.toml",
    ".luarc.json",
    ".luarc.jsonc",
    ".luacheckrc",
    "selene.toml",
    "selene.yml",
  },
})

vim.lsp.enable("lua_ls")
