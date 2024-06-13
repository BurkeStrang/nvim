-- vim.fn.setenv("NEOVIM_POWERSHELL", "1")

return {
  "sbdchd/neoformat",
  --config = function()
  -- Specify CSharpier as the custom formatter for C#
  --vim.g.neoformat_csharp_csharpier = {
  --exe = "cmd.exe",
  --args = { "/c", "dotnet-csharpier", "--write-stdout", vim.fn.expand("%:p") },
  --stdin = 1,
  --no_append = 1,
  --}

  -- Enable the formatter for C# files
  --vim.g.neoformat_enabled_cs = { "csharpier" }

  -- Automatically format on save
  --vim.cmd([[autocmd BufWritePre *.cs undojoin | Neoformat]])

  -- Remove unwanted PowerShell profile text after formatting
  --end,
}
--HACK: this is really just for CSharp I can't get it to work with the defualt lazyvim setup
--TODO: need to figure out how to get this to work in both windows an wsl
--NOTE: when running in wsl with powershell the powershell profile adds unessessary header
