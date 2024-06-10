local options = {
  transparent = true,
  styles = {
    comments = "italic",
  },
}
local palettes = {
  all = {
    -- comment = "#60728a",
    -- this is a comment
    green = "#99ff99",
    -- blue = "cyan",
    -- blue = { base = "#66a3b2", bright = "#67afcd", dim = "#5e91a5" },
    blue = { base = "#6bb89f", bright = "#6cc3a8", dim = "#62a48e" },
  },
}
local specs = {
  all = {
    syntax = {
      -- keyword = "red",
      -- operator = "green",
      -- conditional = "red",
      -- number = "magenta",
      variable = { base = "#d8b897", bright = "#e3bfa1", dim = "#bfa17a" },
      -- constant = "magenta",
      -- string = "magenta",
      -- type = "pink",
      -- preproc = "red",
      comment = "#556378",
    },
  },
}
local groups = {
  all = {},
}

return {
  {
    "EdenEast/nightfox.nvim",
    lazy = false,
    config = function()
      require("nightfox").setup({
        options = options,
        palettes = palettes,
        specs = specs,
        groups = groups,
      })
      vim.cmd("colorscheme carbonfox")
      --vim.cmd("colorscheme nightfox")
      --vim.cmd("colorscheme dawnfox")
    end,
  },
}
