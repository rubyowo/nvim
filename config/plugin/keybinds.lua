local map = function(mode, shortcut, command, opt)
  opt = opt or { silent = true }
  vim.keymap.set(mode, shortcut, command, opt)
end

-- move lines
map("n", "<C-j>", "<cmd>m .+1<cr>==")
map("n", "<C-k>", "<cmd>m .-2<cr>==")
map("v", "J", "<cmd>m '>+1<CR>gv=gv")
map("v", "K", "<cmd>m '<-1<CR>gv=gv")

-- vertical movment
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- Neo-Tree
map("n", "<leader>e", "<cmd>Neotree toggle<CR>")

-- improved clipboard
map({ "n", "v" }, "y", '"+y')
map({ "n", "v" }, "p", '"+p')

-- open lazygit
map({ "n", "v" }, "<leader>gg", "<cmd>LazyGit<cr>")

-- quit
map({ "n", "v" }, "<leader>q", "<cmd>q<cr>")
map({ "n", "v" }, "<C-q>", "<cmd>qall<cr>")

-- telescope
map("n", "<leader><leader>", "<cmd>Telescope find_files<cr>") -- find files
map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>") -- grep through all files
map("n", "<leader>fs", "<cmd>SessionManager load_session<cr>") -- Show nvim sessions
map("n", "<leader>fh", "<cmd>Telescope help_tags<cr>") -- search help tags
map("n", "<leader>ft", "<cmd>TodoTelescope<cr>") -- live grep but for TODOs and FIXMEs
map("n", "<leader>fc", "<cmd>Telescope git_commits<cr>") -- git commits
map("n", "<leader>fz", "<cmd>Telescope current_buffer_fuzzy_find<cr>") -- fuzzy find in current buffer

-- save file
map("n", "<leader>w", "<cmd>w<cr>")
