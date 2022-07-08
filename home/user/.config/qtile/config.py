"""Mahancoder's Qtile config"""
# Original author: https://github.com/mahancoder
# Copyright (c) 2010 Aldo Cortesi
# Copyright (c) 2010, 2014 dequis
# Copyright (c) 2012 Randall Ma
# Copyright (c) 2012-2014 Tycho Andersen
# Copyright (c) 2012 Craig Barnes
# Copyright (c) 2013 horsik
# Copyright (c) 2013 Tao Sauvage
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following cojditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

import os

from typing import List  # noqa: F401
import subprocess

from libqtile import bar, layout, widget, hook
from libqtile.layout.floating import Floating
import libqtile.core.manager
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal
import fontawesome as fa
# import qtile_extras.widget.statusnotifier

mod = "mod4"
terminal = guess_terminal()

browser = str(
    subprocess.run(
        ["xdg-mime", "query", "default", "x-scheme-handler/http"],
        stdout=subprocess.PIPE,
        check=False,
    ).stdout
)[2:-3]

gpu_is_nvidia = (
    "nvidia"
    in str(subprocess.run(
        ["lshw", "-c", "video"],
        stdout=subprocess.PIPE,
        check=False,
    ).stdout).lower()
)


@hook.subscribe.startup_once
def startup_handler():
    """Startup handler."""
    subprocess.call([os.path.expanduser("~/.config/qtile/autostart.sh")])

def kbd(qtile_obj):
    """Keyboard layout."""
    qtile_obj.widgets_map["keyboardlayout"].next_keyboard()
    qtile_obj.cmd_spawn("setxkbmap -option caps:super")

# def open_power():
    # """Open Dmenu Power"""
    # qtile.cmd_spawn(
        # "dmenu_power -h 20 -p \">>\" -nb \"#003b60\" -nf \"#ffe585\" -sb \"#ffe585\" -sf \"#017d7a\" -x 6 -y 5 -z 1588")


touchpad_on = False


@lazy.function
def toggle_touchpad(_qtile):
    """Toggle touchpad"""
    global touchpad_on
    if touchpad_on:
        subprocess.run(["screenpad_off"], check=False)
        touchpad_on = False
    else:
        subprocess.run(["screenpad_on"], check=False)
        touchpad_on = True

@lazy.function
def to_next_screen(_qtile, move_focus: bool = True):
    """Send window to next screen"""
    window = _qtile.current_window
    _qtile.cmd_next_screen()
    group = _qtile.current_group
    _qtile.cmd_prev_screen()
    window.cmd_togroup(group.name, switch_group=False)
    if move_focus:
        _qtile.cmd_next_screen()

@lazy.function
def to_previous_screen(_qtile, move_focus: bool = True):
    """Send window to previous screen"""
    window = _qtile.current_window
    _qtile.cmd_prev_screen()
    group = _qtile.current_group
    _qtile.cmd_next_screen()
    window.cmd_togroup(group.name, switch_group=False)
    if move_focus:
        _qtile.cmd_prev_screen()

@lazy.function
def open_dmenu_power(_qtile: libqtile.core.manager.Qtile):
    """Open Dmenu Power"""
    _qtile.cmd_spawn(
        "dmenu_power -h 20 -p \">>\" -nb \"#003b60\" -nf \"#ffe585\" " +
        "-sb \"#ffe585\" -sf \"#017d7a\" -x 6 -y 5 -z " +
        str(int(_qtile.current_screen.width) - 12))

@lazy.function
def open_dmenu_run(_qtile: libqtile.core.manager.Qtile):
    """Open Dmenu Run"""
    _qtile.cmd_spawn(
        "dmenu_run -h 20 -p \">>\" -nb \"#003b60\" -nf \"#ffe585\" " +
        "-sb \"#ffe585\" -sf \"#017d7a\" -x 6 -y 5 -z " +
        str(int(_qtile.current_screen.width) - 12))

brightness = 255

@lazy.function
def screenpad_brightness_down(_qtile: libqtile.core.manager.Qtile):
    with open(os.path.expanduser("~/.brightness"), "r+") as f:
        brightness = int(f.readline()) - 10
        f.seek(0)
        f.write(str(brightness))
        f.truncate()
    with open("/sys/class/leds/asus::screenpad/brightness", "w") as sysfs_file:
        sysfs_file.write(str(brightness))

