local function config()
	local wezterm = require("wezterm")
	local keys = {
		{
			key = "t",
			mods = "CTRL",
			action = wezterm.action.SpawnTab("DefaultDomain"),
		},
		{
			key = "d",
			mods = "ALT",
			action = wezterm.action.CloseCurrentPane({ confirm = true }),
		},
		{
			key = "\\",
			mods = "ALT",
			action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
		},
		{
			key = "-",
			mods = "ALT",
			action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
		},
		{
			key = "=",
			mods = "ALT",
			action = wezterm.action.DecreaseFontSize,
		},
		{
			key = "+",
			mods = "ALT|SHIFT",
			action = wezterm.action.IncreaseFontSize,
		},
		{
			key = "s",
			mods = "ALT",
			action = wezterm.action.Search("CurrentSelectionOrEmptyString"),
		},
	}

	for i = 1, 8 do
		table.insert(keys, {
			key = tostring(i),
			mods = "ALT",
			action = wezterm.action.ActivateTab(i - 1),
		})
	end

	local directions = { h = "Left", j = "Down", k = "Up", l = "Right" }
	for key, value in pairs(directions) do
		table.insert(keys, {
			key = key,
			mods = "ALT",
			action = wezterm.action.ActivatePaneDirection(value),
		})
	end

	return keys
end

return { config = config }
