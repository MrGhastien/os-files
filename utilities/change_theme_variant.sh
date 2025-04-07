#! /bin/sh

echoerr() {
    echo "$@" 1>&2
}

if [ "$#" -lt 1 ]; then
    echoerr "Usage: $(basename $0) <variant>"
    exit 64
fi

variant="$1"

case $variant in
    light|dark);;
    *)
        echoerr "Invalid variant $variant."
        exit 1
        ;;
esac

printf "$variant" > "$HOME/.config/theme_variant"

# Tell kitty instances to reload the config
pkill --signal SIGUSR1 kitty

gsettings set org.gnome.desktop.interface color-scheme "prefer-$variant"

emacsclient -e "(enable-theme 'test-${variant})"
