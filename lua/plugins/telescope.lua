return {
    "nvim-telescope/telescope.nvim",

    dependencies = {
        "nvim-lua/plenary.nvim",
        -- { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }
    },

    config = function()
        local telescope = require('telescope')

        telescope.setup{
          -- extensions = {
          --   fzf = {}
          -- },
        }

        --require('telescope').load_extension('fzf')

        local builtin = require('telescope.builtin')

        -- search over all files
        vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
        -- grep search all files
        vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
        -- search help
        vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

        vim.keymap.set('n', '<C-p>', builtin.git_files, {})

        vim.keymap.set('n', '<leader>ps', function()
            builtin.grep_string({ search = vim.fn.input("Grep > ") });
        end)

        -- Search for word under cursor
        vim.keymap.set("n", "pws", function()
            local word = vim.fn.expand("<cword>")
            builtin.grep_string({ search = word });
        end)

        vim.keymap.set("n", "pWs", function()
            local word = vim.fn.expand("<cWORD>")
            builtin.grep_string({ search = word });
        end)



        -- search for file in nvim directory from anywhere
        vim.keymap.set('n', '<leader>en', function ()
           builtin.find_files {
               cwd = vim.fn.stdpath('config')
           }
        end)
    end
}
