#!/usr/bin/env bash
# Install spotify
flatpak install --user com.discordapp.Discord -y

# install betterdiscord 
echo "install betterdiscord ..."
betterdiscordctl -i flatpak install
