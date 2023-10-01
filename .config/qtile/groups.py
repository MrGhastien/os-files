from libqtile.config import Group, Key
from libqtile.lazy import lazy

group_labels = [c for c in "1234567890"]
azerty_group_names = ['ampersand', 'eacute', 'quotedbl', 'apostrophe', 'parenleft', 'minus', 'egrave', 'underscore', 'ccedilla', 'agrave']
group_names = [c for c in "1234567890"]

def getGroups(keys, modKey):
    groups = []p
    for i in range(len(group_names)):
        groups.append(
	    Group(
	        name=group_names[i],
	        label=group_labels[i]
	    )
        )

    for g in groups:
        keys.extend(addGroupKeys(g, modKey))
    return groups

def addGroupKeys(g, modKey):
    results = [
        Key(
            [modKey],
            g.name,
            lazy.group[g.name].toscreen(),
            desc="Switch to group {}".format(g.name),
        ),
        Key(
            [modKey],
            azerty_group_names[int(g.name) - 1],
            lazy.group[g.name].toscreen(),
            desc="Switch to group {}".format(g.name),
        ),
        Key(
            [modKey, "shift"],
            g.name,
            lazy.window.togroup(g.name, switch_group=True),
            desc="move focused window to group {}".format(g.name),
        ),
        Key(
            [modKey, "shift"],
            azerty_group_names[int(g.name) - 1],
            lazy.window.togroup(g.name, switch_group=True),
            desc="move focused window to group {}".format(g.name),
        ),
    ]
    return results
