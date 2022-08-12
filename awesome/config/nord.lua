local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local theme_path = string.format("%s/.config/awesome", os.getenv("HOME"))

local theme                         = {}
theme.nord_dark_1                   = "#2E3440"
theme.nord_dark_2                   = "#3B4252"
theme.nord_dark_3                   = "#434C5E"
theme.nord_dark_4                   = "#4C566A"
theme.nord_light_1                  = "#D8DEE9"
theme.nord_light_2                  = "#E5E9F0"
theme.nord_light_3                  = "#ECEFF4"
theme.nord_blue_green               = "#8FBCBB"
theme.nord_teal                     = "#88C0D0"
theme.nord_light_blue               = "#81A1C1"
theme.nord_dark_blue                = "#5E81AC"
theme.nord_red                      = "#BF616A"
theme.nord_orange                   = "#D08770"
theme.nord_yellow                   = "#EBCB8B"
theme.nord_green                    = "#A3BE8C"
theme.nord_purple                   = "#B48EAD"

theme.font                          = "Ubuntu Bold 11"

theme.bg_normal                     = theme.nord_dark_1
theme.bg_focus                      = theme.nord_teal
theme.bg_urgent                     = theme.nord_dark_1
theme.bg_minimize                   = theme.nord_dark_1
theme.bg_systray                    = theme.bg_normal

theme.fg_normal                     = theme.nord_light_blue
theme.fg_focus                      = theme.nord_dark_1
theme.fg_urgent                     = theme.nord_yellow
theme.fg_minimize                   = theme.fg_normal

theme.useless_gap                   = dpi(5)
theme.border_width                  = dpi(1)
theme.border_normal                 = theme.nord_dark_2
theme.border_focus                  = theme.nord_teal
theme.border_marked                 = theme.nord_dark_2

theme.tasklist_bg_normal            = theme.bg_normal
theme.tasklist_bg_focus             = theme.bg_normal
theme.tasklist_fg_normal            = theme.fg_normal
theme.tasklist_fg_focus             = theme.fg_normal

theme.taglist_bg_normal             = theme.bg_normal
theme.taglist_bg_focus              = theme.bg_focus
theme.taglist_fg_occupied           = theme.nord_teal

theme.hotkeys_font                  = "Ubuntu"
theme.hotkeys_fg                    = theme.nord_dark_blue
theme.hotkeys_modifiers_fg          = theme.nord_light_blue

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- taglist_[bg|fg]_[focus|urgent|occupied|empty|volatile]
-- tasklist_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
-- prompt_[fg|bg|fg_cursor|bg_cursor|font]
-- hotkeys_[bg|fg|border_width|border_color|shape|opacity|modifiers_fg|label_bg|label_fg|group_margin|font|description_font]
-- Example:
--theme.taglist_bg_focus = "#ff0000"

-- Variables set for theming notifications:
-- notification_font
-- notification_[bg|fg]
-- notification_[width|height|margin]
-- notification_[border_color|border_width|shape|opacity]

-- Icons
theme.tux_icon      = theme_path .. "/icons/tux.png"

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = ""
theme.menu_height = dpi(15)
theme.menu_width  = dpi(100)

theme.wallpaper = theme_path .. "/wallpaper.jpg"

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = nil

return theme
