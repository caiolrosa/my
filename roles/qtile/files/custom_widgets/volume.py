import re
import subprocess

from libqtile import bar
from libqtile.widget import base

__all__ = [
    'Volume',
]

re_vol = re.compile(r'\[(\d?\d?\d?)%\]')


class Volume(base._TextBox):
    """Widget that display and change volume

    By default, this widget uses ``amixer`` to get and set the volume so users
    will need to make sure this is installed. Alternatively, users may set the
    relevant parameters for the widget to use a different application.

    If theme_path is set it draw widget as icons.
    """
    orientations = base.ORIENTATION_HORIZONTAL
    defaults = [
        ("cardid", None, "Card Id"),
        ("device", "default", "Device Name"),
        ("channel", "Master", "Channel"),
        ("padding", 3, "Padding left and right. Calculated if None."),
        ("update_interval", 0.2, "Update time in seconds."),
    ]

    def __init__(self, **config):
        base._TextBox.__init__(self, '0', width=bar.CALCULATED, **config)
        self.add_defaults(Volume.defaults)
        self.surfaces = {}
        self.volume = None

    def timer_setup(self):
        self.timeout_add(self.update_interval, self.update)

    def create_amixer_command(self, *args):
        cmd = ['amixer']

        if (self.cardid is not None):
            cmd.extend(['-c', str(self.cardid)])

        if (self.device is not None):
            cmd.extend(['-D', str(self.device)])

        cmd.extend([x for x in args])
        return cmd

    def update(self):
        vol = self.get_volume()
        if vol != self.volume:
            self.volume = vol
            # Update the underlying canvas size before actually attempting
            # to figure out how big it is and draw it.
            self._update_drawer()
            self.bar.draw()
        self.timeout_add(self.update_interval, self.update)

    def _update_drawer(self):
        volume_icon = ''

        if self.volume <= 0:
            volume_icon = ""
        elif self.volume <= 25:
            volume_icon = ""
        elif self.volume < 50:
            volume_icon = ""
        elif self.volume >= 50:
            volume_icon = ""

        self.text = '{} {}%'.format(volume_icon, self.volume)

    def get_volume(self):
        try:
            get_volume_cmd = self.create_amixer_command('sget',
                                                        self.channel)

            mixer_out = self.call_process(get_volume_cmd)
        except subprocess.CalledProcessError:
            return -1

        if '[off]' in mixer_out:
            return -1

        volgroups = re_vol.search(mixer_out)
        if volgroups:
            return int(volgroups.groups()[0])
        else:
            # this shouldn't happen
            return -1

    def draw(self):
        base._TextBox.draw(self)
