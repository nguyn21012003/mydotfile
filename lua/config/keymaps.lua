-- Leader và localleader
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Formatter cho Python
vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  callback = function()
    map("n", "<C-s>", ":w<CR>:!black --line-length 150 %<CR>:e<CR>", opts)
  end,
})

vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "*.py",
  command = "silent! !black --line-length 150 %",
})

vim.o.swapfile = false

-- SearchBox
map("n", "<C-f>", "<cmd>SearchBoxIncSearch<CR>", opts)
map("n", "<C-r>", "<cmd>SearchBoxReplace<CR>", opts)

-- Format
-- map("n", "<leader>fm", ":!isort %<CR>", { desc = "Run isort on file" }, opts)

vim.keymap.set("n", "<leader>fm", function()
  local file = vim.fn.expand("%") -- path file hiện tại
  vim.fn.system({ "isort", file })
  vim.cmd("edit") -- reload file sau khi format
end, { desc = "Run isort silently" }, opts)

-- map("n", "<leader>fm", function()
--   vim.lsp.buf.format({
--     filter = function(client)
--       return client.name == "null-ls"
--     end,
--   })
-- end, { desc = "Format buffer" }, opts)

-- Hover

map("n", "K", function()
  vim.lsp.buf.hover({
    border = "rounded",
    max_height = 20,
    max_width = 130,
    close_events = { "BufLeave", "WinLeave", "LSPDetach" },
  })
end, opts)

map("n", "<space>ca", vim.lsp.buf.code_action, { desc = "LSP code action" })
map("n", "<C-k>", vim.lsp.buf.signature_help)
-- Alpha

-- Tabs & Buffers
map("n", "<leader>tn", "<cmd>tabnew<CR>", opts)
map("n", "<Tab>", "<cmd>BufferLineCycleNext<CR>", opts)
map("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<CR>", opts)

for i = 1, 9 do
  map("n", "<A-" .. i .. ">", "<cmd>BufferLineGoToBuffer " .. i .. "<CR>", opts)
end

-- Close buffer
map("n", "W", "<cmd>bd<CR>", opts)

-- Floaterm
map("n", "<localleader>lt", "<cmd>lua Snacks.terminal.toggle()<CR>", opts)

-- Markdown preview
map("n", "<leader>mm", "<cmd>MarkdownPreview<CR>", { desc = "Markdown Preview" }, opts)

-- Word wrap toggle
map("n", "<A-z>", "<cmd>set wrap!<CR>", opts)

-- Redo
map("n", "U", "<cmd>redo<CR>", opts)

-- Neoformat
map("n", "<leader>vf", "<cmd>Neoformat<CR>", opts)

-- Di chuyển dòng trong visual mode
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move line above" }, opts)
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move line below" }, opts)

-- Tự động bật wrap cho markdown, tex, python
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown", "tex", "python" },
  command = "setlocal wrap linebreak",
})

map("n", "<leader>gg", "<cmd>LazyGit<CR>", opts)
map("n", "<Esc>", "<Cmd>nohlsearch<CR>")

map("n", "<leader>ds", vim.lsp.buf.document_symbol, { desc = "Document symbols" })

map("n", "<localleader>z", function()
  Snacks.zen()
end, { desc = "Toggle Zen Mode" })

-- map("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { desc = "Find files" }, opts)
-- map("n", "<leader>fe", "<cmd>Telescope file_browser path=%:p:h select_buffer=true<CR>", { desc = "File Browser" }, opts)
-- map("n", "<leader>fr", "<cmd>Telescope oldfiles<CR>", { desc = "Recent files" }, opts)
-- map("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", { desc = "Live grep" }, opts)
-- map("n", "<leader>fs", "<cmd>Telescope current_buffer_fuzzy_find<CR>", { desc = "Fuzzy search in buffer" }, opts)
-- map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "Buffers" }, opts)
-- map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "Help tags" }, opts)
-- map("n", "<leader>fds", "<cmd>Telescope lsp_document_symbols<CR>", { desc = "LSP document symbols" }, opts)
-- map("n", "<leader>fdn", "<cmd>Telescope diagnostics<CR>", { desc = "LSP diagnostics" }, opts)
--
-- --- Git
-- map("n", "<leader>gc", "<cmd>Telescope git_commits<CR>", { desc = "Git commits" }, opts)
-- map("n", "<leader>gs", "<cmd>Telescope git_status<CR>", { desc = "Git status" }, opts)
-- map("n", "<leader>gd", "<cmd>FzfLua git_diff<CR>", { desc = "Git dif" }, opts)
--
-- map("n", "<leader>ss", "<cmd>PossessionSave<CR>", { desc = "Session save" }, opts)
-- map("n", "<leader>sp", "<cmd>Telescope possession<CR>", { desc = "Find session" }, opts)

map("n", "<leader>cm", "<cmd>Mason<CR>", { desc = "Mason config" }, opts)

vim.api.nvim_create_user_command("CopyBufName", function()
  local path = vim.fn.bufname("%")
  vim.fn.setreg("+", path)
  print("Copied: " .. path)
end, {})

map("n", "<leader>rn", function()
  vim.lsp.buf.rename()
end, { desc = "Rename Symbol" })

-- vim.keymap.set("n", "<leader>nn", ":ObsidianNew<CR>", { desc = "Create new Obsidian note" })

local function create_todo_file()
  local todo_dir = vim.fn.expand("~/notes/todo/")
  if vim.fn.isdirectory(todo_dir) == 0 then
    vim.fn.mkdir(todo_dir, "p")
  end

  local date = os.date("%Y-%m-%d")
  local file_path = string.format("%stodo-%s.md", todo_dir, date)

  if vim.fn.filereadable(file_path) == 0 then
    local template = {
      "# 📝 TODO",
      "",
      "## Date: " .. date,
      "",
      "### Tasks",
      "- [ ] ",
      "",
      "---",
    }
    vim.fn.writefile(template, file_path)
  end

  vim.cmd("edit " .. file_path)
end

local function open_todo_dir()
  local todo_dir = vim.fn.expand("~/notes/todo/")
  if vim.fn.isdirectory(todo_dir) == 0 then
    vim.fn.mkdir(todo_dir, "p")
  end
  require("snacks").explorer({ cwd = todo_dir })
end

vim.keymap.set("n", "<leader>td", create_todo_file, { desc = "Create todo file" })
vim.keymap.set("n", "<leader>to", open_todo_dir, { desc = "Open todo folder" })
