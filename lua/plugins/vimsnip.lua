return {
  {
    "hrsh7th/vim-vsnip",
    config = function()
      -- You can add additional configuration here if needed
      vim.g.vsnip_snippet_dir = vim.fn.stdpath("config") .. "/lua/custom/snippets"
    end,
  },
  -- Other plugins...
}
