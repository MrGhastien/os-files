#! /bin/sh

variant="$(< $HOME/.config/theme_variant)"
colors_file="$HOME/.config/kitty/colors-${variant}.conf"

if test -f "$colors_file"; then
    cat "$colors_file"
fi

