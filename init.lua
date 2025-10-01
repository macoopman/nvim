require("core.keymaps")
require("core.set")
require("core.lazy")

local autocmd = vim.api.nvim_create_autocmd

autocmd('LspAttach', {
    desc = 'LSP actions',
    callback = function(event)
        local opts = { buffer = event.buf }
        local keymap = vim.keymap;

        keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
        keymap.set("n", "<leader>gd", function() vim.lsp.buf.definition() end, opts)
        keymap.set('n', '<leader>gD', function() vim.lsp.buf.declaration() end, opts)
        keymap.set('n', '<leader>gi', function() vim.lsp.buf.implementation() end, opts)
        keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
        keymap.set('n', '<leader>vo', function() vim.lsp.buf.type_definition() end, opts)
        keymap.set("n", "<leader>vr", function() vim.lsp.buf.references() end, opts)
        keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
        keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
        keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
        keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)

        keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
        keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)

        keymap.set({ 'n', 'x' }, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)

    end,
})

autocmd('FileType', {
    pattern = 'java',
    callback = function(args)
        -- reference config: https://github.com/bcampolo/nvim-starter-kit/blob/java/.config/nvim/ftplugin/java.lua https://github.com/bcampolo/nvim-starter-kit/blob/java/.config/nvim/ftplugin/java.lua
        -- home win: C:/Users/<username>
        --local home = vim.env.HOME
        local home = "C:/Users/N76646"
        local jdtls = require('jdtls')
        local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
        local workspace_dir = home .. "/workspace/jdtls-workspace/" .. project_name

        local system_os = ""

        -- Determine OS
        if vim.fn.has("mac") == 1 then
          system_os = "mac"
        elseif vim.fn.has("unix") == 1 then
          system_os = "linux"
        elseif vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1 then
          system_os = "win"
        else
          print("OS not found, defaulting to 'linux'")
          system_os = "linux"
        end

        -- Needed for debugging
        local bundles = {
          vim.fn.glob(home .. "/AppData/Local/nvim-data/mason/share/java-debug-adapter/com.microsoft.java.debug.plugin-0.53.2.jar"),
        }
        -- Needed for running/debugging unit tests
        vim.list_extend(bundles, vim.split(vim.fn.glob(home .. "/AppData/Local/nvim-data/mason/share/java-test/*.jar", 1), "\n"))

        local config = {
            -- The command that starts the language server
            -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
            cmd = {
                -- 💀
                'java',
                --"C:/Users/N76646/Workspace/JDK/jdk-21.0.2/bin",
                -- depends on if `java` is in your $PATH env variable and if it points to the right version.

                "-Declipse.application=org.eclipse.jdt.ls.core.id1",
                "-Dosgi.bundles.defaultStartLevel=4",
                "-Declipse.product=org.eclipse.jdt.ls.core.product",
                "-Dlog.protocol=true",
                "-Dlog.level=ALL",
                "-javaagent:" .. home .. "/AppData/Local/nvim-data/mason/packages/jdtls/lombok.jar",
                "-Xmx4g",
                "--add-modules=ALL-SYSTEM",
                "--add-opens", "java.base/java.util=ALL-UNNAMED",
                "--add-opens", "java.base/java.lang=ALL-UNNAMED",

                -- 💀
                "-jar",
                home .. "/AppData/Local/nvim-data/mason/share/jdtls/plugins/org.eclipse.equinox.launcher.jar",
                -- 💀
                "-configuration",
                home .. "/AppData/Local/nvim-data/mason/packages/jdtls/config_win",

                -- 💀
                -- See `data directory configuration` section in the README
                "-data",
                workspace_dir,
            },

            -- 💀
            -- This is the default if not provided, you can remove it. Or adjust as needed.
            -- One dedicated LSP server & client will be started per unique root_dir

            root_dir = vim.fs.root(0, { ".git", "mvnw", "gradlew" }),

        -- Here you can configure eclipse.jdt.ls specific settings
          -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
          settings = {
            java = {
              home = home .. "/Workspace/JDK/jdk-21.0.2/bin",
              eclipse = {
                downloadSources = true,
              },
              configuration = {
                updateBuildConfiguration = "interactive",
                -- TODO Update this by adding any runtimes that you need to support your Java projects and removing any that you don't have installed
                -- The runtimes' name parameter needs to match a specific Java execution environments.  See https://github.com/eclipse-jdtls/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request and search "ExecutionEnvironment".
                runtimes = {
                  {
                    name = "JavaSE-1.8",
                    path = home .. "/Workspace/jdk/jdk1.8.0_442",
                  },
		          {
                    name = "JavaSE-21",
                    path = home .. "/Workspace/jdk/jdk-21.0.2",
                  }
                  -- {
                  --   name = "JavaSE-11",
                  --   path = "/usr/lib/jvm/java-11-openjdk-amd64",
                  -- },
                  -- {
                  --   name = "JavaSE-17",
                  --   path = "/usr/lib/jvm/java-17-openjdk-amd64",
                  -- },
                  -- {
                  --   name = "JavaSE-19",
                  --   path = "/usr/lib/jvm/java-19-openjdk-amd64",
                  -- },
                  -- {
                },
              },
              maven = {
                downloadSources = true,
              },
              implementationsCodeLens = {
                enabled = true,
              },
              referencesCodeLens = {
                enabled = true,
              },
              references = {
                includeDecompiledSources = true,
              },
              signatureHelp = { enabled = true },
              format = {
                enabled = true,
                -- Formatting works by default, but you can refer to a specific file/URL if you choose
                -- settings = {
                --   url = "https://github.com/google/styleguide/blob/gh-pages/intellij-java-google-style.xml",
                --   profile = "GoogleStyle",
                -- },
              },
              completion = {
                favoriteStaticMembers = {
                  "org.hamcrest.MatcherAssert.assertThat",
                  "org.hamcrest.Matchers.*",
                  "org.hamcrest.CoreMatchers.*",
                  "org.junit.jupiter.api.Assertions.*",
                  "java.util.Objects.requireNonNull",
                  "java.util.Objects.requireNonNullElse",
                  "org.mockito.Mockito.*",
                },
                importOrder = {
                  "java",
                  "javax",
                  "com",
                  "org",
                },
              },
              sources = {
                organizeImports = {
                  starThreshold = 9999,
                  staticStarThreshold = 9999,
                },
              },
              codeGeneration = {
                toString = {
                  template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
                },
                useBlocks = true,
              },
            },
          },
          -- Needed for auto-completion with method signatures and placeholders
          capabilities = require("cmp_nvim_lsp").default_capabilities(),
          flags = {
            allow_incremental_sync = true,
          },

            init_options = {
                bundles = bundles,
                extendedClientCapabilities = jdtls.extendedClientCapabilities
            },
        }
        -- Needed for debugging
        config["on_attach"] = function(client, bufnr)
          jdtls.setup_dap({ hotcodereplace = "auto" })
          require("jdtls.dap").setup_dap_main_class_configs()

        end-- Needed for debugging
        -- This starts a new client & server,
        -- or attaches to an existing client & server depending on the `root_dir`.
        jdtls.start_or_attach(config)
    end
})
