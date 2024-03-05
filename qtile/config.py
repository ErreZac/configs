from libqtile import bar, layout, widget
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
import os
import subprocess
from libqtile import hook
from bar_slants import left_slant, right_slant, right_half_slant, left_half_slant
from rose_pine_moon import colorz

@hook.subscribe.startup_once
def autostart():
    home = os.path.expanduser('~/.config/qtile/autostart.sh')
    subprocess.Popen([home])

mod = "mod4"
terminal = "alacritty" 

keys = [
    # Switch between windows
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    Key([mod], "n", lazy.layout.next(), desc="Move window focus to other window"),
    Key([mod], "p", lazy.layout.previous(), desc="Move window focus to other window"),
    Key([mod, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right(), desc="Move window to the right"),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),
    Key([mod, "control"], "h", lazy.layout.grow_left(), desc="Grow window to the left"),
    Key([mod, "control"], "l", lazy.layout.grow_right(), desc="Grow window to the right"),
    Key([mod, "control"], "j", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod], "i", lazy.layout.grow()),
    Key([mod], "m", lazy.layout.shrink()),
    Key([mod], "n", lazy.layout.normalize()),
    Key([mod], "o", lazy.layout.maximize()),
    Key([mod, "shift"], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
    Key([mod], "b", lazy.hide_show_bar("top")),
    # Key( [mod, "shift"], "Return", lazy.layout.toggle_split(), desc="Toggle between split and unsplit sides of stack",),
    # Key([mod, "control"], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    Key([mod, "shift"], "Return", lazy.spawn(terminal + " -e nvim /home/zac/.config/conky/todo.md"), desc="Launch terminal"),
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod, "shift"], "c", lazy.window.kill(), desc="Kill focused window"),
    Key([mod, "shift"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "shift"], "p", lazy.spawn("scrot"), desc="Reload the config"),
    Key([mod, "shift"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    Key([mod, "control", "shift"], "q", lazy.spawn("poweroff"), desc="Shutdown Qtile"),
    Key([mod, "control", "shift"], "r", lazy.spawn("reboot"), desc="Shutdown Qtile"),
    Key([mod], "space", lazy.spawn("rofi -show run -theme /home/zac/.config/rofi/rofi/rose-pine-moon.rasi"), desc="Spawn dmenu"),

    Key([], "XF86Launch1", lazy.spawn("/home/zac/.config/sxhkd/scripts/cycle_profiles.sh"), desc=""),
    Key([], "XF86Launch4", lazy.spawn("/home/zac/.config/sxhkd/scripts/toggle_fan_curve.sh"), desc=""),
    Key([], "XF86AudioMute", lazy.spawn("amixer -D pulse sset Master toggle"), desc=""),
    Key([], "XF86AudioRaiseVolume", lazy.spawn("amixer -D pulse sset Master 5%+"), desc=""),
    Key([], "XF86AudioLowerVolume", lazy.spawn("amixer -D pulse sset Master 5%-"), desc=""),
    Key([], "XF86MonBrightnessUp", lazy.spawn("/home/zac/.config/sxhkd/scripts/brightness.sh + eDP-1"), desc=""),
    Key([], "XF86MonBrightnessDown", lazy.spawn("/home/zac/.config/sxhkd/scripts/brightness.sh - eDP-1"), desc=""),
    Key([], "XF86KbdBrightnessUp", lazy.spawn("asusctl -n"), desc=""),
    Key([], "XF86KbdBrightnessDown", lazy.spawn("asusctl -p"), desc=""),
    # Key([], "", lazy.spawn(""), desc=""),
]

groups = [Group(i) for i in "123456789"]

for i in groups:
    keys.extend(
        [
            # mod1 + letter of group = switch to group
            Key(
                [mod],
                i.name,
                lazy.group[i.name].toscreen(),
                desc="Switch to group {}".format(i.name),
            ),
            # mod1 + shift + letter of group = switch to & move focused window to group
            Key(
                [mod, "shift"],
                i.name,
                lazy.window.togroup(i.name, switch_group=False),
                desc="Switch to & move focused window to group {}".format(i.name),
            ),
            # Or, use below if you prefer not to switch to that group.
            # # mod1 + shift + letter of group = move focused window to group
            # Key([mod, "shift"], i.name, lazy.window.togroup(i.name),
            #     desc="move focused window to group {}".format(i.name)),
        ]
    )

layouts = [
    layout.Max(
        border_focus=colorz["green"],
        border_normal=colorz["gray"], 
        margin=0
        ),
    layout.MonadTall(
        border_focus=colorz["green"],
        border_normal=colorz["lightblack"],
        border_width=2,
        margin_on_single=0,
        ratio=.55,
        # margin_on_single=0,
        margin=0,
        # margin=0,
        ),
    # layout.Floating(
    #     border_focus=colorz["green"],
    #     border_normal=colorz["gray"], 
    #     border_width=2
    #     ),
]

widget_defaults = dict(
    font="FiraCode Nerd Font",
    fontsize=22,
    padding=0,
)
extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        top=bar.Bar(
            [
                widget.Spacer(length=5, background=colorz["black"]),
                widget.CurrentLayoutIcon(background=colorz["black"]),
                # left_slant(),
                widget.GroupBox(background=colorz["black"], padding = 4),
                left_slant(),
                # widget.Prompt(),
                widget.WindowName(scroll=True,width=700,background=colorz["black"]),
                left_slant(),
                left_half_slant(),
                widget.Spacer(length=bar.STRETCH),
                # widget.Chord(
                #     chords_colors={
                #         "launch": ("#ff0000", "#ffffff"),
                #     },
                #     name_transform=lambda name: name.upper(),
                # ),
                # widget.TextBox("default config", name="default"),
                # widget.TextBox("Press &lt;M-r&gt; to spawn", foreground="#d75f5f"),
                # NB Systray is incompatible with Wayland, consider using StatusNotifier instead
                # widget.StatusNotifier(),
                right_half_slant(),
                right_slant(),
                widget.GenPollText(update_interval=1, padding=4, background=colorz["black"], func=lambda: subprocess.check_output("/home/zac/.config/polybar/get_profile.sh").decode().replace("\n", "")),
                right_slant(),
                widget.GenPollText(update_interval=1, padding=4, background=colorz["black"], func=lambda: subprocess.check_output("/home/zac/.config/polybar/get_fan_curve_status.sh").decode().replace("\n", "")),
                right_slant(),
                widget.GenPollText(update_interval=1, padding=4, background=colorz["black"], func=lambda: subprocess.check_output("/home/zac/.config/polybar/get_fan_rpm.sh").decode().replace("\n", "")),
                right_slant(),
                widget.ThermalZone(fmt='{}', background=colorz["black"], padding=4, fgcolor_crit=colorz["red"], fgcolor_high=colorz["yellow"]),
                right_slant(),
                widget.Volume(emoji=False,fmt='{}', background=colorz["black"], padding=4, volumeapp = "pavucontrol"),
                right_slant(),
                widget.Battery( background=colorz["black"], padding=4,format='{percent:2.0%}  {watt:.2f}W' ),
                right_slant(),
                widget.Clock(format=" %Y-%m-%d %a  %I:%M %p", padding=4, background=colorz["black"]),
                right_slant(),
                # widget.StatusNotifier(background=colorz["black"]),
                widget.Systray(background=colorz["black"]),
                widget.Spacer(length=5, background=colorz["black"]),
            ],
            30,
            # background=colorz["gray"]
            background=colorz["black"] + "e6",
            # margin = [5, 12, 5, 12],
            margin = [0, 0, 0, 0],
            opacity = 1,
            # border_width=[2, 0, 2, 0],  # Draw top and bottom borders
            # border_color=["ff00ff", "000000", "ff00ff", "000000"]  # Borders are magenta
        ),
    ),
]

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
    ]
)
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# When using the Wayland backend, this can be used to configure input devices.
wl_input_rules = None

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
