#! /bin/bash

pretend=false
while getopts :ph option; do
    case $option in
        p) pretend=true;;
        h)
            echo "Usage: $0 [-p] [-h]"
            exit 0
        ;;
        *)
            echo "Unknown option -- $OPTARG" 1>&2
            echo "Usage: $0 [-p] [-h]" 1>&2
            exit 3
        ;;
    esac
done
shift $(( OPTIND - 1 ))

if ! test -f ~/.config/wallpaper_choices.sh; then
    exit 2
fi

source ~/.config/wallpaper_choices.sh

monitor_count="$(hyprctl monitors  | grep '^Monitor' -c )"
if [ "$monitor_count" -le 0 ]; then exit 1; fi

monitors=($(hyprctl monitors  | grep  -oP '^Monitor \K([a-zA-Z0-9-]*)'))

command="swaybg"

selection=( $(shuf -e "${choices[@]}" -n "$monitor_count") )

for i in ${!monitors[@]}; do
    command="${command} -o ${monitors[$i]} -m fill -i ${wallpaper_dir}/${selection[$i]}"
done

if $pretend; then
    echo "$command"
else
    $command
fi
