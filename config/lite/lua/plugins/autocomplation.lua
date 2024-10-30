local fields = { "abbr", "kind", "menu" }

local tailwind = function(entry, item)
  local entryItem = entry:get_completion_item()
  local color = entryItem.documentation

  if color and type(color) == "string" and color:match("^#%x%x%x%x%x%x$") then
    local hl = "hex-" .. color:sub(2)

    if #api.nvim_get_hl(0, { name = hl }) == 0 then
      api.nvim_set_hl(0, hl, { fg = color })
    end

    item.kind = cmp_ui.icons_left and colors_icon or " " .. colors_icon
    item.kind_hl_group = hl
    item.menu_hl_group = hl
  end
end

return { -- Autocompletion
  -- "hrsh7th/nvim-cmp",
  -- name = "nvim-cmp",
  "iguanacucumber/magazine.nvim",
  name = "nvim-cmp", -- Otherwise highlighting gets messed up
  event = "InsertEnter *",

  -- event = "VeryLazy",
  dependencies = {
    "hrsh7th/cmp-cmdline",
    "nvim-lua/plenary.nvim",
    { "hrsh7th/cmp-cmdline" },
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

    -- Adds other completion capabilities.
    --  nvim-cmp does not ship with all sources by default. They are split
    --  into multiple repos for maintenance purposes.
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "saadparwaiz1/cmp_luasnip",
    -- Adds a number of user-friendly snippets
    "rafamadriz/friendly-snippets",
  },
  config = function()
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
    local kind_icons = {
      Namespace = "󰌗",
      Text = "󰉿",
      Method = "󰆧",
      Function = "󰆧",
      Constructor = "",
      Field = "󰜢",
      Variable = "󰀫",
      Class = "󰠱",
      Interface = "",
      Module = "",
      Property = "󰜢",
      Unit = "󰑭",
      Value = "󰎠",
      Enum = "",
      Keyword = "󰌋",
      Snippet = "",
      Color = "󰏘",
      File = "󰈚",
      Reference = "󰈇",
      Folder = "󰉋",
      EnumMember = "",
      Constant = "󰏿",
      Struct = "󰙅",
      Event = "",
      Operator = "󰆕",
      TypeParameter = "󰊄",
      Table = "",
      Object = "󰅩",
      Tag = "",
      Array = "[]",
      Boolean = "",
      Number = "",
      Null = "󰟢",
      Supermaven = "",
      String = "󰉿",
      Calendar = "",
      Watch = "󰥔",
      Package = "",
      Copilot = "",
      Codeium = "",
      TabNine = "",
      BladeNav = "",
    }
    cmp.setup({
      completion = { completeopt = "menu,menuone" },

      snippet = {
        expand = function(args)
          require("luasnip").lsp_expand(args.body)
        end,
      },

      mapping = {
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        ["<C-n>"] = cmp.mapping.select_next_item(),
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.close(),

        ["<CR>"] = cmp.mapping.confirm({
          behavior = cmp.ConfirmBehavior.Insert,
          select = true,
        }),

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
      },

      sources = {
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "buffer" },
        { name = "cmdline" },
        { name = "nvim_lua" },
        { name = "path" },
      },
      formatting = {
        format = function(entry, item)
          local icons = kind_icons

          item.abbr = item.abbr .. " "

          item.menu = item.kind

          item.menu_hl_group = "CmpItemKind" .. (item.kind or "")
          item.kind = (icons[item.kind] or "") .. " "

          item.kind = " " .. item.kind

          -- if cmp_ui.format_colors.tailwind then
          --   format_kk.tailwind(entry, item)
          -- end

          return item
        end,

        fields = fields,
      },

      window = {
        -- completion = {
        --   scrollbar = false,
        --   side_padding = 1,
        --   winhighlight = "Normal:CmpPmenu,Search:None,FloatBorder:CmpBorder",
        --   border = "single",
        -- },

        completion = cmp.config.window.bordered({
          scrollbar = false,
          side_padding = 1,
          -- for transparent themes
          -- winhighlight = "Normal:CmpPmenu", --comment on none transparent themes or when using nord transparent
          -- border = "single",
        }),
        umentation = cmp.config.window.bordered({
          -- for transparent themes
          -- winhighlight = "Normal:CmpDoc",
        }),
      },
    })
    -- load custom fish snippets
    require("luasnip.loaders.from_vscode").lazy_load({ paths = "./lua/config/snippets" })
  end,
}
