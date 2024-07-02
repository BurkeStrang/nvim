local dap_keys = {
  {
    "n",
    "<F5>",
    ':lua require"osv".launch({port=8086})<CR>',
    { desc = "DAP Continue" },
  },
  {
    "n",
    "<F9>",
    ':lua require"dap".continue()<CR>',
    { desc = "DAP Continue" },
  },
  {
    "n",
    "<leader>ib",
    ':lua require"dap".toggle_breakpoint()<CR>',
    { desc = "DAP Toggle Breakpoint" },
  },
  {
    "n",
    "<leader>iB",
    ':lua require"dap".set_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>',
    { desc = "DAP Toggle Conditional Breakpoint" },
  },
  {
    "n",
    "<leader>ie",
    ':lua require"dap".set_exception_breakpoints()<CR>',
    { desc = "DAP Set breakpoints on exceptions" },
  },
  {
    "n",
    "<leader>ibc",
    ':lua require"dap".clear_breakpoints()<CR>',
    { desc = "DAP Clear all breakpoints on exceptions" },
  },
  {
    "n",
    "<leader>ik",
    ':lua require"dap".step_out()<CR>',
    { desc = "DAP Step Out" },
  },
  {
    "n",
    "<leader>ij",
    ':lua require"dap".step_into()<CR>',
    { desc = "DAP Step Into" },
  },
  {
    "n",
    "<leader>il",
    ':lua require"dap".step_over()<CR>',
    { desc = "DAP Step Over" },
  },
  {
    "n",
    "<leader>ip",
    ':lua require"dap".up()<CR>',
    { desc = "DAP Go up in current stacktrace without stepping" },
  },
  {
    "n",
    "<leader>in",
    ':lua require"dap".down()<CR>',
    { desc = "DAP Go down in current stacktrace without stepping" },
  },
  {
    "n",
    "<leader>ic",
    ':lua require"dap".disconnect();require"dap".close();require"dapui".close()<CR>',
    { desc = "DAP Disconnect and close nvim-dap and dap-ui. Doesn't kill the debugee" },
  },
  {
    "n",
    "<leader>iC",
    ':lua require"dap".terminate();require"dap".close()<CR>',
    { desc = "DAP Terminates the debug session}, also killing the debugee" },
  },
  {
    "n",
    "<F12>",
    ':lua require"dap.ui.widgets".hover()<CR>',
    { desc = "DAP Hover info for variables" },
  },
  {
    "n",
    "<leader>i?",
    ':lua local widgets = require"dap.ui.widgets";widgets.centered_float(widgets.scopes)<CR>',
    { desc = "DAP Show scopes in sidebar" },
  },
  {
    "n",
    "<leader>ir",
    ':lua require"dap".repl.open({}, "vsplit")<CR><C-w>l',
    { desc = "DAP Opens repl in vsplit" },
  },
}

local install_dir = vim.fn.stdpath("data") .. "/mason"

--- Creates a set of keymaps for lazy.nvim plugin configuration
---@param mappings table List of mapping configurations compatible with vim.api.nvim_set_keymap()
---@param perform_bind [opt=false] perform_bind boolean True if the bindings should not be made by lazy.nvim
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

function setup_debug_configs()
  local dap_ok, dap = pcall(require, "dap")
  local config = require("custom.dap.dap_configs")

  if dap_ok then
    for language, dap_settings in pairs(config) do
      dap.configurations[language] = dap_settings
    end
  end
end

return {
  {
    {
      "mfussenegger/nvim-dap",
      keys = make_lazy_keymaps(dap_keys, true),
      dependencies = {
        "mason.nvim",
        "jbyuki/one-small-step-for-vimkind",
        "rcarriga/nvim-dap-ui",
      },
      config = function()
        local dap = require("dap")

        -- Settings
        dap.defaults.fallback.terminal_win_cmd = "80vsplit new"

        -- dap.set_log_level("TRACE") -- Verbose logging
        vim.fn.sign_define("DapBreakpoint", { text = "👊", texthl = "", linehl = "", numhl = "" })
        vim.fn.sign_define("DapBreakpointRejected", { text = "✋", texthl = "", linehl = "", numhl = "" })
        vim.fn.sign_define("DapStopped", { text = "👉", texthl = "", linehl = "", numhl = "" })

        -- Adapters
        dap.adapters.node2 = {
          type = "executable",
          name = "node-debug",
          command = "node",
          args = { install_dir .. "/packages/node-debug2-adapter/out/src/nodeDebug.js" },
        }

        dap.adapters.chrome = {
          type = "executable",
          command = "node",
          args = { install_dir .. "/packages/chrome-debug-adapter/out/src/chromeDebug.js" },
        }

        dap.adapters["pwa-node"] = {
          type = "server",
          host = "localhost",
          port = "${port}",
          executable = {
            command = "node",
            -- 💀 Make sure to update this path to point to your installation
            args = { install_dir .. "/packages/js-debug-adapter/js-debug/src/dapDebugServer.js", "${port}" },
          },
        }

        local netcoredbg_install_dir

        if vim.fn.has("win32") == 1 then
          netcoredbg_install_dir = install_dir .. "/packages/netcoredbg/netcoredbg/netcoredbg.exe"
        else
          netcoredbg_install_dir = install_dir .. "/packages/netcoredbg/netcoredbg"
        end

        dap.adapters.netcoredbg = {
          type = "executable",
          command = netcoredbg_install_dir,
          args = { "--interpreter=vscode" },
        }

        dap.adapters.bashdb = {
          type = "executable",
          command = "node",
          args = { install_dir .. "/packages/bash-debug-adapter/extension/out/bashDebug.js" },
        }

        dap.adapters.nlua = function(callback, config)
          callback({ type = "server", host = config.host or "127.0.0.1", port = config.port or 8086 })
        end

        setup_debug_configs()
      end,
    },
    {
      "mfussenegger/nvim-dap-python",
      ft = { "python" },
      config = function(_, opts)
        local path = install_dir .. "/packages/debugpy/venv/bin/python"
        require("dap-python").setup(path)
      end,
    },
  },
}
