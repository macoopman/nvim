local keymap = vim.keymap;

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

keymap.set("n", '<leader>gu', function()
    if vim.bo.filetype == 'java' then
        require('jdtls').update_projects_config();
    end
end)
-- run full test class
keymap.set("n", '<leader>tc', function()
    if vim.bo.filetype == 'java' then
        require('jdtls').test_class();
    end
end)
-- run single test method
keymap.set("n", '<leader>tm', function()
    if vim.bo.filetype == 'java' then
        require('jdtls').test_nearest_method();
    end
end)

-- Debugging
keymap.set("n", "<leader>bb", "<cmd>lua require'dap'.toggle_breakpoint()<cr>")
keymap.set("n", "<leader>bc", "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>")
keymap.set("n", "<leader>bl", "<cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<cr>")
keymap.set("n", '<leader>br', "<cmd>lua require'dap'.clear_breakpoints()<cr>")
keymap.set("n", '<leader>ba', '<cmd>Telescope dap list_breakpoints<cr>')

keymap.set("n", "<leader>dc", "<cmd>lua require'dap'.continue()<cr>")
keymap.set("n", "<leader>dC", "<cmd>lua require'dap'.run_to_cursor()<cr>")
keymap.set("n", "<leader>dj", "<cmd>lua require'dap'.step_over()<cr>")
keymap.set("n", "<leader>dk", "<cmd>lua require'dap'.step_into()<cr>")
keymap.set("n", "<leader>do", "<cmd>lua require'dap'.step_out()<cr>")

keymap.set("n", '<leader>dd', function() require('dap').disconnect(); require('dapui').close(); end)
keymap.set("n", '<leader>dt', function() require('dap').terminate(); require('dapui').close(); end)

keymap.set("n", "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>")
keymap.set("n", "<leader>dl", "<cmd>lua require'dap'.run_last()<cr>")

keymap.set("n", '<leader>di', function() require "dap.ui.widgets".hover() end)
keymap.set("n", '<leader>d?', function() local widgets = require "dap.ui.widgets"; widgets.centered_float(widgets.scopes) end)

keymap.set("n", '<leader>df', '<cmd>Telescope dap frames<cr>')
keymap.set("n", '<leader>dh', '<cmd>Telescope dap commands<cr>')
keymap.set("n", '<leader>de', function() require('telescope.builtin').diagnostics({default_text=":E:"}) end)
