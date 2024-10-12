return {
  "rmagatti/auto-session",
  config = function()
    local autoSession = require("auto-session")
    autoSession.setup({
      suppressed_dirs = { "~/", "/" },
    })
  end,
}
