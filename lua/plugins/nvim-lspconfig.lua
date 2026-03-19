-- LSP Support
return {
  'neovim/nvim-lspconfig',
  event = 'VeryLazy',
  dependencies = {
    { 'williamboman/mason.nvim' },
    { 'williamboman/mason-lspconfig.nvim' },
    { 'WhoIsSethDaniel/mason-tool-installer.nvim' },
    { 'j-hui/fidget.nvim', opts = {} },
    { 'folke/neodev.nvim', opts = {} },
  },
  config = function ()
    require('mason').setup()

    require('mason-tool-installer').setup({
      -- Install these linters, formatters, debuggers automatically
      ensure_installed = {
        'java-debug-adapter',
        'java-test',
      },
    })

    vim.api.nvim_command('MasonToolsInstall')

    require('mason-lspconfig').setup({
      -- Install these LSPs automatically
      automatic_enabled = {
          exclude = { 'jdtls' }
      },
      ensure_installed = {
        'lua_ls',
        'jdtls',
        'marksman',
        'clangd'
      },

      handlers = {
        function(server)
          vim.lsp.config(server, {})
          vim.lsp.enable(server)
        end,

        clangd = function()
          vim.lsp.config('clangd', {
            filetypes = { "c", "cpp", "h" },
            init_options = {
                fallbackFlags = { "-std=c++20" }
                -- fallbackFlags = { '--std=c89' }
                -- fallbackFlags = { '--std=c11' }
            },
            cmd = {
                "clangd",
                "--experimental-modules-support",
                "--background-index",
                "--clang-tidy",
                "--header-insertion=iwyu",
                "--completion-style=bundled",
                "--pch-storage=memory",
                "--log=verbose",
                "--fallback-style=llvm",
                "--fallback-style=none"
             }
           })
           vim.lsp.enable('clangd')
         end,

        lua_ls = function()
            vim.lsp.config("lua_ls", {
              settings = {
                Lua = {
                  diagnostics = {
                    -- Get the language server to recognize the `vim` global
                    globals = {'vim'},
                  },
                },
              },
            })
           vim.lsp.enable('lua_ls')
        end,

     },


    })


    -- local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()
    -- local lsp_attach = function(client, bufnr)
      -- Create your keybindings here...
    -- end

   -- require('mason-lspconfig').setup({
   --   handlers = {
   --     function(server_name)
   --      if server_name ~= 'jdtls' then
   --        vim.lsp.config(server_name, {
   --          on_attach = lsp_attach,
   --          capabilities = lsp_capabilities,
   --        })
   --     end
   --   end
   --   },
   -- })
   --
    -- -- Lua LSP settings
    -- vim.lsp.config("lua_ls", {
    --   settings = {
    --     Lua = {
    --       diagnostics = {
    --         -- Get the language server to recognize the `vim` global
    --         globals = {'vim'},
    --       },
    --     },
    --   },
    -- })
    --
    --
    -- vim.lsp.config('clangd', {
    --     filetypes = { "c", "cpp", "h" },
    --     init_options = {
    --         fallbackFlags = { "-std=c++20" }
    --         -- fallbackFlags = { '--std=c89' }
    --         -- fallbackFlags = { '--std=c11' }
    --     },
    --     cmd = {
    --         "clangd",
    --         "--experimental-modules-support",
    --         "--background-index",
    --         "--clang-tidy",
    --         "--header-insertion=iwyu",
    --         "--completion-style=bundled",
    --         "--pch-storage=memory",
    --         "--log=verbose",
    --         "--fallback-style=llvm",
    --         "--fallback-style=none"
    --
    --     }
    -- })
    --
    -- Globally configure all LSP floating preview popups (like hover, signature help, etc)
    local open_floating_preview = vim.lsp.util.open_floating_preview
    function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
      opts = opts or {}
      opts.border = opts.border or "rounded" -- Set border to rounded
      return open_floating_preview(contents, syntax, opts, ...)
    end
end
}
