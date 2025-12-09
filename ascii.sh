#!/bin/bash

ascii_art='   _____          _      _  __     _     
  / ____|        | |    | |/ /    | |    
 | |     ___   __| | ___| \' / ___ | |__  
 | |    / _ \ / _` |/ _ \  < / _ \| \'_ \ 
 | |___| (_) | (_| |  __/ . \ (_) | |_) |
  \_____\___/ \__,_|\___|_|\_\___/|_.__/ 
'


# Define the color gradient (shades of cyan and blue)
colors=(
	'\033[38;5;81m' # Cyan
	'\033[38;5;75m' # Light Blue
	'\033[38;5;69m' # Sky Blue
	'\033[38;5;63m' # Dodger Blue
	'\033[38;5;57m' # Deep Sky Blue
	'\033[38;5;51m' # Cornflower Blue
	'\033[38;5;45m' # Royal Blue
)

# Split the ASCII art into lines
IFS=$'\n' read -rd '' -a lines <<<"$ascii_art"

# Print each line with the corresponding color
for i in "${!lines[@]}"; do
	color_index=$((i % ${#colors[@]}))
	echo -e "${colors[color_index]}${lines[i]}"
done
