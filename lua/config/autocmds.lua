-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
--
--
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    print("LSP attached: " .. client.name)
  end,
})
vim.g.tex_flavor = "latex"
vim.g.vimtex_view_viewer_method = "SumatraPDF"
vim.g.vimtex_quickfix_mode = 0
vim.g.vimtex_quickfix_open_on_warning = 0
-- vim.g.tex_conceal = "abcg"
vim.g.tex_conceal = "abdgmcs"
vim.g.vimtex_complete_enabled = 0
vim.g.vimtex_indent_enabled = 0
vim.g.vimtex_imaps_enabled = 0
vim.g.vimtex_syntax_enabled = 0
vim.g.vimtex_compiler_latexmk = {
  build_dir = "",
  callback = 1,
  continuous = 1,
  executable = "latexmk",
  engine = "-pdf",
  hooks = {},
  options = { "-synctex=1", "-interaction=nonstopmode" },
}
vim.g.vimtex_delim_toggle_mod_list = {
  { [[\left]], [[\right]] },
  { [[\big]], [[\big]] },
}
vim.g.vimtex_quickfix_ignore_filters = {
  "Underfull \\\\hbox",
  "Overfull \\\\hbox",
  "LaTeX Warning: .\\+ float specifier changed to",
  "LaTeX hooks Warning",
  'Package siunitx Warning: Detected the "physics" package:',
  "Package hyperref Warning: Token not allowed in a PDF string",
}
vim.cmd([[
      hi texCmd guifg=#ad3da4 guibg=NONE gui=NONE ctermfg=127 ctermbg=NONE cterm=NONE
      hi! link texMathEnvArgName texEnvArgName
      hi! link texMathZone LocalIdent
      hi! link texMathZoneEnv texMathZone
      hi! link texMathZoneEnvStarred texMathZone
      hi! link texMathZoneX texMathZone
      hi! link texMathZoneXX texMathZone
      hi! link texMathZoneEnsured texMathZone

      " Small tweaks
      hi! link QuickFixLine Normal
      hi! link qfLineNr Normal
      hi! link EndOfBuffer LineNr
      hi! link Conceal LocalIdent
    ]])
