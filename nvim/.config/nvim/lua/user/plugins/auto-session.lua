return {
	"rmagatti/auto-session",
	config = function()
		local autoSession = require("auto-session")
		autoSession.setup({
			auto_session_suppress_dirs = { "~/", "/" },
		})
	end,
}
