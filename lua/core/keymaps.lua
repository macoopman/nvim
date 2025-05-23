vim.g.mapleader = " "

-- Open netrw
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Visual Mode: Move highlighted code up
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Visual Mode: Move highlighted code down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")

--
vim.keymap.set("n", "<C-u>", "<C-u>zz")
-- 
vim.keymap.set("n", "n", "nzzzv")
--
vim.keymap.set("n", "N", "Nzzzv")

-- 
vim.keymap.set("x", "<leader>p", [["_d]])

--
vim.keymap.set({"v"}, "<leader>y", [["+y]])
--
vim.keymap.set("n", "<leader>Y",[["+Y]] )
vim.keymap.set("n", "<leader>yy",[["+yy]] )
vim.keymap.set("n", "<leader>P",[["+P]] )

--
vim.keymap.set("i", "<C-c>", "<Esc")

--
vim.keymap.set("n", "Q", "<nop>")

--

vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)


--
vim.keymap.set("n", "<C-k>", "<cmd>cprev<CR>zz")
--
vim.keymap.set("n", "<C-j>", "<cmd>cnext<CR>zz")
--
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
--
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

--
vim.keymap.set("n", "<leader>x", [[:%s/\<<C-r><C-w>\><C-r><C-w>/gI<Left><Left><Left>]])

-- Make a file executable (only works in linux)
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>")


--
vim.keymap.set("n", "<leader><leader>", function() vim.cmd("so") end)









