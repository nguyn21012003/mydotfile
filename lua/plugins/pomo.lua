return {
	"epwalsh/pomo.nvim",
	version = "*",
	lazy = true,
	cmd = { "TimerStart", "TimerRepeat", "TimerSession" },
	dependencies = {
		"rcarriga/nvim-notify",
	},
	opts = {
		sessions = {
			pomodoro = {
				{ name = "Work", duration = "50m" },
				{ name = "Short Break", duration = "5m" },
				{ name = "Work", duration = "50m" },
				{ name = "Short Break", duration = "5m" },
				{ name = "Work", duration = "50m" },
				{ name = "Short Break", duration = "5m" },
			},
		},
	},
}
