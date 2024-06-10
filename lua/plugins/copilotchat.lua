return {
  "CopilotC-Nvim/CopilotChat.nvim",
  branch = "canary",
  cmd = "CopilotChat",
  opts = {
    model = "gpt-4",
    auto_insert_mode = true,
    show_help = true,
    window = {
      width = 0.4,
    },
    selection = function(source)
      local select = require("CopilotChat.select")
      return select.visual(source) or select.buffer(source)
    end,
  },
  keys = {
    {
      "<leader>aa",
      function()
        return require("CopilotChat").toggle()
      end,
      desc = "Toggle (CopilotChat)",
      mode = { "n", "v" },
    },
    {
      "<leader>ax",
      function()
        return require("CopilotChat").clear()
      end,
      desc = "Clear (CopilotChat)",
      mode = { "n", "v" },
    },
    {
      "<leader>aq",
      function()
        local input = vim.fn.input("Quick Chat: ")
        if input ~= "" then
          require("CopilotChat").ask(input)
        end
      end,
      desc = "Quick Chat (CopilotChat)",
      mode = { "n", "v" },
    },
  },
  init = function()
    LazyVim.on_load("which-key.nvim", function()
      vim.schedule(function()
        require("which-key").register({ a = { name = "+CopilotChat (AI)" } }, { prefix = "<leader>" })
      end)
    end)
  end,
  config = function(_, opts)
    local chat = require("CopilotChat")
    vim.api.nvim_create_autocmd("BufEnter", {
      pattern = "copilot-chat",
      callback = function()
        vim.opt_local.relativenumber = false
        vim.opt_local.number = false
      end,
    })
    chat.setup(opts)
  end,
}
