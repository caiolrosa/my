local wezterm = require("wezterm")
local config = wezterm.config_builder()

require("plugins").setup()

config.font_size = 15
config.font = wezterm.font("SauceCodePro Nerd Font")

config.color_scheme = "nord"

config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
config.show_new_tab_button_in_tab_bar = false
config.tab_max_width = 32

config.colors = config.colors or {}
config.colors.tab_bar = config.colors.tab_bar or {}
config.colors.tab_bar.background = require("tabline.config").theme.normal_mode.c.bg

config.window_padding = config.window_padding or {}
config.window_padding.left = 0
config.window_padding.right = 0
config.window_padding.top = 0
config.window_padding.bottom = 0

config.status_update_interval = 500

config.enable_scroll_bar = true
config.scrollback_lines = 10000

config.keys = require("keybinds").config()

return config
