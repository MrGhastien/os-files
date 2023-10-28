import os
import subprocess

from typing import List  # noqa: F401

from libqtile import bar, layout, widget
from libqtile.config import Click, Drag, EzKey, Key, Match, Screen
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal
from libqtile import hook

from constants import *
import groups
import hooks

mod = "mod4"
terminal = "alacritty"

layouts = [
        layout.Columns(
	        border_focus=BORDER_COLOR,
	        border_width=2,
	        border_normal=BACKGROUND_COLOR,
	        margin=5,
	        border_on_single=False,	
	        margin_on_single=0,
        ),
        layout.Max(),
    # Try more layouts by unleashing below layouts.
    # layout.Stack(num_stacks=2),
    # layout.Bsp(),
    # layout.Matrix(),
    # layout.MonadTall(),
    # layout.MonadWide(),
    # layout.RatioTile(),
    # layout.Tile(),
    # layout.TreeTab(),
    # layout.VerticalTile(),
    # layout.Zoomy(),
]

# Key bindings
keys = [
    # at https://docs.qtile.org/en/latest/manual/config/lazy.html
    # Switch between windows
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    Key([mod], "space", lazy.layout.next(), desc="Move window focus to other window"),
    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key([mod, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right(), desc="Move window to the right"),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),
    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key([mod, "control"], "h", lazy.layout.grow_left(), desc="Grow window to the left"),
    Key([mod, "control"], "l", lazy.layout.grow_right(), desc="Grow window to the right"),
    Key([mod, "control"], "j", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key(
        [mod, "shift"],
        "Return",
        lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack",
    ),
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    # Toggle between different layouts as defined below
    Key([mod, "shift"], "q", lazy.window.kill(), desc="Kill focused window"),
    Key([mod, "control"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    Key([mod], "d", lazy.spawn("rofi -show drun"), desc="Spawn Rofi to run a program."),
    Key([mod], "w", lazy.spawn("rofi -show window"), desc="Spawn Rofi to navigate between windows."),
    Key([mod], "e", lazy.spawn("emacsclient -c -a ''"), desc="Launch emacs with a daemon"),
    Key([mod], "p", lazy.spawn("autorandr --change"), desc="Reload the randr screen configuration"),
    Key([], "XF86MonBrightnessUp", lazy.spawn("brillo -A 5"), desc="Increase monitor brightness"),
    Key([], "XF86MonBrightnessDown", lazy.spawn("brillo -U 5"), desc="Decrease monitor brightness"),
    Key([], "XF86AudioRaiseVolume", lazy.spawn("/home/mrghastien/.config/qtile/changeVolume.sh 2%+"), desc="Increase master volume"),
    Key([], "XF86AudioLowerVolume", lazy.spawn("/home/mrghastien/.config/qtile/changeVolume.sh 2%-"), desc="Decrease master volume"),
    Key([], "XF86AudioMute", lazy.spawn("/home/mrghastien/.config/qtile/changeVolume.sh mute"), desc="Mute/unmute master"),
    Key([mod], "space", lazy.widget["keyboardlayout"].next_keyboard()),
    Key([mod], "f", lazy.window.toggle_floating()),
    Key([mod], "y", lazy.window.toggle_fullscreen()),
    Key([mod], "g", lazy.window.toggle_minimize()),
    Key([mod], "o", lazy.group.setlayout('columns')),
    Key([mod], "i", lazy.group.setlayout('max')),

    # Key([mod, "shift"], "Return", lazy.spawn("aplay /home/mrghastien/dev/boom.wav")),
    # Key([mod, "shift"], "Tab", lazy.spawn("aplay /home/mrghastien/dev/helikopter.wav")),
    # Key([mod, "shift"], "b", lazy.spawn("aplay /home/mrghastien/dev/boom-disto.wav")),
    # Key([mod, "shift"], "c", lazy.spawn("aplay /home/mrghastien/dev/OMG.wav")),
    # Key([mod, "shift"], "n", lazy.spawn("aplay /home/mrghastien/dev/omg-bruh.wav")),
    # Key([mod, "shift"], "v", lazy.spawn("aplay /home/mrghastien/dev/augh.wav")),
]

groups = groups.getGroups(keys, mod)


widget_defaults = dict(
    font="Inter SemiBold",
    fontsize=13,
    #padding=2,
    foreground="#e0e0e0",
	
)
extension_defaults = widget_defaults.copy()

clock_format="%A %d/%m/%Y - %H:%M:%S"

default_sep=widget.Sep(
	padding=15,
	size_percent=50,
	linewidth=1,
	foreground="#ebdbb2",
)

systray = widget.Systray()
kbwidget = widget.KeyboardLayout(
    configured_keyboards=KEYBOARD_LAYOUTS,
    foreground='#8ec07c'
)


def create_main_bar():
    return bar.Bar(
        [
            widget.QuickExit(),
	    default_sep,
            widget.CurrentLayout(),
            widget.GroupBox(
	        highlight_method='line',
                highlight_color=[SEL_WS_BG_COLOR, SEL_WS_BG_COLOR],
                #highlight_color=[SEL_WS_BG_COLOR, "#6f2e0f"],
	        this_current_screen_border="#d54010",
	        this_screen_border="#d54010",
	        other_current_screen_border="#605050",
	        other_screen_border="#605050",
	        inactive="#4a4742",
                active='#fe8019',
                disable_drag=True,
                #margin_y=6,
                padding_x=5,
                urgent_text='#fb4934',
                font='Iosevka Custom Extrabold'
	    ),
	    default_sep,
            widget.WindowName(),
            widget.Chord(
                chords_colors={
                    "launch": ("#ff0000", "#ffffff"),
                },
                name_transform=lambda name: name.upper(),
            ),
	    default_sep,
            systray,
	    widget.Net(
                format='{down}{down_suffix}  ↓↑ {up}{up_suffix}  ({total}{total_suffix})',
            ),
            kbwidget,
            widget.Clock(
                format=clock_format,
                foreground='#83a598'
            ),
        ],
        25,
        #border_width=[2, 0, 0, 0],  # Draw top and bottom borders
        #border_color=BAR_BORDER_COLOR,
	background=BACKGROUND_COLOR,
        #margin=[5, 5, 5, 5],
        margin=0,
    )

def create_bar():
    return bar.Bar(
        [
            widget.QuickExit(),
	    default_sep,
            widget.CurrentLayout(),
            widget.GroupBox(
	        highlight_method='line',
                highlight_color=[SEL_WS_BG_COLOR, SEL_WS_BG_COLOR],
                #highlight_color=[SEL_WS_BG_COLOR, "#6f2e0f"],
	        this_current_screen_border="#d54010",
	        this_screen_border="#d54010",
	        other_current_screen_border="#605050",
	        other_screen_border="#605050",
	        inactive="#4a4742",
                active='#fe8019',
                disable_drag=True,
                #margin_y=6,
                padding_x=5,
                urgent_text='#fb4934',
                font='Iosevka Custom Extrabold',
	    ),
	    default_sep,
            widget.WindowName(),
            widget.Chord(
                chords_colors={
                    "launch": ("#ff0000", "#ffffff"),
                },
                name_transform=lambda name: name.upper(),
            ),
	    default_sep,
            kbwidget,
            widget.Clock(
                format=clock_format,
                foreground='#83a598'
            ),
        ],
        25,
        #border_width=[2, 0, 0, 0],  # Draw top and bottom borders
        #border_color=BAR_BORDER_COLOR,
	background=BACKGROUND_COLOR,
        #margin=[5, 5, 5, 5],
        margin=0,
    )
    

screens = [
	Screen(
		bottom=create_main_bar(),
		wallpaper=WALLPAPER,
                wallpaper_mode="fill",
	),
	Screen(
		bottom=create_bar(),
		wallpaper=WALLPAPER,
                wallpaper_mode="fill",
	)
]

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: List
follow_mouse_focus = True
bring_front_click = True
cursor_warp = False
floating_layout = layout.Floating(
        border_focus="#fe8019",
	border_width=2,
	border_normal=BACKGROUND_COLOR,
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
reconfigure_screens = False

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = False

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
