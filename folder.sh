#!/bin/bash
# echo "provide a dir name: "
# read dir_name

# if ls | grep -q $dir_name; then
#     print_color "red" "$dir_name dir exists"
# else
#     echo "dir is creating"
#     mkdir -p /home/vscharan/test/$dir_name
#     print_color "green" "$dir_name dir created"
# fi

function print_color() {
    case $1 in
    "red") COLOR="\033[0;31m" ;;
    "green") COLOR="\033[0;32m" ;;
    "yellow") COLOR="\033[0;33m" ;;
    *) COLOR="\033[0m" ;;
    esac
    echo -e "${COLOR} $2"
}

path="/home/vscharan/test"

if [ $# -gt 0 ]; then
    for DIR_NAME in "$@"; do
        if [ -d "$path/$DIR_NAME" ]; then
            print_color "red" "$DIR_NAME dir exists"
        else
            print_color "*" "Creating directory $DIR_NAME..."
            mkdir -p "$path/$DIR_NAME"
            print_color "green" "$DIR_NAME dir created"
        fi
    done
else
    print_color "yellow" "Please provide at least one argument"
fi
