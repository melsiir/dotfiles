return {
  {
    "ariedov/android-nvim",
    enabled = false,
    config = function()
      -- OPTIONAL: specify android sdk directory
      vim.g.android_sdk = "~/.android-sdk"
      require("android-nvim").setup()
    end,
  },
  {
    "iamironz/android-nvim-plugin",
    lazy = false,
    -- enabled = false,
    config = function()
      require("android").setup()
    end,
  },
  -- {
  --   "AlexandrosAlexiou/kotlin.nvim",
  --   ft = { "kotlin" },
  --   dependencies = {
  --     "mason.nvim",
  --     "mason-lspconfig.nvim",
  --     "oil.nvim",
  --     {
  --       "folke/trouble.nvim",
  --       cmd = "Trouble",
  --       opts = {},
  --     },
  --   },
  --   config = function()
  --     require("kotlin").setup({
  --       -- Root markers for project detection
  --       root_markers = {
  --         "gradlew",
  --         ".git",
  --         "mvnw",
  --         "settings.gradle",
  --       },
  --
  --       jdk_for_symbol_resolution = nil, -- Auto-detect from project
  --
  --       -- Use bundled JRE from Mason to run the kotlin-lsp server (recommended)
  --       jre_path = vim.env.HOME .. "/../usr/lib/jvm/java-21-openjdk",
  --       -- Optional: Decrease heap for large projects
  --       jvm_args = {
  --         "-Xmx512m",
  --       },
  --
  --       -- Enable all inlay hints by default
  --       inlay_hints = {
  --         enabled = true,
  --         parameters = true,
  --         parameters_compiled = true,
  --         parameters_excluded = false,
  --         types_property = true,
  --         types_variable = true,
  --         function_return = true,
  --         function_parameter = true,
  --         lambda_return = true,
  --         lambda_receivers_parameters = true,
  --         value_ranges = true,
  --         kotlin_time = true,
  --       },
  --     })
  --
  --     -- Keymaps with <leader>lk prefix
  --     vim.keymap.set("n", "<leader>cka", ":KotlinCodeActions<CR>", { desc = "Kotlin code actions" })
  --     vim.keymap.set("n", "<leader>ckq", ":KotlinQuickFix<CR>", { desc = "Kotlin quick fix" })
  --     vim.keymap.set("n", "<leader>cko", ":KotlinOrganizeImports<CR>", { desc = "Organize Kotlin imports" })
  --     vim.keymap.set("n", "<leader>ckf", ":KotlinFormat<CR>", { desc = "Format Kotlin buffer (LSP)" })
  --     vim.keymap.set("n", "<leader>cks", ":KotlinSymbols<CR>", { desc = "Show Kotlin document symbols" })
  --     vim.keymap.set("n", "<leader>ckw", ":KotlinWorkspaceSymbols<CR>", { desc = "Search workspace symbols" })
  --     vim.keymap.set("n", "<leader>ckr", ":KotlinReferences<CR>", { desc = "Find Kotlin references" })
  --     vim.keymap.set("n", "<leader>ckn", ":KotlinRename<CR>", { desc = "Rename Kotlin symbol" })
  --     vim.keymap.set("n", "<leader>ckh", ":KotlinInlayHintsToggle<CR>", { desc = "Toggle Kotlin inlay hints" })
  --     vim.keymap.set("n", "<leader>ckc", ":KotlinCleanWorkspace<CR>", { desc = "Clean Kotlin workspace" })
  --   end,
  -- },
}
