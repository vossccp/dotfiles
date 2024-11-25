local wezterm = require("wezterm")
local k = require("utils/keys")
local act = wezterm.action

local config = {
	-- font = wezterm.font("JetbrainsMonoNL Nerd Font", { weight = "Regular" }),
	font = wezterm.font("Berkeley Mono", { weight = "Regular" }),
	color_scheme = "Catppuccin Mocha",

	-- allows ALT + <key> to be send on a mac as additional chars
	send_composed_key_when_left_alt_is_pressed = true,
	font_size = 16.0,
	scrollback_lines = 10000,
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
		k.cmd("w", act.SendKey({ mods = "CTRL", key = "h" })),
		-- k.tmux("1", "1"),
		-- k.tmux("2", "2"),
		-- k.tmux("3", "3"),
		-- k.tmux("4", "4"),
		-- k.tmux("5", "5"),
		-- k.tmux("6", "6"),
		-- k.tmux("7", "7"),
		-- k.tmux("8", "8"),
		-- k.tmux("9", "9"),
	},
}

return config
