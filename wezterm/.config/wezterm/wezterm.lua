local wezterm = require("wezterm")
local k = require("utils/keys")
local act = wezterm.action

local config = {
	font = wezterm.font("JetBrains Mono"),
	color_scheme = "Catppuccin Mocha",
	font_size = 16.0,
	window_padding = {
		left = 8,
		right = 8,
		top = 8,
		bottom = 8,
	},
	adjust_window_size_when_changing_font_size = false,
	debug_key_events = false,
	enable_tab_bar = false,
	native_macos_fullscreen_mode = false,
	window_close_confirmation = "NeverPrompt",
	window_decorations = "RESIZE",
	keys = {
		k.cmd("e", act.SendKey({ mods = "CTRL", key = "e" })),
		k.cmd("o", act.SendKey({ mods = "CTRL", key = "p" })),
		k.cmd("w", act.SendKey({ mods = "CTRL", key = "h" })),
		k.cmd("p", act.SendKey({ mods = "CTRL", key = "p" })),
		k.tmux("1", "1"),
		k.tmux("2", "2"),
		k.tmux("3", "3"),
		k.tmux("4", "4"),
		k.tmux("5", "5"),
		k.tmux("6", "6"),
		k.tmux("7", "7"),
		k.tmux("8", "8"),
		k.tmux("9", "9"),
	},
}

return config
