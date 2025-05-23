return {
    "nvim-telescope/telescope.nvim",

    dependencies = { 
        "plenary"
    },

    config = function () 
        require('telescope').setup({})
        local builtin = require('telescope.builtin')

        vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
        vim.keymap.set('n', '<C-p>', builtin.git_files, {})
        
        vim.keymap.set('n', '<leader>ps', function()
            builtin.grep_string({ search = vim.fn.input("Grep > ") });
        end)

        -- Search for word under cursor
        vim.keymap.set("n", "pws", function()
            local word = vim.fn.expand("<cword>")
            builtin.grep_string({ search =  word});
        end)
        vim.keymap.set("n", "pWs", function()
            local word = vim.fn.expand("<cWORD>")
            builtin.grep_string({ search =  word});
        end)


        vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
        vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
    end
}
