if true then
  return {}
end
return {
  {
    "folke/flash.nvim",
    enabled = false,
  },
  {
    "FluxxField/smart-motion.nvim",
    -- enabled = false,
    opts = {
      presets = {
        words = true, -- w, b, e, ge
        lines = true, -- j, k
        search = true, -- s, f, F, t, T, ;, ,, gs
        delete = true, -- d + any motion, dt, dT, rdw, rdl
        yank = true, -- y + any motion, yt, yT, ryw, ryl
        change = true, -- c + any motion, ct, cT
        paste = true, -- p/P + any motion
        treesitter = true, -- ]], [[, ]c, [c, ]b, [b, daa, caa, yaa, dfn, cfn, yfn, saa
        diagnostics = true, -- ]d, [d, ]e, [e
        git = true, -- ]g, [g
        quickfix = true, -- ]q, [q, ]l, [l
        marks = true, -- g', gm
        misc = true, -- . g. g0 g1-g9 gp gP gA-gZ gmd gmy (repeat, history, pins, global pins)
      },
    },
  },
  {
    "selimacerbas/markdown-preview.nvim",
    lazy = true,
    enabled = false,
    dependencies = { "selimacerbas/live-server.nvim" },
    config = function()
      require("markdown_preview").setup({
        -- all optional; sane defaults shown
        port = 8421,
        open_browser = true,
        debounce_ms = 300,
      })
    end,
  },
  {
    "xieyonn/spinner.nvim",
    config = function()
      -- **NO** need to call setup() if you are fine with defaults.
      require("spinner").setup()
    end,
  },
  {
    "litvinov-git/furry.nvim",
    dependencies = { "nvim-mini/mini.fuzzy" },
    config = function()
      require("furry").setup({
        -- Defaults:
        -- highlight_matches = true,
        -- highlight_current = true,
        -- max_score = 1800,
        -- progressive = true,
        -- sort_by = "lines",
        -- on_empty = "dump",
        -- on_space = "repeat_last",
        -- on_change = "dump",
        -- on_buf_enter = "repeat_last",
      })
    end,
  },
  { "nvim-mini/mini.nvim", version = false },
  {
    {
      "rachartier/tiny-inline-diagnostic.nvim",
      event = "VeryLazy", -- Or `LspAttach`
      priority = 1000, -- needs to be loaded in first
      config = function()
        require("tiny-inline-diagnostic").setup({
          preset = "modern",
        })
        -- vim.diagnostic.config({ virtual_text = false }) -- Only if needed in your configuration, if you already have native LSP diagnostics
      end,
    },
  },
  {
    "AlexandrosAlexiou/kotlin.nvim",
    ft = { "kotlin" },
    dependencies = {
        "mason.nvim",
        "mason-lspconfig.nvim",
        -- "oil.nvim",
        "trouble.nvim",
    },
    config = function()
        require("kotlin").setup {
            -- Optional: Specify root markers for multi-module projects
            root_markers = {
                "gradlew",
                ".git",
                "mvnw",
                "settings.gradle",
            },

            -- Optional: Java Runtime to run the kotlin-lsp server itself
            -- NOT REQUIRED when using Mason (kotlin-lsp v261+ includes bundled JRE)
            -- Priority: 1. jre_path, 2. Bundled JRE (Mason), 3. System java
            --
            -- Use this if you want to run kotlin-lsp with a specific Java version
            -- Must point to JAVA_HOME (directory containing bin/java)
            -- Examples:
            --   macOS:   "/Library/Java/JavaVirtualMachines/jdk-21.jdk/Contents/Home"
            --   Linux:   "/usr/lib/jvm/java-21-openjdk"
            --   Windows: "C:\\Program Files\\Java\\jdk-21"
            --   Env var: os.getenv("JAVA_HOME") or os.getenv("JDK21")
            -- jre_path = nil,  -- Use bundled JRE (recommended)
            jre_path = "$HOME/../usr/lib/jvm/java-21-openjdk",  -- Use bundled JRE (recommended)

            -- Optional: JDK for symbol resolution (analyzing your Kotlin code)
            -- This is the JDK that your project code will be analyzed against
            -- Different from jre_path (which runs the server)
            -- Required for: Analyzing JDK APIs, standard library symbols, platform types
            --
            -- Usually should match your project's target JDK version
            -- Examples:
            --   macOS:   "/Library/Java/JavaVirtualMachines/jdk-17.jdk/Contents/Home"
            --   Linux:   "/usr/lib/jvm/java-17-openjdk"
            --   Windows: "C:\\Program Files\\Java\\jdk-17"
            --   SDKMAN:  os.getenv("HOME") .. "/.sdkman/candidates/java/17.0.8-tem"
            jdk_for_symbol_resolution = nil,  -- Auto-detect from project

            -- Optional: Specify additional JVM arguments for the kotlin-lsp server
            jvm_args = {
                "-Xmx4g",  -- Increase max heap (useful for large projects)
            },

            -- Optional: Configure inlay hints (requires kotlin-lsp v261+)
            -- All settings default to true, set to false to disable specific hints
            inlay_hints = {
                enabled = true,  -- Enable inlay hints (auto-enable on LSP attach)
                parameters = true,  -- Show parameter names
                parameters_compiled = true,  -- Show compiled parameter names
                parameters_excluded = false,  -- Show excluded parameter names
                types_property = true,  -- Show property types
                types_variable = true,  -- Show local variable types
                function_return = true,  -- Show function return types
                function_parameter = true,  -- Show function parameter types
                lambda_return = true,  -- Show lambda return types
                lambda_receivers_parameters = true,  -- Show lambda receivers/parameters
                value_ranges = true,  -- Show value ranges
                kotlin_time = true,  -- Show kotlin.time warnings
            },
        }
    end,
},
  -- lazy.nvim
{
  "idelice/nvim-jls",
  opts = {
    jls_dir = "/path/to/jls", -- must contain dist/lang_server_*.sh
  },
}

}
