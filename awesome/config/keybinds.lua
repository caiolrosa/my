local awful             = require('awful')
require('awful.autofocus')

local beautiful         = require("beautiful").get()
local hotkeys_popup     = require("awful.hotkeys_popup").widget

local terminal          = "alacritty"
local modkey            = "Mod1"
local mod               = { modkey }
local mod_control       = { modkey, "Control" }
local mod_shift         = { modkey, "Shift" }

local describe = function(description, group)
  return { description = description, group = group }
end

local keybinds = {}
keybinds.globalkeys = awful.util.table.join(
    -- Show help
    awful.key(mod,         "s", hotkeys_popup.show_help, describe("show help", "awesome")),

    -- Manipulate client
    awful.key(mod,         "j", function () awful.client.focus.byidx( 1) end, describe("focus next by index", "client")),
    awful.key(mod,         "k", function () awful.client.focus.byidx(-1) end, describe("focus previous by index", "client")),

    -- Standard program
    awful.key(mod,         "Return", function () awful.spawn(terminal) end, describe("open a terminal", "launcher")),
    awful.key(mod_control, "r", awesome.restart, describe("reload awesome", "awesome")),
    awful.key(mod_shift,   "q", awesome.quit, describe("quit awesome", "awesome")),

    -- Layout manipulation
    awful.key(mod_shift,   "j", function () awful.client.swap.byidx(  1) end, describe("swap with next client by index", "client")),
    awful.key(mod_shift,   "k", function () awful.client.swap.byidx( -1) end, describe("swap with previous client by index", "client")),
    awful.key(mod_control, "j", function () awful.screen.focus_relative( 1) end, describe("focus the next screen", "screen")),
    awful.key(mod_control, "k", function () awful.screen.focus_relative(-1) end, describe("focus the previous screen", "screen")),
    awful.key(mod,         "u", awful.client.urgent.jumpto, describe("jump to urgent client", "client")),
    awful.key(mod,         "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        describe("go back", "client")
    ),

    awful.key(mod,         "l", function() awful.tag.incmwfact( 0.05) end, describe("increase master width factor", "layout")),
    awful.key(mod,         "h", function() awful.tag.incmwfact(-0.05) end, describe("decrease master width factor", "layout")),
    awful.key(mod_shift,   "h", function() awful.tag.incnmaster( 1, nil, true) end, describe("increase the number of master clients", "layout")),
    awful.key(mod_shift,   "l", function() awful.tag.incnmaster(-1, nil, true) end, describe("decrease the number of master clients", "layout")),
    awful.key(mod_control, "h", function() awful.tag.incncol( 1, nil, true) end, describe("increase the number of columns", "layout")),
    awful.key(mod_control, "l", function() awful.tag.incncol(-1, nil, true) end, describe("decrease the number of columns", "layout")),
    awful.key(mod,         "space", function() awful.layout.inc(1) end, describe("select next", "layout")),
    awful.key(mod_shift,   "space", function() awful.layout.inc(-1) end, describe("select previous", "layout")),

    -- Prompt
    awful.key(mod,         "space", function() awful.spawn.with_shell("rofi -show-icons -show drun") end, describe("run prompt", "launcher")),
    awful.key(mod_shift,   "space", function() awful.spawn.with_shell("rofi -show run") end, describe("run command", "launcher")),

    -- Toggle keyboard layout
    awful.key(mod_control, "space",
              function() awful.spawn(string.format("sh %s/.config/awesome/toggle_keyboard_layout.sh", os.getenv("HOME"))) end,
              describe("Toggle keyboard layout", "layout")),

    -- Volume controls
    awful.key(mod,         "v", function() awful.spawn("amixer -q set Master 5%+") end, describe("Increase volume", "Volume")),
    awful.key(mod_shift,   "v", function() awful.spawn("amixer -q set Master 5%-") end, describe("Decrease volume", "Volume")),
    awful.key(mod_shift,   "m", function() awful.spawn("amixer -q set Master toggle") end, describe("Toggle volume", "Volume"))
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    keybinds.globalkeys = awful.util.table.join(keybinds.globalkeys,
        -- View tag only.
        awful.key(mod, "#" .. i + 9,
                  function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[i]
                        if tag then
                           tag:view_only()
                        end
                  end,
                  describe("view tag #" .. i, "tag")),

        -- Move client to tag.
        awful.key(mod_shift, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:move_to_tag(tag)
                          end
                     end
                  end,
                  describe("move focused client to tag #" .. i, "tag"))
    )
end

keybinds.clientkeys = awful.util.table.join(
    awful.key(mod_control, "f",
        function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        describe("toggle fullscreen", "client")
    ),

    awful.key(mod_shift, "c",
              function (c) c:kill() end,
              describe("close", "client")),

    awful.key(mod_shift, "f",  awful.client.floating.toggle,
              describe("toggle floating", "client" )),

    awful.key(mod, "m",
        function (c)
            c.maximized = not c.maximized
            c:raise()
        end,
        describe("(un)maximize", "client"))
)

keybinds.clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", { raise = true })
    end),
    awful.button(mod, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", { raise = true })
        awful.mouse.client.move(c)
    end),
    awful.button(mod, 3, function (c)
        c:emit_signal("request::activate", "mouse_click", { raise = true })
        awful.mouse.client.resize(c)
    end)
)

return keybinds
