return {
  -- { import = "lazyvim.plugins.extras.coding.nvim-cmp" },
  {
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-cmdline",
      "lukas-reineke/cmp-under-comparator",
      "windwp/nvim-autopairs",
      "windwp/nvim-ts-autotag",
      "zbirenbaum/copilot.lua",
      "zbirenbaum/copilot-cmp",
      "roobert/tailwindcss-colorizer-cmp.nvim",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      local compare = require("cmp.config.compare")
      local npairs = require("nvim-autopairs")
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      local tstag = require("nvim-ts-autotag")
      local tailwind_formatter = require("tailwindcss-colorizer-cmp").formatter

      require("copilot_cmp").setup()
      npairs.setup({
        check_ts = true,
        ts_config = { python = { "string" } },
        disable_filetype = { "TelescopePrompt" },
      })
      tstag.setup()

      npairs.add_rules({
        require("nvim-autopairs.rule")("%(.*%)%s*%()$", "", "python"):use_regex(true):set_end_pair_length(0),
      })

      local icons = {
        Text = "󰉿",
        Method = "",
        Function = "",
        Constructor = "",
        Field = "",
        Variable = "",
        Class = "",
        Interface = "",
        Module = "",
        Property = "",
        Unit = "",
        Value = "",
        Enum = "",
        Keyword = "",
        Snippet = "",
        Color = "",
        File = "",
        Reference = "",
        Folder = "",
        EnumMember = "",
        Constant = "",
        Struct = "",
        Event = "",
        Operator = "",
        TypeParameter = "",
        Spell = "",
        copilot = "",
      }

      vim.api.nvim_create_autocmd("ColorScheme", {
        pattern = "*",
        callback = function()
          local kind_colors = {
            Text = "#abb2bf",
            Method = "#61afef",
            Function = "#61afef",
            Constructor = "#61afef",
            Field = "#d19a66",
            Variable = "#ce7c5e",
            Class = "#e5c07b",
            Interface = "#56b6c2",
            Module = "#c678dd",
            Property = "#d19a66",
            Unit = "#56b6c2",
            Value = "#98c379",
            Enum = "#56b6c2",
            Keyword = "#c678dd",
            Snippet = "#abb2bf",
            Color = "#e06c75",
            File = "#61afef",
            Reference = "#98c379",
            Folder = "#61afef",
            EnumMember = "#56b6c2",
            Constant = "#d19a66",
            Struct = "#e5c07b",
            Event = "#d19a66",
            Operator = "#c678dd",
            TypeParameter = "#56b6c2",
            Spell = "#ff6ac1",
          }
          for kind, color in pairs(kind_colors) do
            vim.api.nvim_set_hl(0, "CmpItemKind" .. kind, { fg = color, italic = true })
          end
        end,
      })

      compare.lsp_scores = function(entry1, entry2)
        local diff
        if entry1.completion_item.score and entry2.completion_item.score then
          diff = (entry2.completion_item.score * entry2.score) - (entry1.completion_item.score * entry1.score)
        else
          diff = entry2.score - entry1.score
        end
        return (diff < 0)
      end

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        view = { docs = { auto_open = true } },
        experimental = { ghost_text = false },
        performance = { debounce = 0, throttle = 0 },
        mapping = cmp.mapping.preset.insert({
          ["<Tab>"] = cmp.mapping.select_next_item(),
          ["<S-Tab>"] = cmp.mapping.select_prev_item(),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.confirm({ select = false })
            elseif luasnip.jumpable(1) then
              luasnip.jump(1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp", priority = 1000 },
          { name = "path" },
          { name = "luasnip" },
          { name = "buffer" },
        }),
        sorting = {
          priority_weight = 2,
          comparators = {
            compare.offset,
            compare.exact,
            compare.lsp_scores,
            compare.sort_text,
            compare.score,
            compare.recently_used,
            require("cmp-under-comparator").under,
            compare.kind,
            compare.length,
            compare.order,
          },
        },
        formatting = {
          fields = { "abbr", "kind", "menu" },
          format = function(entry, vim_item)
            vim_item = tailwind_formatter(entry, vim_item)
            local kind = vim_item.kind
            vim_item.kind = string.format(" %s %s", icons[kind] or "󰺴", kind)
            local source = entry.source.name
            vim_item.menu = ({
              nvim_lsp = "[LSP]",
              buffer = "[BUF]",
              luasnip = "[SNIP]",
              cmdline = "[CMD]",
              path = "[PATH]",
              copilot = "[  ]",
              spell = "[SPELL]",
            })[source]
            return vim_item
          end,
        },
        window = {
          completion = cmp.config.window.bordered({
            winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
            max_height = 10,
            min_height = 1,
            scrollbar = false,
            col_offset = -3,
          }),
          documentation = cmp.config.window.bordered({
            winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
            max_height = 10,
            min_height = 1,
            scrollbar = false,
          }),
        },
      })

      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

      -- Command line completion
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "path" },
          { name = "cmdline" },
        },
      })
    end,
  },
}
