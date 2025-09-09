return {
    {
        "nvim-tree/nvim-web-devicons",
        config = function()
            require("nvim-web-devicons").setup {
            }
        end
    },
    {
        "nvim-lualine/lualine.nvim",
        dependencies = {
           "ellisonleao/gruvbox.nvim",
            "nvim-tree/nvim-web-devicons"
        },
        config = function()
            require('lualine').setup {
                options = {
                    icons_enabled = true,
                    theme = 'gruvbox'
                },
                sections = {
                    lualine_c = {'filename'}
                }
            }

        end
    }
}
