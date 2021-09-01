from libqtile import widget

from theme import theme
from custom_widgets import volume

import os

class BatteryFormat():
    def format(*args, **kwargs):
        percent = round(kwargs["percent"] * 100)
        if percent <= 0:
            return "<span font_family='Font Awesome 5 Free'> </span>{}%".format(percent)
        elif percent > 0 and percent < 25:
            return "<span font_family='Font Awesome 5 Free'> </span>{}%".format(percent)
        elif percent >= 25 and percent < 50:
            return "<span font_family='Font Awesome 5 Free'> </span>{}%".format(percent)
        elif percent >= 50 and percent < 100:
            return "<span font_family='Font Awesome 5 Free'> </span>{}%".format(percent)
        else:
            return "<span font_family='Font Awesome 5 Free'> </span>{}%".format(percent)

def main_widgets():
    return [
        widget.Spacer(length = 12),
        widget.Image(
            filename = "~/.config/qtile/arch_icon.png",
            margin_y = 2
        ),
        widget.Spacer(length = 6),
        widget.GroupBox(
            active = theme.colors["accent_green"],
            inactive = theme.colors["darker_blue"],
            block_highlight_text_color = theme.colors["darkest_gray"],
            highlight_color = theme.colors["accent_blue"],
            highlight_method = "block",
            this_current_screen_border = theme.colors["accent_blue"],
            this_current_border = theme.colors["accent_blue"],
            foreground = theme.colors["light_gray"],
            background = theme.colors["darkest_gray"]
        ),
        widget.Sep(
            foreground = theme.colors["dark_gray"],
            linewidth = 2,
            size_percent = 65
        ),
        widget.WindowName(
            foreground = theme.colors["purple"],
            max_chars = 45,
            padding = 12
        ),
        widget.CPU(
            foreground = theme.colors["accent_green"],
            format = "<span font_family='Font Awesome 5 Free'></span> {load_percent}%",
            padding = 3
        ),
        widget.Sep(
            foreground = theme.colors["dark_gray"],
            linewidth = 2,
            padding = 24,
            size_percent = 65
        ),
        widget.Memory(
            foreground = theme.colors["accent_blue"],
            format = "<span font_family='Font Awesome 5 Free'></span> {MemPercent}%",
            padding = 3
        ),
        widget.Sep(
            foreground = theme.colors["dark_gray"],
            linewidth = 2,
            padding = 24,
            size_percent = 65
        ),
        widget.Wlan(
            foreground = theme.colors["darker_blue"],
            interface = "wlo1",
            format = "<span font_family='Font Awesome 5 Free'></span> {percent:2.0%}",
            padding = 3
        ),
        widget.Sep(
            foreground = theme.colors["dark_gray"],
            linewidth = 2,
            padding = 24,
            size_percent = 65
        ),
        volume.Volume(
            foreground = theme.colors["light_green"],
            padding = 3
        ),
        widget.Sep(
            foreground = theme.colors["dark_gray"],
            linewidth = 2,
            padding = 24,
            size_percent = 65
        ),
        widget.Battery(
            foreground = theme.colors["purple"],
            format = BatteryFormat(),
            padding = 3
        ),
        widget.Sep(
            foreground = theme.colors["dark_gray"],
            linewidth = 2,
            size_percent = 65,
            padding = 24
        ),
        widget.Clock(
            foreground = theme.colors["orange"],
            format = "<span font_family='Font Awesome 5 Free'></span> %H:%M",
            padding = 3
        ),
        widget.Sep(
            foreground = theme.colors["dark_gray"],
            linewidth = 2,
            size_percent = 65,
            padding = 24
        ),
        widget.Clock(
            foreground = theme.colors["darkest_blue"],
            format = "<span font_family='Font Awesome 5 Free'></span> %a %b %_d",
            padding = 3
        ),
        widget.Sep(
            foreground = theme.colors["dark_gray"],
            linewidth = 2,
            size_percent = 65,
            padding = 24
        ),
        widget.CheckUpdates(
            display_format = " {updates} updates",
            no_update_string = " 0 updates",
            colour_have_updates = theme.colors["yellow"],
            colour_no_updates = theme.colors["darker_blue"],
            update_interval = 1800,
            padding = 3
        ),
        widget.Sep(
            foreground = theme.colors["dark_gray"],
            linewidth = 2,
            size_percent = 65,
            padding = 24
        ),
        widget.TextBox(
            foreground = theme.colors['light_gray'],
            text = "<span font_family='Font Awesome 5 Free'></span> {} {}".format(os.uname().sysname, os.uname().nodename),
            padding = 3
        ),
        widget.Spacer(length = 12)
    ]
