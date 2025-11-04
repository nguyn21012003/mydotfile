return {
  {
    "nvim-telescope/telescope.nvim",
    enabled = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-file-browser.nvim",
    },
    opts = function()
      local telescope = require("telescope")
      local fb_actions = require("telescope").extensions.file_browser.actions

      telescope.setup({
        pickers = {
          find_files = { hidden = true },
          current_buffer_fuzzy_find = {},
        },
        extensions = {
          file_browser = {
            theme = "ivy",
            hijack_netrw = true,
            mappings = {
              ["i"] = { ["<F2>"] = fb_actions.rename },
            },
          },
        },
      })

      telescope.load_extension("file_browser")
    end,
  },
}
