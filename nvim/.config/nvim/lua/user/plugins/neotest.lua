return {
  'nvim-neotest/neotest',
  dependencies = {
    'Issafalcon/neotest-dotnet',
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter"
  },
  config = function()
    require('neotest').setup {
      log_level = 1,
      adapters = {
        require('neotest-dotnet')({
          discovery_root = "project"
        })
      }
    }
  end,
}
