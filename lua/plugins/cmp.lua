return {
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
      local npairs = require("nvim-autopairs")
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      local Rule = require("nvim-autopairs.rule")
      local luasnip = require("luasnip")
      local tailwind_formatter = require("tailwindcss-colorizer-cmp").formatter
      local tstag = require("nvim-ts-autotag")
      local compare = require("cmp.config.compare")
      -- local copilot = require("copilot_cmp")
      local icons = {
        Text = "",
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
      }
      vim.api.nvim_create_autocmd("User", {
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

      -- copilot.setup()

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
        performance = {
          debounce = 0,
          throttle = 0,
        },
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
          -- { name = "copilot", priority = 1000 },
          { name = "path" },
          { name = "luasnip" },
          { name = "buffer" },
          -- {
          -- 	name = "buffer",
          -- 	option = {
          -- 		get_bufnrs = function()
          -- 			return vim.api.nvim_buf_line_count(0) < 15000 and vim.api.nvim_list_bufs() or {}
          -- 		end,
          -- 	},
          -- },
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
            if source == "spell" then
              vim_item.kind = "Spell"
            end
            local function trim(text)
              local max = 40
              if text and text:len() > max then
                text = text:sub(1, max) .. "..."
              end
              return text
            end

            vim_item.menu = ({
              nvim_lsp = "[LSP]",
              buffer = "[BUF]",
              luasnip = "[SNIP]",
              cmdline = "[CMD]",
              path = "[PATH]",
              copilot = "[]",
              latex_symbols = "[LTEX]",
              spell = "[SPELL]",
            })[source]
            if
              source == "vsnip"
              or source == "cmdline"
              or source == "buffer"
              or source == "luasnip"
              or source == "nvim_lsp"
            then
              vim_item.dup = 0
            end
            return vim_item
          end,
        },
        window = {
          completion = cmp.config.window.bordered({
            -- winhighlight = "Normal:Pmenu,CursorLine:PmenuSel,Search:PmenuSel",
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
      cmp.setup.filetype("python", {
        view = {
          docs = { auto_open = true },
        },
      })

      cmp.setup.filetype("markdown", {
        enabled = true,
      })

      npairs.setup({
        check_ts = true,
        ts_config = {
          python = { "string" },
        },
        disable_filetype = { "TelescopePrompt" },
      })

      tstag.setup({})

      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "path" },
          { name = "cmdline" },
        },
      })
      cmp.setup.cmdline({ "/", "?" }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" },
        },
      })

      npairs.add_rules({
        Rule("%(.*%)%s*%()$", "", "python"):use_regex(true):set_end_pair_length(0),
      })

      -- require("copilot").setup({
      -- 	suggestion = { enabled = false }, -- tắt ghost text
      -- 	panel = { enabled = false },
      -- })

      -- vim.api.nvim_create_autocmd("FileType", {
      -- 	pattern = { "markdown", "tex" },
      -- 	callback = function()
      -- 		-- vim.opt.spell = true
      -- 		-- vim.opt.spelllang = { "en_us" }
      -- 	end,
      -- })
    end,
  },
}
