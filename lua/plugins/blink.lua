local icons = {
  Break = "󰙧",
  Call = "󰃷",
  Case = "󰬶",
  Class = "󰠱",
  Color = "󰏘",
  Constant = "󰏿",
  Constructor = "",
  Continue = "󰞘",
  Declaration = "󰙠",
  Delete = "󱟁",
  Enum = "",
  EnumMember = "",
  Event = "",
  Field = "󰇽",
  File = "󰈙",
  Folder = "󰉋",
  Fragment = "",
  Function = "󰊕",
  Implementation = "",
  Interface = "",
  Keyword = "󰌋",
  List = "󰅪",
  Loop = "󰑖",
  Method = "󰆧",
  Module = "",
  Namespace = "󰌗",
  Operator = "󰆕",
  Package = "",
  Property = "󰜢",
  Reference = "",
  Regex = "",
  Snippet = "",
  Statement = "󰅩",
  Struct = "",
  Switch = "",
  Text = "󰉿",
  TypeParameter = "󰅲",
  Undefined = "",
  Unit = "",
  Value = "󰎠",
  Variable = "",
  Macro = "",
  Parameter = "",
  StaticMethod = "",
  Terminal = "",
  TypeAlias = "",
}

return {

  {
    "saghen/blink.cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
      "rafamadriz/friendly-snippets",
      "roobert/tailwindcss-colorizer-cmp.nvim",
      {
        "saghen/blink.compat",
        optional = true, -- make optional so it's only enabled if any extras need it
        opts = {},
        version = not vim.g.lazyvim_blink_main and "*",
      },
    },
    opts = {
      completion = {
        ghost_text = {
          enabled = false,
        },
        menu = {
          auto_show = true,
          scrollbar = false,
          border = "rounded",
          draw = {
            components = {
              kind_icon = {
                text = function(ctx)
                  if require("blink.cmp.sources.lsp.hacks.tailwind").get_hex_color(ctx.item) then
                    return " "
                  end
                  return icons[ctx.kind] .. ctx.icon_gap
                end,
              },
              kind = {
                text = function(ctx)
                  return "" .. ctx.kind .. ""
                end,
              },
              source = {
                width = { max = 30 },
                text = function(ctx)
                  return ({
                    LSP = "[LSP]",
                    Buffer = "[BUF]",
                    Snippets = "[SNIP]",
                    Path = "[PATH]",
                    Spell = "[SPELL]",
                    Cmdline = "[CMD]",
                    Copilot = "[ ]",
                  })[ctx.source_name]
                end,
                highlight = "BlinkCmpDoc",
              },
            },
            columns = { { "label", "label_description", gap = 1 }, { "kind_icon", "kind", gap = 2 }, { "source" } },
          },
        },
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 100,
          update_delay_ms = 50,
          window = { border = "rounded" },
        },
      },
      keymap = {
        preset = "default",
        ["<Tab>"] = { "select_next", "fallback" },
        ["<S-Tab>"] = { "select_prev", "fallback" },
        ["<CR>"] = { "accept", "fallback" },
        ["<Up>"] = { "select_prev", "fallback" },
        ["<Down>"] = { "select_next", "fallback" },
        ["<C-b>"] = { "scroll_documentation_up", "fallback" },
        ["<C-f>"] = { "scroll_documentation_down", "fallback" },
      },
    },
  },
}
