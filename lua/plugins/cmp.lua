return {
  "hrsh7th/nvim-cmp",
  version = false, -- last release is way too old
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-vsnip", -- add this line for vim-vsnip
    "hrsh7th/vim-vsnip", -- add this line for vim-vsnip
    "rafamadriz/friendly-snippets", -- add this line for additional snippets
    "zbirenbaum/copilot.lua", -- Add Copilot as a dependency
    {
      "zbirenbaum/copilot-cmp",
      config = function()
        require("copilot_cmp").setup()
      end,
    },
    -- Add dadbod completion
    {
      "kristijanhusak/vim-dadbod-completion",
      config = function()
        vim.cmd([[
          augroup DadbodCompletion
            autocmd!
            autocmd FileType sql,mysql,plsql lua require('cmp').setup.buffer { sources = {{ name = 'vim-dadbod-completion' }} }
          augroup END
        ]])
      end,
    },
  },
  opts = function()
    vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
    local cmp = require("cmp")
    local defaults = require("cmp.config.default")()
    return {
      auto_brackets = {}, -- configure any filetype to auto add brackets
      completion = {
        completeopt = "menu,menuone,noinsert",
      },
      snippet = {
        expand = function(args)
          vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<C-l>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = LazyVim.cmp.confirm(),
        ["<S-CR>"] = LazyVim.cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        ["<C-CR>"] = function(fallback)
          cmp.abort()
          fallback()
        end,
      }),
      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "path" },
        { name = "copilot" }, -- Add Copilot as a source
        { name = "vim-dadbod-completion" }, -- Add Dadbod completion source
        { name = "vsnip" }, -- Add vsnip as a source
      }, {
        { name = "buffer" },
      }),
      formatting = {
        format = function(_, item)
          local icons = require("lazyvim.config").icons.kinds
          if icons[item.kind] then
            item.kind = icons[item.kind] .. item.kind
          end
          return item
        end,
      },
      experimental = {
        ghost_text = {
          hl_group = "CmpGhostText",
        },
      },
      sorting = defaults.sorting,
    }
  end,
  ---@param opts cmp.ConfigSchema | {auto_brackets?: string[]}
  config = function(_, opts)
    for _, source in ipairs(opts.sources) do
      source.group_index = source.group_index or 1
    end

    local parse = require("cmp.utils.snippet").parse
    require("cmp.utils.snippet").parse = function(input)
      local ok, ret = pcall(parse, input)
      if ok then
        return ret
      end
      return LazyVim.cmp.snippet_preview(input)
    end

    local cmp = require("cmp")
    cmp.setup(opts)
    cmp.event:on("confirm_done", function(event)
      if vim.tbl_contains(opts.auto_brackets or {}, vim.bo.filetype) then
        LazyVim.cmp.auto_brackets(event.entry)
      end
    end)
    cmp.event:on("menu_opened", function(event)
      LazyVim.cmp.add_missing_snippet_docs(event.window)
    end)

    -- -- Determine the base directory and path separator
    -- local is_windows = vim.loop.os_uname().version:match("Windows")
    -- local base_dir = is_windows and vim.fn.getenv("LOCALAPPDATA") .. "\\nvim"
    --   or vim.loop.os_homedir() .. "/.config/nvim"
    -- local path_sep = is_windows and "\\" or "/"
    --
    -- -- Define the custom snippet directory
    -- vim.g.vsnip_snippet_dir = base_dir .. path_sep .. "lua" .. path_sep .. "custom" .. path_sep .. "snippets"
    -- -- Load custom snippets
    -- vim.cmd([[
    --   augroup VsnipCustomSnippets
    --     autocmd!
    --     autocmd BufEnter *.cs lua require("vim-vsnip").load_file(vim.g.vsnip_snippet_dir .. "/cs.json")
    --   augroup END
    -- ]])
  end,
}
