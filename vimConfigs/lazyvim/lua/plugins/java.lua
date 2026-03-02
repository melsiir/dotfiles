-- lazy.nvim
-- return {
--   "idelice/nvim-jls",
--   opts = {
--     jls_dir = "~/.jls/", -- must contain dist/lang_server_*.sh
--     filetypes = { "java" },
--     root_markers = {
--       ".git",
--     },
--   },
-- }
return {
  {
    "mfussenegger/nvim-jdtls",
    optional = true,

    -- https://github.com/LazyVim/LazyVim/pull/6265#issuecomment-3203831504
    opts = function(_, opts)
      local jdtls = vim.fn.exepath("jdtls")
      if jdtls == "" then
        return opts -- jdtls not in PATH
      end

      local lombok = vim.fn.expand("~/.jdtls/lombok.jar")

      -- Base command
      opts.cmd = { jdtls }

      -- Lombok (NO mason dependency)
      if vim.fn.filereadable(lombok) == 1 then
        table.insert(opts.cmd, "--jvm-arg=-javaagent:" .. lombok)
      end

      -- -- Termux-optimized JVM flags
      local jvm_args = {
        -- "-Xms128m",
        -- "-Xmx512m",
        -- "-XX:+UseSerialGC",
        -- "-XX:MaxMetaspaceSize=256m",
        "-XX:+UseStringDeduplication",
        -- "-Dorg.eclipse.jdt.ls.core.validation=false",
        -- Silence ALL jdtls noise
        "--add-modules=ALL-SYSTEM",
        "-Djava.util.logging.config.file=/dev/null",
        "-Dlog.level=OFF",
        -- "-Djava.import.gradle.enabled=false", -- dont generate app/classPath i so it manualy
      }

      if vim.g.user_is_termux then
        vim.list_extend(jvm_args, {
          "-Xms64m",
          "-Xmx384m",
          "-XX:+UseSerialGC",
          "-XX:ParallelGCThreads=1",
          "-XX:MaxMetaspaceSize=192m",
        })
      end

      for _, arg in ipairs(jvm_args) do
        table.insert(opts.cmd, "--jvm-arg=" .. arg)
      end

      -- Safer root detection (Android + JVM)
      opts.root_dir = function(fname)
        return vim.fs.root(fname, {
          ".git",
          "build.gradle",
          "build.gradle.kt",
          "settings.gradle",
          "pom.xml",
          "gradlew",
        })
      end


      -- Disable noisy / heavy features
      opts.settings = vim.tbl_deep_extend("force", opts.settings or {}, {
        java = {
          -- project = {
          --   referencedLibraries = {
          --     "$HOME/projects/net-calc/app/build/intermediates/compile_r_class_jar/debug/generateDebugRFile/R.jar"
          --   }
          -- },
          import = {
            gradle = {
              enabled = false,
            },
            maven = {
              enabled = false,
            },
          },
          jdt = {
            ls = {
              androidSupport = {
                enabled = true, -- Enable Android support
              },
            },
          },
          resourceFilters = {
            "node_modules",
            ".gradle",
            "build",
          },
          -- validation = {
          -- enabled = false,
          -- },
          -- eclipse = { downloadSources = true },
          configuration = {
            updateBuildConfiguration = "interactive",
          },
          -- maven = { downloadSources = true },
          implementationsCodeLens = { enabled = true },
          referencesCodeLens = { enabled = true },

          errors = {
            incompleteClasspath = {
              severity = "ignore",
            },
          },
          signatureHelp = { enabled = true },
          contentProvider = { preferred = "fernflower" },
          autobuild = { enabled = false },
        },
      })

      if LazyVim.has("blink.cmp") then
        opts.capabilities = require("blink.cmp").get_lsp_capabilities(opts.capabilities)
      elseif LazyVim.has("cmp-nvim-lsp") then
        opts.capabilities = require("cmp_nvim_lsp").default_capabilities(opts.capabilities)
      end

      -- Silence noise
      opts.handlers = opts.handlers or {}
      opts.handlers["window/showMessage"] = function() end
      opts.handlers["window/logMessage"] = function() end
      opts.handlers["language/status"] = function() end
      -- -- Disable Java DAP + test (huge RAM saver)
      -- opts.dap = false
      -- opts.test = false

      return opts
    end,
  }
}
-- return {
--   'mfussenegger/nvim-jdtls',
--   enabled = true,
--   version = false,       -- set this if you want to always pull the latest change
--   ft = { "java" },       -- THIS IS KEY, if not this, everything will broken
--   -- UPDATE: this will cause jump to class not work as expect, but other function will do work
--   -- See: https://github.com/mfussenegger/nvim-jdtls/issues/639#issuecomment-3079720936
--   dependencies = {
--     'mfussenegger/nvim-dap',
--     'williamboman/mason.nvim',
--     'williamboman/mason-lspconfig.nvim',
--     "neovim/nvim-lspconfig",
--   },
--   -- opts = {
--   --     cmd = {}, -- leave to config staged
--   --     root_dir = vim.fs.dirname(vim.fs.find({'gradlew', '.git', 'mvnw', '.root'}, { upward = true })[1]),
--   -- },
--   config = function()
--     -- See: https://zhuanlan.zhihu.com/p/574746992
--     -- And: https://github.com/redhat-developer/vscode-java/wiki/JDK-Requirements#java.configuration.runtimes
--     ---@diagnostic disable-next-line: unused-function
--     local function get_runtime_dir()
--       local runtime = {
--         {
--           name = 'JavaSE-21',
--           path = '/data/data/com.termux/files/usr/lib/jvm/java-21-openjdk/"',
--         },
--       }
--       return runtime
--     end
--     local env = {
--       ---@diagnostic disable-next-line: undefined-field
--       HOME = vim.uv.os_homedir(),
--       XDG_CACHE_HOME = os.getenv 'XDG_CACHE_HOME',
--       JDTLS_JVM_ARGS = os.getenv 'JDTLS_JVM_ARGS',
--     }
--
--     local cache_dir = (env.XDG_CACHE_HOME and env.XDG_CACHE_HOME or env.HOME .. '/.cache') .. '/jdtls'
--
--     -- We using mason-lspconfig, not using it according to readme
--     -- local jdtls = require('jdtls')
--     local mason_root = require('mason.settings').current.install_root_dir
--     local root_markers = { 'javaroot', '.repo', 'gradlew', 'settings.gradle.kts' }
--     local root_dir = require('jdtls.setup').find_root(root_markers)
--     local cache_dirname = 'common'
--     if root_dir then
--       cache_dirname = root_dir:gsub('/', '_'):gsub('\\', '_')
--     end
--     local executable = 'jdtls'
--
--     if vim.fn.executable(executable) ~= 1 then
--       return
--     end
--
--     vim.api.nvim_create_user_command('JdtWorkspaceDir',
--       function()
--         vim.print(cache_dir .. '/workspace/' .. cache_dirname)
--       end,
--       {
--         desc = 'Print the workspace directory path'
--       }
--     )
--
--
--     local opts = {
--       -- cmd = require('lspconfig').jdtls.document_config.default_config.cmd,
--       cmd = {
--         -- require('lspconfig').jdtls.document_config.default_config.cmd[1],
--         'jdtls',
--         '--jvm-arg=-Dlog.level=ALL',
--         '-configuration',
--         cache_dir .. '/config',
--         '-data',
--         cache_dir .. '/workspace/' .. cache_dirname
--         -- cache_dir .. '/workspace/' .. vim.fn.fnamemodify(root_dir, ":p:h:t"),
--       },
--       -- See: https://github.com/mfussenegger/nvim-jdtls?tab=readme-ov-file#configuration-verbose
--       -- See: https://github.com/eclipse-jdtls/eclipse.jdt.ls/wiki/Language-Server-Settings-&-Capabilities
--       root_dir = root_dir,
--       init_options = {
--         bundles = {
--           vim.fn.glob(
--             mason_root .. "/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar",
--             true
--           ),
--         },
--         settings = {
--           configuration = {
--             runtimes = get_runtime_dir(),
--           },
--           java = {
--             contentProvider = { preferred = 'fernflower' },
--             inlayhints = {
--               parameterNames = { enabled = true },
--             },
--             -- autobuild = { enabled = true },
--             import = {
--               gradle = {
--                 -- See: https://www.reddit.com/r/neovim/comments/1m3v9kk/jdtls_keeps_regenerating_my_classpath_for_a/
--                 -- do not let jdtls generate .classpath, manually generate it
--                 enabled = false,
--                 -- jvmArguments = "-Dhttp.proxyHost=127.0.0.1 -Dhttp.proxyPort=7890 -Dhttps.proxyHost=127.0.0.1 -Dhttps.proxyPort=7890",
--                 -- wrapper = {
--                 --     enabled = false,
--                 -- }
--               },
--             },
--             jdt = {
--               ls = {
--                 androidSupport = true,
--               },
--             },
--             references = {
--               includeAccessors = true,
--               includeDecompiledSources = true,
--             },
--           },
--         },
--       },
--     }
--     -- DO NOT SET SETTINGS, UNLESS YOU KNOW EVERYTHING IT WILL OVERWRITE DEFAULT ONE
--     -- settings = {
--     --     java = {
--     -- configuration = {
--     --     runtimes = get_runtime_dir(),
--     -- },
--     -- import = {
--     --     gradle = {
--     --         -- See: https://www.reddit.com/r/neovim/comments/1m3v9kk/jdtls_keeps_regenerating_my_classpath_for_a/
--     --         -- do not let jdtls generate .classpath, manually generate it
--     --         enabled = false,
--     --     },
--     -- },
--     -- jdt = {
--     --     ls = {
--     --         -- See:
--     --         -- https://github.com/eclipse-jdtls/eclipse.jdt.ls/issues/3284#issuecomment-2577158493
--     --         androidSupport = {
--     --             enabled = true, -- Enable Android support
--     --         },
--     --     },
--     -- },
--     --     },
--     -- },
--     local dap = require('dap')
--     dap.configurations.java = {
--       {
--         type = 'java',
--         request = 'attach',
--         name = "Debug (Attach) - Remote",
--         hostName = "127.0.0.1",
--         port = 5005,
--         -- for multi project, using this
--         -- projectName = "settings_info",
--         -- Also See: https://source.android.com/docs/core/tests/debug/gdb?hl=zh-cn#app-startup
--         -- Also See: https://codeberg.org/mfussenegger/nvim-dap/wiki/Java
--       },
--     }
--
--     vim.api.nvim_create_autocmd("Filetype", {
--       pattern = "java",
--       callback = function()
--         local current_file = vim.fn.expand("%:p")
--         -- Exclude paths containing /tmp/kotlinlangserver
--         if string.match(current_file, "/tmp/kotlinlangserver") then
--           return
--         end
--         require("jdtls").start_or_attach(opts)
--       end,
--     })
--     -- vim.inspect(opts)
--     -- jdtls.start_or_attach(opts)
--   end
-- }
