return {
     "ThePrimeagen/git-worktree.nvim",
     dependencies = "nvim-telescope/telescope.nvim",
     config = function()
         require("git-worktree").setup()
         local telescope = require('telescope')
         telescope.load_extension('git_worktree')

         vim.keymap.set("n", "<Leader>gw", "<CMD>lua require('telescope').extensions.get_worktree.git_worktrees()<CR>");
         vim.keymap.set("n", "<Leader>gW", "<CMD>lua require('telescope').extensions.get_worktree.create_git_worktree()<CR>");
     end
}
