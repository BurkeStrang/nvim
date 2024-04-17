return {
  "numToStr/Comment.nvim",
  dependencies = "JoosepAlviste/nvim-ts-context-commentstring",
  keys = {
    { "gcc", mode = "n" },
    { "gbc", mode = "n" },

    { "gc", mode = { "n", "v" } },
    { "gb", mode = { "n", "v" } },

    { "gco", mode = "n" },
    { "gcA", mode = "n" },
    { "gcO", mode = "n" },
  },
  config = function()
    require("Comment").setup({
      pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
    })
  end,
}
