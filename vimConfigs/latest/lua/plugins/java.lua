if false then
  return {}
end

local M = {}

-- Read .java-language-server.json file if it exists
local function read_project_config()
  local file = vim.fn.findfile(".java-language-server.json", ".;")
  if file == "" then
    return nil
  end

  local f = io.open(file, "r")
  if not f then
    return nil
  end

  local content = f:read("*a")
  f:close()

  -- Parse JSON (simple implementation)
  local ok, decoded = pcall(vim.fn.json_decode, content)
  if not ok or type(decoded) ~= "table" then
    return nil
  end

  return decoded
end

return {
  {
    "mfussenegger/nvim-jdtls",
    -- enabled = false,
    ft = { "java" },
    config = {
      -- set jdtls server settings
      jdtls = {
        function()
          -- use this function notation to build some variables
          local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }
          local root_dir = require("jdtls.setup").find_root(root_markers)
          -- calculate workspace dir
          local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
          local workspace_dir = vim.fn.stdpath("data") .. "/site/java/workspace-root/" .. project_name
          os.execute("mkdir " .. workspace_dir)
          -- get the mason install path
          -- local install_path = require("mason-registry").get_package("jdtls"):get_install_path()
          local install_path = "~/.local/share/nvim/mason/packages/jdtls" -- get the current OS
          local os
          if vim.fn.has("macunix") then
            os = "mac"
          elseif vim.fn.has("win32") then
            os = "win"
          else
            os = "linux"
          end
          -- return the server config
          return {
            cmd = {
              "java",
              "-Declipse.application=org.eclipse.jdt.ls.core.id1",
              "-Dosgi.bundles.defaultStartLevel=4",
              "-Declipse.product=org.eclipse.jdt.ls.core.product",
              "-Dlog.protocol=true",
              "-Dlog.level=ALL",
              "-javaagent:" .. install_path .. "/lombok.jar",
              "-Xms1g",
              "--add-modules=ALL-SYSTEM",
              "--add-opens",
              "java.base/java.util=ALL-UNNAMED",
              "--add-opens",
              "java.base/java.lang=ALL-UNNAMED",
              "-jar",
              vim.fn.glob(install_path .. "/plugins/org.eclipse.equinox.launcher_*.jar"),
              "-configuration",
              install_path .. "/config_" .. os,
              "-data",
              workspace_dir,
            },
            root_dir = root_dir,
          }
        end,
      },
    },
  },

  -- {
  --   "idelice/nvim-jls",
  --   enabled = false,
  --   -- lazy = false,
  --   opts = {
  --     jls_dir = "/data/data/com.termux/files/home/.jls", -- must contain dist/lang_server_*.sh
  --     filetypes = { "java" },
  --     root_markers = {
  --       "pom.xml",
  --       "build.gradle",
  --       "build.gradle.kts",
  --       "settings.gradle",
  --       "settings.gradle.kts",
  --       "WORKSPACE",
  --       "WORKSPACE.bazel",
  --       ".java-version",
  --       ".git",
  --     },
  --     settings = (function()
  --       local project_config = read_project_config()
  --       if project_config then
  --         -- Wrap in "java" key as jls expects
  --         return { java = project_config }
  --       end
  --       -- Fallback default config
  --       return {
  --         java = {
  --           externalDependencies = {},
  --         },
  --       }
  --     end)(),
  --   }
  -- },
  {
    "NickJAllen/java-helpers.nvim",
    cmd = {
      "JavaHelpersNewFile",
      "JavaHelpersPickStackTraceLine",
      "JavaHelpersGoToStackTraceLine",
      "JavaHelpersGoUpStackTrace",
      "JavaHelpersGoDownStackTrace",
      "JavaHelpersGoToBottomOfStackTrace",
      "JavaHelpersGoToTopOfStackTrace",
      "JavaHelpersSendStackTraceToQuickfix",
    },

    -- Default options are shown here. If opts is missing or left empty then these defaults will be used.
    opts = {

      ---Each template has a name and some template source code.
      ---${package_decl} and ${name} will be replaced with the package declaration and name for the Java type being created.
      ---If ${pos} is provided then the cursor will be positioned there ready to type.
      ---@type TemplateDefinition[]
      templates = {},

      ---Defines patters to recognize Java source directories in order to determine the package name.
      ---@type string[]
      java_source_dirs = { "src/main/java", "src/test/java", "src" },

      ---If true then newly created Java files will be formatted
      ---@type boolean
      should_format = true,
    },

    -- Example keys - change these as you like
    keys = {
      { "<leader>jn", ":JavaHelpersNewFile<cr>", desc = "New Java Type" },
      { "<leader>jc", ":JavaHelpersNewFile Class<cr>", desc = "New Java Class" },
      { "<leader>ji", ":JavaHelpersNewFile Interface<cr>", desc = "New Java Interface" },
      { "<leader>ja", ":JavaHelpersNewFile Abstract Class<cr>", desc = "New Abstract Java Class" },
      { "<leader>jr", ":JavaHelpersNewFile Record<cr>", desc = "New Java Record" },
      { "<leader>je", ":JavaHelpersNewFile Enum<cr>", desc = "New Java Enum" },
      { "<leader>sj", ":JavaHelpersPickStackTraceLine<cr>", desc = "Pick Java stack trace line" },
      { "<leader>js", ":JavaHelpersGoToStackTraceLine<cr>", desc = "Go to Java stack trace line" },
      { "[j", ":JavaHelpersGoUpStackTrace<cr>", desc = "Go up Java stack trace" },
      { "]j", ":JavaHelpersGoDownStackTrace<cr>", desc = "Go down Java stack trace" },
      { "<leader>[j", ":JavaHelpersGoToTopOfStackTrace<cr>", desc = "Go to top of Java stack trace" },
      { "<leader>]j", ":JavaHelpersGoToBottomOfStackTrace<cr>", desc = "Go to bottom of Java stack trace" },
      { "<leader>jq", ":JavaHelpersSendStackTraceToQuickfix<cr>", desc = "Send Java stack trace to quickfix list" },
    },

    dependencies = {
      { "nvim-lua/plenary.nvim" },
    },
  },
}
