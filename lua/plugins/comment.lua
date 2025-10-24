return {
  {
    "folke/ts-comments.nvim",
    opts = {},
    config = function(_, opts)
      require("ts-comments").setup(opts)
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "gnuplot",
        callback = function()
          vim.bo.commentstring = "# %s"
        end,
      })
    end,
    event = "VeryLazy",
    enabled = vim.fn.has("nvim-0.10.0") == 1,
  },
}
