return {
  {
    "vyfor/cord.nvim",
    build = ":Cord update",
    opts = {
      editor = {
        client = "neovim",
        tooltip = "The Chosen One Code Editor",
        icon = nil,
      },
      display = {
        theme = "default",
        flavor = "dark",
        view = "full",
        swap_fields = false,
        swap_icons = false,
      },
      text = {
        editing = function(opts)
          local total_lines = vim.fn.line("$")
          return string.format("Editing %s - Line %s out of %s", opts.filename, opts.cursor_line, total_lines)
        end,
        workspace = function(opts)
          return string.format("Workspace: %s", opts.workspace)
        end,
      },
      buttons = {
        {
          label = function(opts)
            return opts.repo_url and "View Repository" or "Website"
          end,
          url = function(opts)
            return opts.repo_url or "https://nguyen-is-me.vercel.app/"
          end,
        },
      },
    },
  },
}
