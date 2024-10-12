local wt_action = require("wezterm").action
local M = {}

M.multiple_actions = function(keys)
	local actions = {}
	for key in keys:gmatch(".") do
		table.insert(actions, wt_action.SendKey({ key = key }))
	end
	table.insert(actions, wt_action.SendKey({ key = "\n" }))
	return wt_action.Multiple(actions)
end

M.key_table = function(mods, key, action)
	return {
		mods = mods,
		key = key,
		action = action,
	}
end

M.cmd = function(key, action)
	return M.key_table("CMD", key, action)
end

M.alt = function(key, action)
	return M.key_table("ALT", key, action)
end

M.ctrl = function(key, action)
	return M.key_table("CTRL", key, action)
end

M.ctrlShift = function(key, action)
	return M.key_table("CTRL|SHIFT", key, action)
end

M.tmux = function(key, tmux_key)
	return M.cmd(
		key,
		wt_action.Multiple({
			wt_action.SendKey({ mods = "CTRL", key = "b" }),
			wt_action.SendKey({ key = tmux_key }),
		})
	)
end

return M
