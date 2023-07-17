#!/usr/bin/env bash
# Install spotify
flatpak install --user com.discordapp.Discord -y

# install betterdiscord 
echo "install betterdiscord ..."
betterdiscordctl -i flatpak install

echo "
/* @import url("https://catppuccin.github.io/discord/dist/catppuccin-latte-teal.theme.css"); */
/* @import url("https://catppuccin.github.io/discord/dist/catppuccin-mocha-teal.theme.css"); */
" >> $HOME/.var/app/com.discordapp.Discord/config/BetterDiscord/data/stable/custom.css
