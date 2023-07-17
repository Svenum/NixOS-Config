#!/usr/bin/env bash

# Prepare config
echo "prepare config ..."
sed -i 's,spotify_path *=.*,spotify_path = '"$HOME"'/.local/share/flatpak/app/com.spotify.Client/x86_64/stable/active/files/extra/share/spotify/,g' $HOME/.config/spicetify/config-xpui.ini
sed -i 's,prefs_path *=.*,prefs_path = '"$HOME"'/.var/app/com.spotify.Client/config/spotify/prefs,g' $HOME/.config/spicetify/config-xpui.ini

# Prepare backupe
echo "prepare backup ..."
spicetify backup apply

# Install marketplace
# echo "install marketplace ..."
curl -fsSL https://raw.githubusercontent.com/spicetify/spicetify-marketplace/main/resources/install.sh | sh
