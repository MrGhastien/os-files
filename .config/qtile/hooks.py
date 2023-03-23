import os
import subprocess

import config as master_config

from libqtile import hook, bar, layout, qtile
from libqtile.config import Screen, Group
from libqtile.backend.base import Window
from libqtile.log_utils import logger

@hook.subscribe.startup_once
def onStartupOnce():
    startupShellScript = os.path.expanduser('~/.config/qtile/startup_once.sh')
    subprocess.Popen([startupShellScript])

#This is too slow !
#@hook.subscribe.setgroup
def onSetGroup():
    screen = qtile.current_screen
    changeBarMargins(screen.group.current_layout, screen.group)

#@hook.subscribe.group_window_add
def onWindowAdd(group, window):
    changeBarMargins(group.current_layout, group)

#@hook.subscribe.layout_change
def changeBarMargins(lay, group):
    logger.warning("Layout change !")
    screen = group.screen
    bar = screen.bottom
    nextKbLayout = master_config.kbwidget.backend.get_keyboard()
    if lay.name == "max" or len(group.windows) < 2:
        bar._initial_margin = [0] * 4
    else:
        bar._initial_margin = [5] * 4
    bar._configure(qtile, qtile.current_screen, True)
    group.layout_all()
    #Keep the previous keyboard layout
    master_config.kbwidget.backend.set_keyboard(nextKbLayout, master_config.kbwidget.option)
    master_config.kbwidget.tick()
