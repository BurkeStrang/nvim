return {
  "L3MON4D3/LuaSnip",
  version = "v2.*", -- Follow latest release
  build = "make install_jsregexp", -- Install jsregexp (optional)
  config = function()
    require("luasnip.loaders.from_vscode").lazy_load({ paths = { ".custom/my-cool-snippets" } })
  end,
}
