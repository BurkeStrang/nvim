return {
  "nvimdev/dashboard-nvim",
  lazy = false, -- As https://github.com/nvimdev/dashboard-nvim/pull/450, dashboard-nvim shouldn't be lazy-loaded to properly handle stdin.
  opts = function()
    local logo =
      "\n\n\n\n\n\nI'm not a great programmer;\n\nI'm just a good programmer with great habits.\n\n~ kent Beck\n\n\n"

    local opts = {
      theme = "doom",
      hide = {
        -- this is taken care of by lualine
        -- enabling this messes up the actual laststatus setting after loading a file
        statusline = false,
      },
      config = {
        header = vim.split(logo, "\n"),
        -- stylua: ignore
        center = {
          { action = LazyVim.pick("files"),                                     desc = " Find File",       icon = " ", key = "f", desc_hl = "DashboardDesc", icon_hl = "DashboardIcon", key_hl = "DashboardKey"},
          { action = "ene | startinsert",                                        desc = " New File",        icon = " ", key = "n", desc_hl = "DashboardDesc", icon_hl = "DashboardIcon", key_hl = "DashboardKey" },
          { action = "Telescope oldfiles",                                       desc = " Recent Files",    icon = " ", key = "r", desc_hl = "DashboardDesc", icon_hl = "DashboardIcon", key_hl = "DashboardKey" },
          { action = "Telescope live_grep",                                      desc = " Find Text",       icon = " ", key = "g", desc_hl = "DashboardDesc", icon_hl = "DashboardIcon", key_hl = "DashboardKey" },
          { action = [[lua LazyVim.pick.config_files()()]],                 desc = " Config",          icon = " ", key = "c", desc_hl = "DashboardDesc", icon_hl = "DashboardIcon", key_hl = "DashboardKey" },
          { action = 'lua require("persistence").load()',                        desc = " Restore Session", icon = " ", key = "s", desc_hl = "DashboardDesc", icon_hl = "DashboardIcon", key_hl = "DashboardKey" },
          { action = "LazyExtras",                                               desc = " Lazy Extras",     icon = " ", key = "x", desc_hl = "DashboardDesc", icon_hl = "DashboardIcon", key_hl = "DashboardKey" },
          { action = "Lazy",                                                     desc = " Lazy",            icon = "󰒲 ", key = "l", desc_hl = "DashboardDesc", icon_hl = "DashboardIcon", key_hl = "DashboardKey" },
          { action = "qa",                                                       desc = " Quit",            icon = " ", key = "q", desc_hl = "DashboardDesc", icon_hl = "DashboardIcon", key_hl = "DashboardKey" },
        },
        footer = function()
          local stats = require("lazy").stats()
          local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
          return { "", "⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms" }
        end,
      },
    }

    for _, button in ipairs(opts.config.center) do
      button.desc = button.desc .. string.rep(" ", 25 - #button.desc)
      button.key_format = "  %s"
    end

    -- close Lazy and re-open when the dashboard is ready
    if vim.o.filetype == "lazy" then
      vim.cmd.close()
      vim.api.nvim_create_autocmd("User", {
        pattern = "DashboardLoaded",
        callback = function()
          require("lazy").show()
        end,
      })
    end

    return opts
  end,
}
