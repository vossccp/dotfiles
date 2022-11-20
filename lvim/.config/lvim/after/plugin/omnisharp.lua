local status_ok, omnisharp = pcall(require, "omnisharp")
if not status_ok then
  return
end

local capabilities = require("lvim.lsp").common_capabilities()
local mason_path = vim.fn.glob(vim.fn.stdpath "data" .. "/mason/")

omnisharp.setup {
  cmd = mason_path .. "/bin/omnisharp",
  on_attach = require("lvim.lsp").common_on_attach,
  on_init = require("lvim.lsp").common_on_init,
  capabilities = capabilities,
  settings = {
    ["omnisharp.loggingLevel"] = "debug",
    ["omnisharp.organizeImportsOnFormat"] = true,
    ["omnisharp.useModernNet"] = true,
    ["omnisharp.enableEditorConfigSupport"] = true,
    ["omnisharp.enableRoslynAnalyzers"] = true,
  }
}

-- lvim.builtin.dap.on_config_done = function(dap)
--   local mason_path = vim.fn.glob(vim.fn.stdpath "data" .. "/mason/")
--   dap.adapters.netcoredbg = {
--     type = "executable",
--     command = mason_path .. "bin/netcoredbg",
--     args = { '--interpreter=vscode' }
--   }

--   dap.configurations.cs = {
--     {
--       type = "netcoredbg",
--       name = "launch - netcoredbg",
--       request = "launch",
--       program = function()
--         return vim.fn.input('Path to dll: ', vim.fn.getcwd() .. '/bin/Debug/', 'file')
--       end,
--     },
--   }

--   dap.configurations.fs = dap.configurations.cs

-- end
