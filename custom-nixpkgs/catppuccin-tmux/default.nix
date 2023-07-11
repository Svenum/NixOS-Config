{ pkgs, lib, fetchFromGitHub }:

{
  catppuccin = pkgs.tmuxPlugins.mkTmuxPlugin {
    pluginName = "catppuccin";
    version = "unstable-2023-07-11";
    src = fetchFromGitHub {
      owner = "catppuccin";
      repo = "tmux";
      rev = "e7b50832f9bc59b0b5ef5316ba2cd6f61e4e22fc";
      sha256 = "sha256-bXEsxt4ozl3cAzV3ZyvbPsnmy0RAdpLxHwN82gvjLdU=";
    };
    postInstall = ''
      sed -i -e 's|''${PLUGIN_DIR}/catppuccin-selected-theme.tmuxtheme|''${TMUX_TMPDIR}/catppuccin-selected-theme.tmuxtheme|g' $target/catppuccin.tmux
    '';
    meta = with lib; {
      homepage = "https://github.com/catppuccin/tmux";
      description = "Soothing pastel theme for Tmux!";
      license = licenses.mit;
      platforms = platforms.unix;
      maintainers = with maintainers; [ jnsgruk ];
    };
  };
}
