lvim.plugins = {
  "lunarvim/darkplus.nvim",
  "jose-elias-alvarez/typescript.nvim",
  "lervag/vimtex",
  {
    "nvim-neotest/neotest",
    requires = {
      "nvim-lua/plenary.nvim",
      "Issafalcon/neotest-dotnet",
      "haydenmeade/neotest-jest",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim"
    }
  },
  -- plugin doenst work due to build errors
  -- "OmniSharp/omnisharp-vim",
  {
    "windwp/nvim-ts-autotag",
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },
}
