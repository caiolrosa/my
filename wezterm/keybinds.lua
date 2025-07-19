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
		{
			key = "LeftArrow",
			mods = "ALT",
			action = wezterm.action.SendKey({ key = "b", mods = "ALT" }),
		},
		{
			key = "RightArrow",
			mods = "ALT",
			action = wezterm.action.SendKey({ key = "f", mods = "ALT" }),
		},
		{
			key = "R",
			mods = "ALT|SHIFT",
			action = wezterm.action.PromptInputLine({
				description = "Enter new name for tab",
				action = wezterm.action_callback(function(window, _, line)
					if line then
						window:active_tab():set_title(line)
					end
				end),
			}),
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
