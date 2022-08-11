-- Standard awesome library
local gears         = require("gears")
local awful         = require("awful")
local wibox         = require("wibox")
local beautiful     = require("beautiful")
local naughty       = require("naughty")
local dpi           = require("beautiful.xresources").apply_dpi
local lain          = require("lain")

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = tostring(err) })
        in_error = false
    end)
end
-- }}}

local themes = {
    nord = string.format("%s/.config/awesome/theme/nord.lua", os.getenv("HOME"))
}
beautiful.init(themes.nord)

local theme = require('theme')

local terminal = "alacritty"
local editor = os.getenv("EDITOR") or "nvim"
local editor_cmd = terminal .. " -e " .. editor

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
    awful.layout.suit.tile.left
    -- awful.layout.suit.floating,
    -- awful.layout.suit.tile.left,
    -- awful.layout.suit.tile.bottom,
    -- awful.layout.suit.tile.top,
    -- awful.layout.suit.fair,
    -- awful.layout.suit.fair.horizontal,
    -- awful.layout.suit.spiral,
    -- awful.layout.suit.spiral.dwindle,
    -- awful.layout.suit.max,
    -- awful.layout.suit.max.fullscreen,
    -- awful.layout.suit.magnifier,
    -- awful.layout.suit.corner.nw,
    -- awful.layout.suit.corner.ne,
    -- awful.layout.suit.corner.sw,
    -- awful.layout.suit.corner.se,
}
-- }}}

-- {{{ Wibar
local function set_wallpaper(s)
    -- Wallpaper
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
    s.mytaglist = theme.widgets.tag_list(s)
    s.mytasklist = theme.widgets.task_list(s)
    s.mywibox = awful.wibar({ position = "top", screen = s, height = dpi(25) })

    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
	    theme.widgets.tux_icon,
            s.mytaglist,
	    theme.widgets.separator(beautiful.nord_dark_4, 10, 10),
        },
        s.mytasklist, -- Middle widget
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,

	    theme.widgets.keyboard_layout(beautiful.nord_dark_blue),

	    theme.widgets.separator(beautiful.nord_dark_4, 5, 10),

	    theme.widgets.fa_icon(beautiful.nord_dark_blue, "\u{f233}", 0, 5),
	    theme.widgets.cpu(beautiful.nord_dark_blue),

	    theme.widgets.separator(beautiful.nord_dark_4, 10, 10),

	    theme.widgets.fa_icon(beautiful.nord_light_blue, "\u{f1c0}", 0, 5),
	    theme.widgets.memory(beautiful.nord_light_blue),

	    theme.widgets.separator(beautiful.nord_dark_4, 10, 10),

	    theme.widgets.wifi_icon(0, 5),
	    theme.widgets.wifi(beautiful.nord_teal, "wlo1", "\u{faa9}", "\u{faa8}", 10, 5),

	    theme.widgets.separator(beautiful.nord_dark_4, 10, 10),

	    theme.widgets.battery_icon(0, 5),
	    theme.widgets.battery(beautiful.nord_blue_green, "\u{f244}", "\u{f242}", "\u{f240}").widget,

	    theme.widgets.separator(beautiful.nord_dark_4, 10, 10),

	    theme.widgets.sound_icon(0, 5),
	    theme.widgets.sound(beautiful.nord_blue_green, "\u{f026}", "\u{f027}", "\u{f028}"),

	    theme.widgets.separator(beautiful.nord_dark_4, 10, 10),

	    theme.widgets.fa_icon(beautiful.nord_teal, "\u{f073}", 0, 5),
	    theme.widgets.date(beautiful.nord_teal),

	    theme.widgets.separator(beautiful.nord_dark_4, 10, 10),

	    theme.widgets.fa_icon(beautiful.nord_light_blue, "\u{f017}", 0, 5),
	    theme.widgets.clock(beautiful.nord_light_blue),

	    theme.widgets.separator(beautiful.nord_dark_4, 10, 10),

	    theme.widgets.updates_icon(0, 5),
	    theme.widgets.updates(beautiful.nord_dark_blue, beautiful.nord_yellow, "\u{f013}"),

	    theme.widgets.separator(beautiful.nord_dark_4, 10, 10),

	    theme.widgets.fa_icon(beautiful.nord_light_3, "\u{f120}", 0, 5),
	    theme.widgets.username(beautiful.nord_light_3, 0, 15),
        },
    }
end)
-- }}}

-- Set keys
root.keys(theme.keybinds.globalkeys)

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     raise = true,
                     keys = theme.keybinds.clientkeys,
                     buttons = theme.keybinds.clientbuttons,
                     screen = awful.screen.preferred,
                     placement = awful.placement.no_overlap+awful.placement.no_offscreen,
		     floating = false
     }
    },

    -- Floating clients.
    { rule_any = {
        instance = {
          "DTA",  -- Firefox addon DownThemAll.
          "copyq",  -- Includes session name in class.
          "pinentry",
        },
        class = {
          "Arandr",
          "Blueman-manager",
          "Gpick",
          "Kruler",
          "MessageWin",  -- kalarm.
          "Sxiv",
          "Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
          "Wpa_gui",
          "veromix",
          "xtightvncviewer"},

        -- Note that the name property shown in xprop might be set slightly after creation of the client
        -- and the name shown there might not match defined rules here.
        name = {
          "Event Tester",  -- xev.
        },
        role = {
          "AlarmWindow",  -- Thunderbird's calendar.
          "ConfigManager",  -- Thunderbird's about:config.
          "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
        }
      }, properties = { floating = true }},

    -- Add titlebars to normal clients and dialogs
    { rule_any = {type = { "normal", "dialog" }
      }, properties = { titlebars_enabled = false }
    },
}
-- }}}

-- {{{ Signals
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

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
    -- buttons for the titlebar
    local buttons = gears.table.join(
        awful.button({ }, 1, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.move(c)
        end),
        awful.button({ }, 3, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.resize(c)
        end)
    )

    awful.titlebar(c) : setup {
        { -- Left
            awful.titlebar.widget.iconwidget(c),
            buttons = buttons,
            layout  = wibox.layout.fixed.horizontal
        },
        { -- Middle
            { -- Title
                align  = "center",
                widget = awful.titlebar.widget.titlewidget(c)
            },
            buttons = buttons,
            layout  = wibox.layout.flex.horizontal
        },
        { -- Right
            awful.titlebar.widget.floatingbutton (c),
            awful.titlebar.widget.maximizedbutton(c),
            awful.titlebar.widget.stickybutton   (c),
            awful.titlebar.widget.ontopbutton    (c),
            awful.titlebar.widget.closebutton    (c),
            layout = wibox.layout.fixed.horizontal()
        },
        layout = wibox.layout.align.horizontal
    }
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", {raise = false})
end)

-- Autostart
awful.spawn.with_shell("picom &")

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}

