local function get_tab_title(default_title, tab_info)
	if tab_info.tab_title and #tab_info.tab_title > 0 then
		return tab_info.tab_title
	end

	return default_title
end

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
			tab_active = {
				"index",
				{
					"process",
					fmt = function(str, tab_info)
						return get_tab_title(str, tab_info)
					end,
				},
			},
			tab_inactive = {
				"index",
				{
					"process",
					fmt = function(str, tab_info)
						print(str)
						return get_tab_title(str, tab_info)
					end,
				},
			},
		},
	})
end

return { setup = setup }
