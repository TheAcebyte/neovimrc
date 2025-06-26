vim.g.mapleader = " "

-- cy (clipboard yank), cc (clipboard cut) and cp (clipboard paste)
vim.keymap.set("v", "<leader>cy", '"+y', { desc = "Clipboard yank" })
vim.keymap.set("v", "<leader>cc", '"+d', { desc = "Clipboard cut" })
vim.keymap.set({ "n", "v" }, "<leader>cp", '"+p', { desc = "Clipboard paste" })

-- noice.nvim remaps
vim.keymap.set("n", "<leader>n/", "<cmd>noh<CR>", { silent = true, desc = "Noice hide highlights" })
vim.keymap.set("n", "<leader>nd", "<cmd>NoiceDismiss<CR>", { silent = true, desc = "Noice dismiss" })
