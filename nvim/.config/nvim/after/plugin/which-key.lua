local which_key = require("which-key")

which_key.setup {}

which_key.register({
  r = {
    "Run"
  },
  s = {
    "Search"
  }
}, { prefix = "<leader>" })
