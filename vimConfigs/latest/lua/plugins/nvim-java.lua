return {
  "nvim-java/nvim-java",
  enabled = false,
  ft = "java",
  config = function()
    require('java').setup()
    local mason = require("mason-registry")

    -- Check if JDTLS is installed via Mason
    if not mason.is_installed("jdtls") then
      vim.notify(
        "jdtls: Mason jdtls package not installed, aborting",
        vim.log.levels.WARN
      )
      return
    end


    local mason_path = vim.fn.expand("$HOME/.local/share/nvim/mason")

    local config = {
      cmd = { mason_path .. "/bin/jdtls" },
      root_dir = function()
        return vim.fs.dirname(
          vim.fs.find({ 'gradlew', '.git', 'mvnw' }, { upward = true })[1]
        )
      end,
      settings = {
        java = {
          jdt = {
            ls = {
              androidSupport = true,
              lombokSupport = true,
              protoBufSupport = true
            }
          }
        }
      }
    }

    require("lspconfig").jdtls.setup(config)
    -- local _ = jdtls.start_or_attach(config)
  end
}
