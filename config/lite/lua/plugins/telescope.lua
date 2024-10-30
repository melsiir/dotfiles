local have_make = vim.fn.executable("make") == 1
local have_cmake = vim.fn.executable("cmake") == 1
local actions = require("telescope.actions")
local builtin = require("telescope.builtin")

function findConfig()
  builtin.find_files({
    cwd = vim.fn.stdpath("config"),
    prompt_title = "neovim config",
  })
end
function teleColorScheme()
  builtin.colorscheme({
    enable_preview = true,
    prompt_title = "neovim themes",
  })
end

return {
  -- Fuzzy finder.
  -- The default key bindings to find files will use Telescope's
  -- `find_files` or `git_files` depending on whether the
  -- directory is a git repo.
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    version = false, -- telescope did only one release, so use HEAD for now
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = have_make and "make"
          or "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
        enabled = have_make or have_cmake,
      },
    },
    keys = {
      {
        "<leader>,",
        "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>",
        desc = "Switch Buffer",
      },
      { "<leader>/", builtin.live_grep, desc = "Grep (Root Dir)" },
      { "<leader>:", "<cmd>Telescope command_history<cr>", desc = "Command History" },
      { "<leader><space>", builtin.find_files, desc = "Find Files (Root Dir)" },
      -- find
      { "<leader>fb", "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>", desc = "Buffers" },
      -- { "<leader>fc", builtin.find_files({cwd = vim.fn.stdpath("config")}), desc = "Find Config File" },
      { "<leader>fc", findConfig, desc = "Find Config File" },
      { "<leader>ff", builtin.find_files, desc = "Find Files (Root Dir)" },
      { "<leader>fg", "<cmd>Telescope git_files<cr>", desc = "Find Files (git-files)" },
      { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent" },
      { "<leader>f/", builtin.current_buffer_fuzzy_find, desc = "Grep current buffer" },
      -- { "<leader>fR", builtin("oldfiles", { cwd = vim.uv.cwd() }), desc = "Recent (cwd)" },
      -- -- git
      { "<leader>gc", "<cmd>Telescope git_commits<CR>", desc = "Commits" },
      { "<leader>gs", "<cmd>Telescope git_status<CR>", desc = "Status" },
      -- search
      { '<leader>s"', "<cmd>Telescope registers<cr>", desc = "Registers" },
      { "<leader>sa", "<cmd>Telescope autocommands<cr>", desc = "Auto Commands" },
      { "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Buffer" },
      { "<leader>sc", "<cmd>Telescope command_history<cr>", desc = "Command History" },
      { "<leader>sC", "<cmd>Telescope commands<cr>", desc = "Commands" },
      { "<leader>sd", "<cmd>Telescope diagnostics bufnr=0<cr>", desc = "Document Diagnostics" },
      { "<leader>sD", "<cmd>Telescope diagnostics<cr>", desc = "Workspace Diagnostics" },
      { "<leader>sg", builtin.live_grep, desc = "Grep (Root Dir)" },
      { "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Help Pages" },
      { "<leader>sH", "<cmd>Telescope highlights<cr>", desc = "Search Highlight Groups" },
      { "<leader>sj", "<cmd>Telescope jumplist<cr>", desc = "Jumplist" },
      { "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "Key Maps" },
      { "<leader>sl", "<cmd>Telescope loclist<cr>", desc = "Location List" },
      { "<leader>sM", "<cmd>Telescope man_pages<cr>", desc = "Man Pages" },
      { "<leader>sm", "<cmd>Telescope marks<cr>", desc = "Jump to Mark" },
      { "<leader>so", "<cmd>Telescope vim_options<cr>", desc = "Options" },
      { "<leader>sR", "<cmd>Telescope resume<cr>", desc = "Resume" },
      { "<leader>sq", "<cmd>Telescope quickfix<cr>", desc = "Quickfix List" },
      -- { "<leader>sw", builtin("grep_string", { word_match = "-w" }), desc = "Word (Root Dir)" },
      -- { "<leader>sW", builtin("grep_string", { root = false, word_match = "-w" }), desc = "Word (cwd)" },
      -- { "<leader>sw", builtin("grep_string"), mode = "v", desc = "Selection (Root Dir)" },
      -- { "<leader>sW", builtin("grep_string", { root = false }), mode = "v", desc = "Selection (cwd)" },
      { "<leader>uc", teleColorScheme, { enable_preview = true }, desc = "Colorscheme with Preview" },
    },
    opts = function()
      local actions = require("telescope.actions")

      local open_with_trouble = function(...)
        return require("trouble.sources.telescope").open(...)
      end
      local find_files_no_ignore = function()
        local action_state = require("telescope.actions.state")
        local line = action_state.get_current_line()
        builtin("find_files", { no_ignore = true, default_text = line })()
      end
      local find_files_with_hidden = function()
        local action_state = require("telescope.actions.state")
        local line = action_state.get_current_line()
        builtin("find_files", { hidden = true, default_text = line })()
      end

      local function find_command()
        return {
          "fd",
          "--type",
          "f",
          "--color",
          "never",
          "-E",
          ".git",
          -- "--ignore-file",
          -- vim.fn.expand("$HOME") .. "/.gitignore",
        }
        -- if 1 == vim.fn.executable("rg") then
        --   return { "rg", "--files", "--color", "never", "-g", "!.git" }
        -- elseif 1 == vim.fn.executable("fd") then
        --   return { "fd", "--type", "f", "--color", "never", "-E", ".git" }
        -- elseif 1 == vim.fn.executable("find") and vim.fn.has("win32") == 0 then
        --   return { "find", ".", "-type", "f" }
        -- end
      end
      pcall(require("telescope").load_extension, "fzf")
      pcall(require("telescope").load_extension, "ui-select")
      return {
        defaults = {
          -------
          -- sorting_strategy = "ascending",
          -- layout_config = {
          --   horizontal = {
          --     prompt_position = "top",
          --     preview_width = 0.55,
          --   },
          --   width = 0.87,
          --   height = 0.80,
          -- },
          --------
          -- prompt_prefix = "   ",
          prompt_prefix = "   ",
          selection_caret = " ",
          multi_icon = "",
          winblend = 0,
          color_devicons = true,
          border = true,
          -- open files in the first window that is an actual file.
          -- use the current window if no other window is available.
          get_selection_window = function()
            local wins = vim.api.nvim_list_wins()
            table.insert(wins, 1, vim.api.nvim_get_current_win())
            for _, win in ipairs(wins) do
              local buf = vim.api.nvim_win_get_buf(win)
              if vim.bo[buf].buftype == "" then
                return win
              end
            end
            return 0
          end,
          mappings = {
            i = {
              ["<c-t>"] = open_with_trouble,
              ["<a-t>"] = open_with_trouble,
              ["<a-i>"] = find_files_no_ignore,
              ["<a-h>"] = find_files_with_hidden,
              ["<C-Down>"] = actions.cycle_history_next,
              ["<C-Up>"] = actions.cycle_history_prev,
              ["<C-f>"] = actions.preview_scrolling_down,
              ["<C-b>"] = actions.preview_scrolling_up,
            },
            n = {
              ["q"] = actions.close,
            },
          },
        },
        pickers = {
          find_files = {
            find_command = find_command,
            -- file_ignore_patterns = { 'node_modules', '.git', '.venv' },
            hidden = true,
          },
        },
        live_grep = {
          file_ignore_patterns = { "node_modules", ".git", ".venv" },
          additional_args = function(_)
            return { "--hidden" }
          end,
        },
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown(),
          },
        },
      }
      -- Enable telescope fzf native, if installed
      -- pcall(require('telescope').load_extension, 'fzf')
      -- pcall(require('telescope').load_extension, 'ui-select')
    end,
  },

  -- Flash Telescope config
  -- {
  --   "nvim-telescope/telescope.nvim",
  --   optional = true,
  --   opts = function(_, opts)
  --     if not LazyVim.has("flash.nvim") then
  --       return
  --     end
  --     local function flash(prompt_bufnr)
  --       require("flash").jump({
  --         pattern = "^",
  --         label = { after = { 0, 0 } },
  --         search = {
  --           mode = "search",
  --           exclude = {
  --             function(win)
  --               return vim.bo[vim.api.nvim_win_get_buf(win)].filetype ~= "TelescopeResults"
  --             end,
  --           },
  --         },
  --         action = function(match)
  --           local picker = require("telescope.actions.state").get_current_picker(prompt_bufnr)
  --           picker:set_selection(match.pos[1] - 1)
  --         end,
  --       })
  --     end
  --     opts.defaults = vim.tbl_deep_extend("force", opts.defaults or {}, {
  --       mappings = { n = { s = flash }, i = { ["<c-s>"] = flash } },
  --     })
  --   end,
  -- },
  --
  -- better vim.ui with telescope
  -- {
  --   "stevearc/dressing.nvim",
  --   lazy = true,
  --   -- enabled = function()
  --   --   return builtin.want() == "telescope"
  --   -- end,
  --   init = function()
  --     ---@diagnostic disable-next-line: duplicate-set-field
  --     vim.ui.select = function(...)
  --       require("lazy").load({ plugins = { "dressing.nvim" } })
  --       return vim.ui.select(...)
  --     end
  --     ---@diagnostic disable-next-line: duplicate-set-field
  --     vim.ui.input = function(...)
  --       require("lazy").load({ plugins = { "dressing.nvim" } })
  --       return vim.ui.input(...)
  --     end
  --   end,
  -- },

  -- {
  --   "neovim/nvim-lspconfig",
  --   opts = function()
  --     if builtin.want() ~= "telescope" then
  --       return
  --     end
  --     local Keys = require("lazyvim.plugins.lsp.keymaps").get()
  --     -- stylua: ignore
  --     vim.list_extend(Keys, {
  --       { "gd", function() require("telescope.builtin").lsp_definitions({ reuse_win = true }) end, desc = "Goto Definition", has = "definition" },
  --       { "gr", "<cmd>Telescope lsp_references<cr>", desc = "References", nowait = true },
  --       { "gI", function() require("telescope.builtin").lsp_implementations({ reuse_win = true }) end, desc = "Goto Implementation" },
  --       { "gy", function() require("telescope.builtin").lsp_type_definitions({ reuse_win = true }) end, desc = "Goto T[y]pe Definition" },
  --     })
  --   end,
  -- },
}