@lazy.function
def screenpad_brightness_up(_qtile: libqtile.core.manager.Qtile):
    with open(os.path.expanduser("~/.brightness"), "r+") as f:
        brightness = int(f.readline()) + 10
        f.seek(0)
        f.write(str(brightness))
        f.truncate()
    with open("/sys/class/leds/asus::screenpad/brightness", "w") as sysfs_file:
        sysfs_file.write(str(brightness))

keys = [
    # Switch between windows
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    Key(["mod1"], "Tab", lazy.layout.next(),
        desc="Move window focus to other window"),
    # Shuffle Windows
    Key([mod, "control"], "j", lazy.layout.flip_down()),
    Key([mod, "control"], "k", lazy.layout.flip_up()),
    Key([mod, "control"], "h", lazy.layout.flip_left()),
    Key([mod, "control"], "l", lazy.layout.flip_right()),
    # Move Windows
    Key(
        [mod, "mod1"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"
    ),
    Key(
        [mod, "mod1"],
        "l",
        lazy.layout.shuffle_right(),
        desc="Move window to the right",
    ),
    Key([mod, "mod1"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "mod1"], "k", lazy.layout.shuffle_up(), desc="Move window up"),
    # Resize Windows
    Key([mod, "shift"], "h", lazy.layout.grow_left(),
        desc="Grow window to the left"),
    Key(
        [mod, "shift"], "l", lazy.layout.grow_right(), desc="Grow window to the right"
    ),
    Key([mod, "shift"], "j", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod, "shift"], "k", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
    # Extra
    Key([mod], "period", lazy.next_screen(), desc="Move the focus to the next screen"),
    Key([mod, "shift"], "period", to_next_screen, desc="Move the window to the next screen"),
    Key([mod], "comma", lazy.prev_screen(), desc="Move the focus to the previous screen"),
    Key([mod, "shift"], "comma", to_previous_screen, desc="Move the window to the next screen"),
    Key(
        [mod, "shift"],
        "Return",
        lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack",
    ),
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "w", lazy.window.kill(), desc="Kill focused window"),
    Key([mod, "control"], "r", lazy.restart(), desc="Restart Qtile"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Logout"),
    Key(
        [mod],
        "r",
        open_dmenu_run,
        desc="Open Dmenu",
    ),
    Key([mod], "t", lazy.window.toggle_floating()),
    Key([mod], "b", lazy.spawn(
        f"gtk-launch {browser}"), desc="Opens default browser"),
    Key(
        [mod],
        "space",
        lazy.function(kbd),
        desc="Next keyboard layout.",
    ),
    Key([mod], "Escape", open_dmenu_power, desc="Open power options"),
    Key([mod], "c", lazy.spawn("code"), desc="Open VS Code"),

    # Volume keys
    Key(
        [], "XF86AudioRaiseVolume",
        lazy.spawn("amixer -D pulse sset Master 1%+")
    ),
    Key(
        [], "XF86AudioLowerVolume",
        lazy.spawn("amixer -D pulse sset Master 1%-")
    ),
    Key(
        [], "XF86AudioMute",
        lazy.spawn("amixer -D pulse sset Master toggle")
    ),
    Key(
        [], "XF86AudioPause",
        lazy.spawn("pplayerctl play-pause")
    ),
    Key(
        [], "XF86AudioPlay",
        lazy.spawn("pplayerctl play-pause")
    ),
    Key(
        [], "XF86AudioStop",
        lazy.spawn("pplayerctl stop")
    ),
    Key(
        [], "XF86AudioNext",
        lazy.spawn("pplayerctl next")
    ),
    Key(
        [], "XF86AudioPrev",
        lazy.spawn("pplayerctl previous")
    ),
    Key([mod], "f",
        lazy.window.toggle_fullscreen(),
        desc='Toggle fullscreen'
        ),
    Key([mod], "a",
        lazy.spawn("sh -c \"kill -s USR1 $(pidof deadd-notification-center)\""),
        desc='Open Notification Center'
        ),
    Key([mod, "mod1"], "a", lazy.spawn(
        "notify-send.py a --hint boolean:deadd-notification-center:true string:type:clearInCenter"), desc="Clear notifications"),
    Key([], "Print",
        lazy.spawn("flameshot screen -c"),
        desc='Screenshot'
        ),
    Key(["control"], "Print",
        lazy.spawn("flameshot gui"),
        desc='Screenshot GUI'
        ),
    Key([mod], "q",
        lazy.spawn("loginctl lock-session"),
        desc='Logout'
        ),
    Key([mod], "v",
        lazy.spawn(
            "sh -c \"gtk-launch `xdg-mime query default inode/directory`\""),
        desc='Open File Manager'
        ),
    Key([mod], "s",
        lazy.spawn(
            "skypeforlinux"),
        desc='Open Skype'
        ),
    Key([], "XF86MonBrightnessUp",
        lazy.spawn(
            "xbacklight -inc 10"),
        desc='Increase screen brightness'
        ),
    Key([], "XF86MonBrightnessDown",
        lazy.spawn(
            "xbacklight -dec 10"),
        desc='Decrease screen brightness'
        ),
    Key(["control"], "XF86MonBrightnessUp",
        screenpad_brightness_up,
        desc='Increase screen brightness'
        ),
    Key(["control"], "XF86MonBrightnessDown",
        screenpad_brightness_down,
        desc='Decrease screenpad brightness'
        ),

    Key([mod, "shift"], "s",
        lazy.spawn(
            "flameshot gui"),
        desc='Open Flamshot in GUI mode'
        ),
    Key([], "XF86TouchpadToggle",
        toggle_touchpad,
        desc='Toggle Screenpad'
        ),
    Key([mod], "p", lazy.spawn("arandr"), desc="Open Arandr")
]

group_names = ["", "", "", "", "", "", ""]
groups = [
            Group(group_names[0], spawn=f"gtk-launch {browser}"),
            Group(group_names[1], matches=[Match(wm_class="Code")]),
            Group(group_names[2]),
            Group(group_names[3], matches=[Match(wm_class="discord")]),
            Group(group_names[4]),
            Group(group_names[5]),
            Group(group_names[6]),
        ]

for group, num in zip(groups, [str(n) for n in range(1, len(groups) + 1)]):
    keys.extend(
        [
            # mod + n to switch to group n
            Key(
                [mod],
                num,
                lazy.group[group.name].toscreen(),
                desc=f"Switch to group {group.name}",
            ),
            # mod + n to switch active app to group n
            Key(
                [mod, "shift"],
                num,
                lazy.window.togroup(group.name, switch_group=True),
                desc=f"Switch to & move focused window to group {group.name}",
            ),
        ]
    )

layouts = [
    layout.Columns(
        border_focus_stack="#8be9fd",
        border_width=2,
        grow_amount=5,
        margin=3,
        margin_on_single=3,
        border_focus="#bd93f9",
        border_normal_stack="#44475a",
        border_normal="#6272a4",
        insert_position=1
    ),
    layout.Max(),
    layout.Bsp(fair=False, border_focus="#bd93f9", grow_amount=5, margin=3),
]

widget_defaults = dict(
    font="DroidSansMono Nerd Font",
    fontsize=13,
    padding=2,
    foreground="#FFFFFF"
)
extension_defaults = widget_defaults.copy()

groupbox_settings = dict(
    inactive="b5b5b5",
    active="#f1fa8c",
    disable_drag=True,
    font="Font Awesome 6 Free Solid",
    highlight_method="border",
    borderwidth=0,
    this_current_screen_border="f07178",
    block_highlight_text_color="#ff5555",
    spacing=12.5,
    fontsize=14,
)

#             BG          FG          BG         FG
#          Green-ish    Yellow      Yellow,   Green-ish
colors = [("#3a4360", "#f1fa8c"), ("#3a4360", "#50fa7b")]

widgets = (
    [
        widget.Spacer(length=6),
        widget.GroupBox(**groupbox_settings),
        widget.Spacer(length=6),
        widget.Sep(linewidth=1, size_percent=90),
        widget.Spacer(length=6),
        widget.CurrentLayoutIcon(scale=0.8),
        widget.Spacer(length=3),
        widget.CurrentLayout(foreground="#FFFFFF"),
        widget.Spacer(length=3),
        widget.Sep(linewidth=1, size_percent=90),
        widget.Spacer(length=6),
        widget.CurrentScreen(acitve_color=colors[1][1], inactive_color="ff5555"),
        # widget.Spacer(length=6),
        #widget.Sep(linewidth=1, size_percent=90),
        # widget.Spacer(length=6),
        # widget.WindowName(format="{name}", max_chars=30, foreground="#d4d4d4"),
        widget.Spacer(length=bar.STRETCH),
        # widget.TextBox(text="", padding=0, background="#003b6b",
        #                foreground=colors[0][0], fontsize=17.23),
    ]
    + ([widget.TextBox(text=" ", fontsize=17.23, background=colors[0][0], foreground=colors[0]
       [1]), widget.Wlan(format="{essid}", interface="wlo1", background=colors[0][0], foreground=colors[0][1])])
    +
    [
        # widget.TextBox(text="", fontsize=17.23, padding=0,
        #                background=colors[0][0], foreground=colors[1][0]),
        widget.Spacer(length=4),
        widget.Sep(foregroud="#f8f8f2", size_percent=97),
        widget.Spacer(length=4),
        widget.TextBox(text="", fontsize=17.23,
                       background=colors[1][0], foreground=colors[1][1]),
        widget.ThermalSensor(tag_sensor="Package id 0", threshold=80,
                             background=colors[1][0], foreground=colors[1][1]),
        # widget.TextBox(text="", fontsize=17.23, padding=0,
        #                background=colors[1][0], foreground=colors[1][1])
    ]
    + ([widget.Spacer(length=4),
        widget.Sep(foregroud="#f8f8f2", size_percent=97),
        widget.Spacer(length=4),
        widget.TextBox(text="辶", fontsize=20,
                       background=colors[0][0], foreground=colors[0][1], padding=5),
        widget.NvidiaSensors(background=colors[0][0], foreground=colors[0][1]),
        #     widget.TextBox(text="", fontsize=17.23, padding=0,
        #    background=colors[0][0], foreground=colors[1][0]),
        #
        ] if gpu_is_nvidia else [])
    + [
        widget.Spacer(length=4),
        widget.Sep(foregroud="#f8f8f2", size_percent=97),
        widget.Spacer(length=4),
        widget.Net(format="{down} ↓↑ {up}",
                   background=colors[1][0], foreground=colors[1][1]),
        # widget.TextBox(text="", fontsize=17.23, padding=0,
        #                background=colors[1][0], foreground=colors[0][0]),
        widget.Spacer(length=4),
        widget.Sep(foregroud="#f8f8f2", size_percent=97),
        widget.Spacer(length=4),
        widget.CheckUpdates(
            display_format='{updates} Updates', max_chars=20, no_update_string="No Updates", background=colors[0][0],
            distro="Arch_checkupdates", foreground=colors[0][1],
            colour_have_updates=colors[0][1], colour_no_updates=colors[0][1]),
        # widget.TextBox(text="", fontsize=17.23, padding=0,
        #                background=colors[0][0], foreground=colors[1][0]),
        widget.Spacer(length=4),
        widget.Sep(foregroud="#f8f8f2", size_percent=97),
        widget.Spacer(length=4),
        widget.Battery(format='{char} {percent:2.0%}',
                       background=colors[1][0], foreground=colors[1][1],
                       charge_char="", discharge_char="", empty_char=""),
        # widget.TextBox(text="", fontsize=17.23, padding=0,
        #                background=colors[1][0], foreground=colors[1][1]),
        widget.Spacer(length=4),
        widget.Sep(foregroud="#f8f8f2", size_percent=97),
        widget.Spacer(length=4),
        widget.TextBox(
            text=fa.icons["memory"],
            fontsize=15,
            font="Font Awesome 6 Free Solid",
            padding=0, background=colors[0][0], foreground=colors[0][1]
        ),
        widget.Memory(format="{MemUsed: .1f}{mm}", measure_mem="G",
                      padding=0, background=colors[0][0], foreground=colors[0][1]),
        widget.Spacer(length=4),
        widget.Sep(foregroud="#f8f8f2", size_percent=97),
        widget.Spacer(length=4),
        #widget.Spacer(length=5, background=colors[0][0]),
        # widget.TextBox(text="", fontsize=17.23, padding=0,
        #                background=colors[0][0], foreground=colors[1][0]),
        widget.TextBox(text="", fontsize=17.23,
                       background=colors[1][0], foreground=colors[1][1]),
        widget.CPU(format="{load_percent:02.0f}%",
                   background=colors[1][0], foreground=colors[1][1]),
        # widget.TextBox(text="", fontsize=17.23, padding=0,
        #                background=colors[1][0], foreground=colors[0][0]),
        widget.Spacer(length=4),
        widget.Sep(foregroud="#f8f8f2", size_percent=97),
        widget.Spacer(length=4),
        widget.Systray(background=colors[0][0], foreground=colors[0][1]),
        # qtile_extras.widget.statusnotifier.StatusNotifier(),
        #widget.Spacer(length=2, background=colors[0][0]),
        # widget.TextBox(text="", fontsize=17.23, padding=0,
        #                background=colors[0][0], foreground=colors[1][0]),
        widget.Spacer(length=4),
        widget.Sep(foregroud="#f8f8f2", size_percent=97),
        widget.Spacer(length=4),
        widget.KeyboardLayout(
            configured_keyboards=["us", "ir"],
            display_map={"ir": "FA"},
            fmt="韛 {}", background=colors[1][0], foreground=colors[1][1]
        ),
        # widget.TextBox(text="", fontsize=17.23, padding=0,
        #                background=colors[1][0], foreground=colors[0][0]),
        widget.Spacer(length=4),
        widget.Sep(foregroud="#f8f8f2", size_percent=97),
        widget.Spacer(length=4),
        widget.Volume(background=colors[0][0],
                      foreground=colors[0][1], device="pulse"),
        # widget.TextBox(text="", fontsize=17.23, padding=0,
        #                background=colors[0][0], foreground=colors[1][0]),
        widget.Spacer(length=4),
        widget.Sep(foregroud="#f8f8f2", size_percent=97),
        widget.Spacer(length=4),
        widget.Clock(format=" %a %d %b  %I:%M %p", width=bar.CALCULATED,
                     background=colors[1][0], foreground=colors[1][1]),
        widget.Spacer(length=2, background=colors[1][0]),
        # widget.TextBox(text="", fontsize=17.23, padding=0,
        #                background=colors[1][0], foreground=colors[0][0]),
        # widget.TextBox(text=" ", fontsize=17.23, mouse_callbacks={
        #                "Button1": open_power}, background=colors[0][0], foreground=colors[0][1]),
        widget.Spacer(length=6)
    ]
)
screens = [
    Screen(
        top=bar.Bar(
            widgets,
            20,
            margin=[5, 6, 2, 6],
            background="#3a4360"
        ),
        bottom=bar.Gap(3),
        left=bar.Gap(3),
        right=bar.Gap(3),
    ),
    Screen(),
    Screen(),
]

# Drag floating layouts.
mouse = [
    Drag(
        [mod],
        "Button1",
        lazy.window.set_position_floating(),
        start=lazy.window.get_position(),
    ),
    Drag(
        [mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()
    ),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: List
follow_mouse_focus = True
cursor_warp = False
floating_layout = Floating(border_normal="#022430", border_focus="#89aaff",
                                  float_rules=[
                                      # Run the utility of `xprop` to see the wm class and name of an X client.
                                      *Floating.default_float_rules,
                                      Match(wm_class="confirmreset"),  # gitk
                                      Match(wm_class="makebranch"),  # gitk
                                      Match(wm_class="maketag"),  # gitk
                                      # ssh-askpass
                                      Match(wm_class="ssh-askpass"),
                                      Match(title="branchdialog"),  # gitk
                                      # GPG key password entry]
                                      Match(title="pinentry"),
                                      Match(role="pop-up"),
                                  ]
                                  )
auto_fullscreen = True
focus_on_window_activation = "focus"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = False
bring_front_click = "floating_only"
# Java whitelist thing
wmname = "LG3D"
