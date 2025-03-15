select_dialog() {
    esc=$(echo -en '\e')
    cur=0
    prompt="$1"
    out_var="$2"
    shift; shift
    options=("$@")
    count=${#options[@]}

    echo "$prompt"
    while true; do

        index=0 
        for o in "${options[@]}"
        do
            if [ "$index" == "$cur" ]
            then echo -e "\e[32;1m-> \e[7m$o\e[0m" # mark & highlight the current option
            else echo "   $o"
            fi
            (( index++ ))
        done
        rem=3
        while test $rem -gt '0'; do
            read -s -n1 char_in
            case "$char_in" in
                0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9)
                    if test "$rem" -eq 3; then
                        key="$char_in"
                        rem = 0
                    else
                        rem=3
                    fi
                    ;;
                "$esc")
                    if test "$rem" -eq 3; then
                        rem=2
                    else
                        rem=3
                    fi
                    ;;
                "[")
                    if test "$rem" -eq 2; then
                        rem=1
                    else
                        rem=3
                    fi
                    ;;
                A | B | C)
                    if test "$rem" -eq 1; then
                        rem=0
                        key="$esc[$char_in"
                    else
                        rem=3
                    fi
                    ;;
                '')
                    key=''
                    rem=0
                    ;;
                *)
                    rem=3
            esac
        done
        case "$key" in
            "$esc[A")
                test "$cur" -gt '0' && (( cur-- ))
                ;;
            "$esc[B")
               test "$cur" -lt "$(( count - 1 ))" && (( cur++ ))
                ;;
            1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9)
                cur="$key"; test "$cur" -ge "$(( count ))" && cur="$(( count - 1 ))"
                ;;
            "$esc[C" | '')
                break
                ;;
        esac
        echo -en "\e[${count}A"
    done
    eval $"$out_var"=$cur
}
