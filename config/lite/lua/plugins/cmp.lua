local transparentCmp = {
  -- for transparent themes
  winhighlight = "Normal:CmpPmenu,Search:None,FloatBorder:WinSeparator",
  scrollbar = false,
  side_padding = 1,
}

return { -- Autocompletion
  -- "hrsh7th/nvim-cmp",
  -- name = "nvim-cmp",
  "iguanacucumber/magazine.nvim",
  name = "nvim-cmp", -- Otherwise highlighting gets messed up
  event = "InsertEnter *",

  -- event = "VeryLazy",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "brenoprata10/nvim-highlight-colors",
    -- Adds other completion capabilities.
    --  nvim-cmp does not ship with all sources by default. They are split
    --  into multiple repos for maintenance purposes.
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    -- "hrsh7th/cmp-path",
    "FelipeLema/cmp-async-path",
    "f3fora/cmp-spell",
    "hrsh7th/cmp-cmdline",
    "saadparwaiz1/cmp_luasnip",
    -- Adds a number of user-friendly snippets
    "rafamadriz/friendly-snippets",
    -- Snippet Engine & its associated nvim-cmp source
    {
      "L3MON4D3/LuaSnip",
      build = (function()
        -- Build Step is needed for regex support in snippets
        -- This step is not supported in many windows environments
        -- Remove the below condition to re-enable on windows
        if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
          return
        end
        return "make install_jsregexp"
      end)(),
    },
  },
  opts = function()
    local cmp = require("cmp")
    require("luasnip.loaders.from_vscode").lazy_load()
    local luasnip = require("luasnip")
    luasnip.config.setup({})

    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = "path" },
      }, {
        {
          name = "cmdline",
          option = {
            ignore_cmds = { "Man", "!" },
          },
        },
      }),
    })

    cmp.setup.cmdline("/", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = "buffer" },
      },
    })
    -- load custom fish snippets
    require("luasnip.loaders.from_vscode").lazy_load({ paths = "./lua/config/snippets" })
    return {
      completion = {
        completeopt = "menu,menuone",
      },

      snippet = {
        expand = function(args)
          require("luasnip").lsp_expand(args.body)
        end,
      },

      mapping = {
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        ["<C-n>"] = cmp.mapping.select_next_item(),
        ["<UP>"] = cmp.mapping.select_prev_item(),
        ["<DOWN>"] = cmp.mapping.select_next_item(),
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.close(),

        ["<CR>"] = cmp.mapping.confirm({
          behavior = cmp.ConfirmBehavior.Insert,
          select = true,
        }),
        -- comment this if you want to use arrows to navigate suggestions
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif require("luasnip").expand_or_jumpable() then
            require("luasnip").expand_or_jump()
          else
            fallback()
          end
        end, { "i", "s" }),

        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif require("luasnip").jumpable(-1) then
            require("luasnip").jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
        ["K"] = cmp.mapping(function(fallback)
          if cmp.visible_docs() then
            cmp.close_docs()
          elseif cmp.visible() then
            cmp.open_docs()
          else
            fallback()
          end
        end),
      },

      view = { docs = { auto_open = false } },
      sources = {
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "buffer" },
        { name = "nvim_lua" },
        -- { name = "path" },
        { name = "spell", keyword_length = 3 },
        { name = "async_path", keyword_length = 2 },
      },
      formatting = {
        format = function(entry, item)
          local icons = require("config.icons").default
          item.abbr = item.abbr .. " "

          item.menu = item.kind

          item.menu_hl_group = "CmpItemKind" .. (item.kind or "")
          item.kind = (icons[item.kind] or "") .. " "

          item.kind = " " .. item.kind

          return item
        end,

        fields = { "abbr", "kind", "menu" },
      },
      window = {
        completion = {
          border = "rounded",
          winhighlight = "Normal:CmpPmenu,Search:None,FloatBorder:WinSeparator",
          scrollbar = false,
        },
        documentation = {
          border = "rounded",
          winhighlight = "Normal:CmpDoc,Search:None,FloatBorder:WinSeparator",
          max_height = math.floor(vim.o.lines * 0.5),
          max_width = math.floor(vim.o.columns * 0.4),
        },
      },
      -- window = {
      --   completion = cmp.config.window.bordered(vim.g.transparant and transparentCmp or {
      --     scrollbar = false,
      --     side_padding = 1,
      --   }),
      --   documentation = cmp.config.window.bordered({
      --     -- for transparent themes
      --     winhighlight = "Normal:CmpDoc,Search:None,FloatBorder:WinSeparator",
      --   }),
      -- },
    }
  end,
}
