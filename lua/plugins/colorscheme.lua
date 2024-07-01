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
    -- green = "#44ff99",
    green = "#00cc00",
    -- yellow = "#55FF00", -- updated to a brighter yellow
    -- white = "#77ff77",
    -- blue = "cyan",
    -- blue = { base = "#66a3b2", bright = "#67afcd", dim = "#5e91a5" },
    blue = { base = "#6bb89f", bright = "#6cc3a8", dim = "#62a48e" },
  },
}
local specs = {
  all = {
    syntax = {
      -- func = "cyan",
      -- keyword = "red",
      -- operator = "#c8b38a",
      -- conditional = "red",
      -- number = "magenta",
      -- variable = "#c8b38a",
      -- variable = "#789abc",
      -- variable = "#87bddd", -- slightly more blue
      -- variable = "#87bdbd", -- slightly more muted
      -- variable = "#a8a0a3", -- this is slightly whiter than #857483
      -- type = "#87bdbd",
      -- keyword = "#87bdbd",
      -- conditional = "#87bdbd",
      -- ident = "#87bdbd",
      -- statement = "#87bdbd",
      -- func = "#87bdbd",
      -- field = "#87bdbd",
      -- variable = "#abefef", -- slightly more green
      -- variable = "#abcdef",
      -- string = "magenta",
      -- type = "pink",
      -- preproc = "red",
      -- comment = "#556378",
      -- bracket = "#c8b38a",

      -- high contrast
      -- bracket = "#c8b38a", -- Brackets and Punctuation
      -- builtin0 = "#FF0000", -- Builtin variable
      -- builtin1 = "#00FFFF", -- Builtin type
      -- builtin2 = "#FFA500", -- Builtin const
      -- builtin3 = "#FF0000", -- Not used
      -- comment = "#556378", -- Comment
      -- conditional = "#FF00FF", -- Conditional and loop
      -- const = "#FFA500", -- Constants, imports and booleans
      -- dep = "#808080", -- Deprecated
      -- field = "#6060B2", -- Field
      -- func = "#6060B2", -- Functions and Titles
      -- ident = "#00FFFF", -- Identifiers
      -- keyword = "#FF00FF", -- Keywords
      -- number = "#FFA600", -- Numbers
      -- operator = "#c8b38a", -- Operators
      -- preproc = "#FFC0CB", -- PreProc
      -- regex = "#FFD700", -- Regex
      -- statement = "#FF00FF", -- Statements
      -- string = "green", -- Strings
      -- type = "#FFD700", -- Types
      -- variable = "#a8a0a3", -- Variables

      -- bracket = "#b9af8f", -- Brackets and Punctuation
      -- builtin0 = "#ff0000", -- Builtin variable
      builtin1 = "#29cccc", -- Builtin type
      -- builtin2 = "#ff0000", -- Builtin const
      builtin3 = "#ff7f7f", -- Not used
      -- builtin0 = "#FF8000", -- Builtin variable
      builtin2 = "#D2691E", -- Builtin const
      comment = "#55607d", -- Comment
      conditional = "#b227b2", -- Conditional and loop
      const = "#cc9629", -- Constants, imports and booleans
      -- dep = "#8f8f8f", -- Deprecated
      field = "#5f5fd4", -- Field
      func = "#5f5fd4", -- Functions and Titles

      -- field = "#5f5fb4", -- Field
      -- func = "#5f5fb4", -- Functions and Titles

      ident = "#29cccc", -- Identifiers
      keyword = "#b227b2", -- Keywords
      number = "#D2691E", -- Numbers
      -- operator = "#b9af8f", -- Operators
      preproc = "#ccacb3", -- PreProc
      regex = "#cc9629", -- Regex
      statement = "#b227b2", -- Statements
      string = "#00cc00", -- Strings
      type = "#D2691E", -- Types
      -- variable = "#c89fa3", -- Variables
      -- variable = "#a78f93", -- slightly darker
      -- variable = "#b898a3", -- slightly brighter
      variable = "#b898a3", -- Variables

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
      -- vim.cmd("colorscheme carbonfox")
      vim.cmd("colorscheme nightfox")
      --vim.cmd("colorscheme dawnfox")
    end,
  },
}
