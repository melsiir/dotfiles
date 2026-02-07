return {
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
      "-Dlog.protocol=false",
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
        maven = { downloadSources = true },
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
