#!/bin/bash
# 💫 https://github.com/JaKooLit 💫 #
# pokemon-color-scripts#

## WARNING: DO NOT EDIT BEYOND THIS LINE IF YOU DON'T KNOW WHAT YOU ARE DOING! ##
# Determine the directory where the script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Change the working directory to the parent directory of the script
PARENT_DIR="$SCRIPT_DIR/.."
cd "$PARENT_DIR" || exit 1

source "$(dirname "$(readlink -f "$0")")/Global_functions.sh"

# Set the name of the log file to include the current date and time
LOG="Install-Logs/install-$(date +%d-%H%M%S)_zsh_pokemon.log"

printf "${NOTE} Removing any traces of ${SKY_BLUE}Pokemon Color Scripts${RESET}\n"

# Check if the pokemon directory exists
if [ -d "/usr/local/opt/pokemon-colorscripts" ]; then
    sudo rm -rf /usr/local/opt/pokemon-colorscripts
fi

# Check if the pokemon file exists
if [ -f "/usr/local/bin/pokemon-colorscripts" ]; then
    sudo rm -f /usr/local/bin/pokemon-colorscripts
fi

# Install Pokemon Color Scripts
printf "${NOTE} Installing ${SKY_BLUE}Pokemon Color Scripts${RESET}\n"
for pok in "pokemon-colorscripts-git"; do
  install_package "$pok" "$LOG"
done

printf "\n%.0s" {1..1}
# Check if ~/.zshrc exists
if [ -f "$HOME/.zshrc" ]; then
    sed -i '/#pokemon-colorscripts --no-title -s -r | fastfetch -c $HOME\/.config\/fastfetch\/config-pokemon.jsonc --logo-type file-raw --logo-height 10 --logo-width 5 --logo -/s/^#//' "$HOME/.zshrc" >> "$LOG" 2>&1
    sed -i '/^fastfetch -c $HOME\/.config\/fastfetch\/config-compact.jsonc/s/^/#/' "$HOME/.zshrc" >> "$LOG" 2>&1
else
    echo "$HOME/.zshrc not found. Cant enable ${YELLOW}Pokemon color scripts${RESET}" >> "$LOG" 2>&1
fi
  
printf "\n%.0s" {1..2}
