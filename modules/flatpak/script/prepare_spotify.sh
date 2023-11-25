#!/usr/bin/env bash
# Install spotify
flatpak install --user com.spotify.Client -y
echo "Please login and then close Spotify"
com.spotify.Client

# Prepare backupe
echo "prepare backup ..."
spicetify backup apply

# Prepare config
echo "prepare config ..."
mkdir -p $HOME/.config/spicetify
sed -i 's,spotify_path *=.*,spotify_path = '"$HOME"'/.local/share/flatpak/app/com.spotify.Client/x86_64/stable/active/files/extra/share/spotify/,g' $HOME/.config/spicetify/config-xpui.ini
sed -i 's,prefs_path *=.*,prefs_path = '"$HOME"'/.var/app/com.spotify.Client/config/spotify/prefs,g' $HOME/.config/spicetify/config-xpui.ini

spicetify restart 

# Install marketplace
# echo "install marketplace ..."
curl -fsSL https://raw.githubusercontent.com/spicetify/spicetify-marketplace/main/resources/install.sh | sh
