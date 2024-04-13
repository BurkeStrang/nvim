return {
  {
    -- {
    --   "vhyrro/luarocks.nvim",
    --   priority = 1000,
    --   config = true,
    --   opts = {
    --     -- these are not working had to install with luarocks manually with lua 5.1
    --     -- specify paths in command as follows:
    --     --  luarocks install mimetypes LUA_INCDIR=/usr/include/lua5.1
    --     --  luarocks install lua-curl CURL_INCDIR=/usr/include/x86_64-linux-gnu LUA_INCDIR=/usr/include/lua5.1
    --     rocks = { "lua-curl", "nvim-nio", "mimetypes", "xml2lua" },
    --     -- luarocks_build_args = { "--with-lua=/usr/include/lua5.1" },
    --   },
    -- },
    -- {
    --   "rest-nvim/rest.nvim",
    --   ft = "http",
    --   dependencies = { "luarocks.nvim" },
    --   config = function()
    --     require("rest-nvim").setup()
    --   end,
    -- },
    "BlackLight/nvim-http",
  },
}
