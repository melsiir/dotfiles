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
  "idelice/nvim-jls",
  -- enabled = false,
  -- lazy = false,
  opts = {
    jls_dir = "/data/data/com.termux/files/home/.jls", -- must contain dist/lang_server_*.sh
    filetypes = { "java" },
    root_markers = {
      "pom.xml",
      "build.gradle",
      "build.gradle.kts",
      "settings.gradle",
      "settings.gradle.kts",
      "WORKSPACE",
      "WORKSPACE.bazel",
      ".java-version",
      ".git",
    },
    settings = (function()
      local project_config = read_project_config()
      if project_config then
        -- Wrap in "java" key as jls expects
        return { java = project_config }
      end
      -- Fallback default config
      return {
        java = {
          externalDependencies = {},
        },
      }
    end)(),
  },
}
