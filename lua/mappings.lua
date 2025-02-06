require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("n", "ss", ":SymbolsOutline<CR>", { desc = "Symbols Outline" })

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
