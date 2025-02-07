return {
  "seblyng/roslyn.nvim",
  ft = "cs",
  opts = {
    exe = {
      vim.fs.joinpath(vim.fn.stdpath("data"), "mason", "bin", "roslyn"),
    },
  },
}
