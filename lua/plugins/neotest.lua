local neotest_keys = {
  {
    "n",
    "<leader>ts",
    function()
      require("neotest").summary.toggle()
    end,
    { desc = "Neotest: Open test summary window" },
  },
  {
    "n",
    "<leader>tf",
    function()
      require("neotest").run.run(vim.fn.expand("%"))
    end,
    { desc = "Neotest: Run tests in file" },
  },
  {
    "n",
    "<leader>tn",
    function()
      require("neotest").run.run()
    end,
    { desc = "Neotest: Run nearest test" },
  },
  {
    "n",
    "<leader>td",
    function()
      require("neotest").run.run({ strategy = "dap" })
    end,
    { desc = "Neotest: Debug nearest test" },
  },
  {
    "n",
    "<leader>ta",
    function()
      require("neotest").run.run({ suite = true })
    end,
    { desc = "Neotest: Run all tests in suite" },
  },
}

--- Creates a set of keymaps for lazy.nvim plugin configuration
---@param mappings table List of mapping configurations compatible with vim.api.nvim_set_keymap()
---@param[opt=false] perform_bind boolean True if the bindings should not be made by lazy.nvim
---@return table Lazy Compatible keymaps
function make_lazy_keymaps(mappings, perform_bind)
  local lazy_keys = {}
  for _, map in ipairs(mappings) do
    table.insert(
      lazy_keys,
      vim.tbl_deep_extend("force", {
        map[2],
        perform_bind and map[3] or nil,
        mode = map[1],
      }, map[4] or {})
    )
  end

  return lazy_keys
end

return {
  {
    "nvim-neotest/neotest",
    event = "VeryLazy",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-neotest/nvim-nio",
      "nvim-neotest/neotest-python",
      "nvim-neotest/neotest-plenary",
      "nvim-neotest/neotest-jest",
      "Issafalcon/neotest-dotnet",
      -- { dir = "~/repos/neotest-dotnet" },
    },
    keys = make_lazy_keymaps(neotest_keys, true),
    config = function()
      local neotest = require("neotest")
      neotest.setup({
        log_level = 1, -- For verbose logs
        adapters = {
          require("neotest-python")({
            dap = { justMyCode = false },
          }),
          require("neotest-plenary"),
          require("neotest-dotnet")({
            discovery_root = "solution",
          }),
          require("neotest-jest")({
            jestCommand = "npm test -- --runInBand --no-cache --watchAll=false",
            env = { CI = "true" },
            cwd = function(path)
              return vim.fn.getcwd()
            end,
          }),
        },
        icons = {
          expanded = "",
          child_prefix = "",
          child_indent = "",
          final_child_prefix = "",
          non_collapsible = "",
          collapsed = "",
          passed = "",
          running = "",
          failed = "",
          unknown = "",
          skipped = "",
        },
      })
    end,
  },
}
