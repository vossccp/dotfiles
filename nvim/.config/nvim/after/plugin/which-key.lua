local status, which_key = pcall(require, "which-key")
if (not status) then return end

which_key.setup {}

which_key.register({
  r = {
    "Run"
  },
  s = {
    "Search"
  }
}, { prefix = "<leader>" })
