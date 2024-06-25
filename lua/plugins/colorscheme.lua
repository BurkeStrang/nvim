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
      func = "cyan",
      -- keyword = "red",
      operator = "#c8b38a",
      -- conditional = "red",
      -- number = "magenta",
      -- variable = "#c8b38a",
      variable = "#abcdef",
      -- string = "magenta",
      -- type = "pink",
      -- preproc = "red",
      comment = "#556378",

      -- this is the default for carbonfox
      -- bracket     = spec.fg2,           -- Brackets and Punctuation
      -- builtin0    = pal.red.base,       -- Builtin variable
      -- builtin1    = pal.cyan.bright,    -- Builtin type
      -- builtin2    = pal.orange.bright,  -- Builtin const
      -- builtin3    = pal.red.bright,     -- Not used
      -- comment     = pal.comment,        -- Comment
      -- conditional = pal.magenta.bright, -- Conditional and loop
      -- const       = pal.orange.bright,  -- Constants, imports and booleans
      -- dep         = spec.fg3,           -- Deprecated
      -- field       = pal.blue.base,      -- Field
      -- func        = pal.blue.bright,    -- Functions and Titles
      -- ident       = pal.cyan.base,      -- Identifiers
      -- keyword     = pal.magenta.base,   -- Keywords
      -- number      = pal.orange.base,    -- Numbers
      -- operator    = spec.fg2,           -- Operators
      -- preproc     = pal.pink.bright,    -- PreProc
      -- regex       = pal.yellow.bright,  -- Regex
      -- statement   = pal.magenta.base,   -- Statements
      -- string      = pal.green.base,     -- Strings
      -- type        = pal.yellow.base,    -- Types
      -- variable    = pal.white.base,     -- Variables
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
