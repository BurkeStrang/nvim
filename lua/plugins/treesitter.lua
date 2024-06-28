return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "c_sharp",
        "python",
        "css",
        "html",
        "java",
        -- Add any other languages you need here
      },
      highlight = {
        enable = true,
      },
    },
  },
}
