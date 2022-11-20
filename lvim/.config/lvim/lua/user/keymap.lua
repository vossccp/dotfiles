-- Tab moves between buffers
lvim.keys.normal_mode["<TAB>"] = ":BufferLineCycleNext<CR>"
lvim.keys.normal_mode["<S-TAB>"] = ":BufferLineCyclePrev<CR>"

lvim.keys.insert_mode["<A-ENTER>"] = "<ESC>A"
