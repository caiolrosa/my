local function setup()
	local wezterm = require("wezterm")
	local tabline = wezterm.plugin.require("https://github.com/michaelbrusegard/tabline.wez")
	tabline.setup({
		options = {
			theme = "nord",
			theme_overrides = {
				tab = {
					active = { fg = "#2e3440", bg = "#81a1c1" },
				},
			},
		},
		sections = {
			tabline_a = { " " },
			tabline_b = { "workspace" },
			tabline_y = { " " },
			tabline_z = { " " },
		},
	})
end

return { setup = setup }
