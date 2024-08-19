vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

keymap.set("n", "ei", ":", { desc = "Exit insert mode with ne" })

keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" }) -- increment
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" }) -- decrement

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

-- buffer management
keymap.set("n", "<leader>bn", ":bNext", { desc = "Next buffer" }) -- next buffer
keymap.set("n", "<leader>bn", ":bPrevious", { desc = "Previous buffer" }) -- previous buffer
