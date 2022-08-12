-- Standard awesome library
local gears         = require("gears")
local awful         = require("awful")
local wibox         = require("wibox")
local beautiful     = require("beautiful")
local dpi           = require("beautiful.xresources").apply_dpi
local lain          = require("lain")

-- Error handling
require("config.errors")

local themes = {
    nord = string.format("%s/.config/awesome/config/nord.lua", os.getenv("HOME"))
}
beautiful.init(themes.nord)

local config = require('config')

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
    awful.layout.suit.fair,
    -- awful.layout.suit.tile.left,
    -- awful.layout.suit.floating,
    -- awful.layout.suit.max,
    -- awful.layout.suit.tile.left,
    -- awful.layout.suit.tile.bottom,
    -- awful.layout.suit.tile.top,
    -- awful.layout.suit.fair.horizontal,
    -- awful.layout.suit.spiral,
    -- awful.layout.suit.spiral.dwindle,
    -- awful.layout.suit.max.fullscreen,
    -- awful.layout.suit.magnifier,
    -- awful.layout.suit.corner.nw,
    -- awful.layout.suit.corner.ne,
    -- awful.layout.suit.corner.sw,
    -- awful.layout.suit.corner.se,
}

local function set_wallpaper(s)
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
    set_wallpaper(s)

    awful.tag({ "web", "terminal", "chat", "music", "misc" }, s, awful.layout.layouts[1])
    s.mytaglist = config.widgets.tag_list(s)
    s.mytasklist = config.widgets.task_list(s)
    s.mywibox = awful.wibar({ position = "top", screen = s, height = dpi(25) })

    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
	    config.widgets.tux_icon,
            s.mytaglist,
	    config.widgets.separator(beautiful.nord_dark_4, 10, 10),
        },
        s.mytasklist, -- Middle widget
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,

	    config.widgets.keyboard_layout(beautiful.nord_dark_blue),

	    config.widgets.separator(beautiful.nord_dark_4, 5, 10),

	    config.widgets.fa_icon(beautiful.nord_dark_blue, "\u{f233}", 0, 5),
	    config.widgets.cpu(beautiful.nord_dark_blue),

	    config.widgets.separator(beautiful.nord_dark_4, 10, 10),

	    config.widgets.fa_icon(beautiful.nord_light_blue, "\u{f1c0}", 0, 5),
	    config.widgets.memory(beautiful.nord_light_blue),

	    config.widgets.separator(beautiful.nord_dark_4, 10, 10),

	    config.widgets.wifi_icon(0, 5),
	    config.widgets.wifi(beautiful.nord_teal, "wlo1", "\u{faa9}", "\u{faa8}", 10, 5),

	    config.widgets.separator(beautiful.nord_dark_4, 10, 10),

	    config.widgets.battery_icon(0, 5),
	    config.widgets.battery(beautiful.nord_blue_green, "\u{f244}", "\u{f242}", "\u{f240}").widget,

	    config.widgets.separator(beautiful.nord_dark_4, 10, 10),

	    config.widgets.sound_icon(0, 5),
	    config.widgets.sound(beautiful.nord_blue_green, "\u{f026}", "\u{f027}", "\u{f028}"),

	    config.widgets.separator(beautiful.nord_dark_4, 10, 10),

	    config.widgets.fa_icon(beautiful.nord_teal, "\u{f073}", 0, 5),
	    config.widgets.date(beautiful.nord_teal),

	    config.widgets.separator(beautiful.nord_dark_4, 10, 10),

	    config.widgets.fa_icon(beautiful.nord_light_blue, "\u{f017}", 0, 5),
	    config.widgets.clock(beautiful.nord_light_blue),

	    config.widgets.separator(beautiful.nord_dark_4, 10, 10),

	    config.widgets.updates_icon(0, 5),
	    config.widgets.updates(beautiful.nord_dark_blue, beautiful.nord_yellow, "\u{f013}"),

	    config.widgets.separator(beautiful.nord_dark_4, 10, 10),

	    config.widgets.fa_icon(beautiful.nord_light_3, "\u{f120}", 0, 5),
	    config.widgets.username(beautiful.nord_light_3, 0, 15),
        },
    }
end)
-- }}}

-- Set keys
root.keys(config.keybinds.globalkeys)

-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     raise = true,
                     keys = config.keybinds.clientkeys,
                     buttons = config.keybinds.clientbuttons,
                     screen = awful.screen.preferred,
                     placement = awful.placement.no_overlap+awful.placement.no_offscreen,
		     floating = false
     }
    },

    -- Floating clients.
    -- { rule_any = {
    --     instance = {
    --       "DTA",  -- Firefox addon DownThemAll.
    --       "copyq",  -- Includes session name in class.
    --       "pinentry",
    --     },
    --     class = {
    --       "Arandr",
    --       "Blueman-manager",
    --       "Gpick",
    --       "Kruler",
    --       "MessageWin",  -- kalarm.
    --       "Sxiv",
    --       "Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
    --       "Wpa_gui",
    --       "veromix",
    --       "xtightvncviewer"},

    --     -- Note that the name property shown in xprop might be set slightly after creation of the client
    --     -- and the name shown there might not match defined rules here.
    --     name = {
    --       "Event Tester",  -- xev.
    --     },
    --     role = {
    --       "AlarmWindow",  -- Thunderbird's calendar.
    --       "ConfigManager",  -- Thunderbird's about:config.
    --       "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
    --     }
    --   }, properties = { floating = true }},
}

-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup
      and not c.size_hints.user_position
      and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", {raise = false})
end)

-- On Focus handles
client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)

-- Autostart
awful.spawn.with_shell("picom &")
