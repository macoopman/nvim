 return {
     "folke/tokyonight.nvim",
     lazy = false,
     prority = 1000,
     opts = {
         style = "night",
     },
     config = function()
         vim.cmd[[colorscheme tokyonight-night]]
     end
 }
