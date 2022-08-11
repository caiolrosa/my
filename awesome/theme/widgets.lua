local gears         = require("gears")
local awful         = require("awful")
local wibox         = require("wibox")
local beautiful     = require("beautiful").get()
local lain          = require("lain")
local dpi           = require("beautiful.xresources").apply_dpi

local widgets = {}

widgets.tux_icon = wibox.container.margin(wibox.widget.imagebox(beautiful.tux_icon, true), dpi(10), dpi(10))

widgets.tag_list = function(s)
   return awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        buttons = taglist_buttons,
        layout  = {
            spacing = 5,
            layout = wibox.layout.fixed.horizontal
        }
    }
end

widgets.task_list = function(s)
   return awful.widget.tasklist {
        screen = s,
        filter = awful.widget.tasklist.filter.currenttags,
    }
end

function fa_icon_markup(color, unicode)
    return "<span size='xx-large' font_family='Font Awesome 5 Free' foreground='".. color .."'>" .. unicode .. "</span>"
end
widgets.fa_icon = function(color, unicode, margin_left, margin_right)
   return wibox.container.margin(wibox.widget.textbox(fa_icon_markup(color, unicode)), dpi(margin_left), dpi(margin_right))
end

widgets.separator = function(color, margin_left, margin_right)
    local sep = wibox.widget {
	{ widget = wibox.widget.textbox("|") },
	widget = wibox.container.background(),
        fg = color
    }

    return wibox.container.margin(sep, dpi(margin_left), dpi(margin_right))
end

widgets.keyboard_layout = function(color)
    return wibox.widget {
	{ widget = awful.widget.keyboardlayout() },
	widget = wibox.container.background(),
	fg = color
    }
end

widgets.cpu = function(color)
    return lain.widget.cpu {
        settings = function()
            widget:set_markup(
	        string.format("<span foreground='%s'>%d%%</span>", color, cpu_now.usage)
	    )
        end
    }
end

widgets.memory = function(color)
    return lain.widget.mem {
        settings = function()
            widget:set_markup(
                string.format("<span foreground='%s'>%d%%</span>", color, mem_now.perc)
            )
        end
    }
end

local wifi_icon_text = wibox.widget.textbox()
widgets.wifi_icon = function(margin_left, margin_right)
    return wibox.container.margin(wifi_icon_text, dpi(margin_left), dpi(margin_right))
end
widgets.wifi = function(color, no_connection_unicode, connected_unicode, icon_margin_left, icon_margin_right)
    return awful.widget.watch(string.format("sh %s/.config/awesome/wifi_signal.sh", os.getenv("HOME")), 30, function(widget, stdout)
	if stdout == "" or stdout == nil then
            widget:set_markup("0%")
	    wifi_icon_text:set_markup(fa_icon_markup(color, no_connection_unicode))
	    return
	end

        local signal = tonumber(stdout)
	if signal == 0 then
            widget:set_markup("0%")
	    wifi_icon_text:set_markup(fa_icon_markup(color, no_connection_unicode))
	else
            widget:set_markup(string.format("%d%%", signal))
	    wifi_icon_text:set_markup(fa_icon_markup(color, connected_unicode))
	end
    end)
end

local battery_icon_text = wibox.widget.textbox()
widgets.battery_icon = function(margin_left, margin_right)
    return wibox.container.margin(battery_icon_text, dpi(margin_left), dpi(margin_right))
end
widgets.battery = function(color, no_battery_unicode, low_battery_unicode, full_battery_unicode)
    return lain.widget.bat({
        settings = function()
            if bat_now.status and bat_now.status ~= "N/A" then
	        widget:set_markup(lain.util.markup.fontfg(beautiful.font, color, bat_now.perc .. "%"))

                if not bat_now.perc and tonumber(bat_now.perc) <= 5 then
    	            battery_icon_text:set_markup(fa_icon_markup(color, no_battery_unicode))
                elseif not bat_now.perc and tonumber(bat_now.perc) <= 15 then
    	            battery_icon_text:set_markup(fa_icon_markup(color, low_battery_unicode))
                else
    	            battery_icon_text:set_markup(fa_icon_markup(color, full_battery_unicode))
                end
            else
	        widget:set_markup(lain.util.markup.fontfg(beautiful.font, color, "100%"))
    	        battery_icon_text:set_markup(fa_icon_markup(color, full_battery_unicode))
            end
        end
    })
end

local sound_icon_text = wibox.widget.textbox()
widgets.sound_icon = function(margin_left, margin_right)
    return wibox.container.margin(sound_icon_text, dpi(margin_left), dpi(margin_right))
end
widgets.sound = function(color, no_sound_unicode, low_sound_unicode, high_sound_unicode)
    return lain.widget.alsa({
	timeout = 0.1,
        settings = function()
	    widget:set_markup(lain.util.markup.fontfg(beautiful.font, color, volume_now.level .. "%"))
	    if volume_now.level == 0 then
	        sound_icon_text:set_markup(fa_icon_markup(color, no_sound_unicode))
            elseif volume_now.level <= 25 and volume_now.level < 50 then
	        sound_icon_text:set_markup(fa_icon_markup(color, low_sound_unicode))
	    elseif volume_now.level >= 50 then
                sound_icon_text:set_markup(fa_icon_markup(color, high_sound_unicode))
	    end
	end
    })
end

widgets.date = function(color)
    return wibox.widget {
        { widget = wibox.widget.textclock("%a %b %d") },
        widget = wibox.container.background(),
        fg = color
    }
end

widgets.clock = function(color)
    return wibox.widget {
        { widget = wibox.widget.textclock("%H:%M") },
        widget = wibox.container.background(),
        fg = color
    }
end

local updates_icon_text = wibox.widget.textbox()
widgets.updates_icon = function(margin_left, margin_right)
    return wibox.container.margin(updates_icon_text, dpi(margin_left), dpi(margin_right))
end
widgets.updates = function(no_updates_color, updates_color, updates_unicode)
    return awful.widget.watch(string.format("sh %s/.config/awesome/check_updates.sh", os.getenv("HOME")), 1800, function(widget, stdout)
        local count = tonumber(stdout)
	if count == 0 then
	    widget:set_markup(lain.util.markup.fontfg(beautiful.font, no_updates_color, count .. " updates"))
	    updates_icon_text:set_markup(fa_icon_markup(no_updates_color, updates_unicode))
	else
	    widget:set_markup(lain.util.markup.fontfg(beautiful.font, updates_color, count .. " updates"))
	    updates_icon_text:set_markup(fa_icon_markup(updates_color, updates_unicode))
	end
    end)
end

widgets.username = function(color, margin_left, margin_right)
    return wibox.container.margin(
        wibox.widget {
            { widget = wibox.widget.textbox(os.getenv("USER")) },
    	widget = wibox.container.background,
    	fg = color
        }, dpi(margin_left), dpi(margin_right)
    )
end

return widgets
