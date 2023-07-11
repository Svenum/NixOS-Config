{ pkgs, stdenv, lib }:
let
  rtpPath = "share/tmux-plugins";

  addRtp = path: rtpFilePath: attrs: derivation:
    derivation // { rtp = "${derivation}/${path}/${rtpFilePath}"; } // {
      overrideAttrs = f: mkTmuxPlugin (attrs // f attrs);
    };

  mkTmuxPlugin = a@{
    pluginName,
    rtpFilePath ? (builtins.replaceStrings ["-"] ["_"] pluginName) + ".tmux",
    namePrefix ? "tmuxplugin-",
    src,
    unpackPhase ? "",
    configurePhase ? ":",
    buildPhase ? ":",
    addonInfo ? null,
    preInstall ? "",
    postInstall ? "",
    path ? lib.getName pluginName,
    ...
  }:
    if lib.hasAttr "dependencies" a then
      throw "dependencies attribute is obselete. see NixOS/nixpkgs#118034" # added 2021-04-01
    else addRtp "${rtpPath}/${path}" rtpFilePath a (stdenv.mkDerivation (a // {
      pname = namePrefix + pluginName;

      inherit pluginName unpackPhase configurePhase buildPhase addonInfo preInstall postInstall;

      installPhase = ''
        runHook preInstall

        target=$out/${rtpPath}/${path}
        mkdir -p $out/${rtpPath}
        cp -r . $target
        if [ -n "$addonInfo" ]; then
          echo "$addonInfo" > $target/addon-info.json
        fi

        runHook postInstall
      '';
    }));

in rec {
  inherit mkTmuxPlugin;

  mkDerivation = throw "tmuxPlugins.mkDerivation is deprecated, use tmuxPlugins.mkTmuxPlugin instead"; # added 2021-03-14

  catppuccin = mkTmuxPlugin {
    pluginName = "catppuccin";
    version = "unstable-2023-04-03";
    src = fetchFromGitHub {
      owner = "catppuccin";
      repo = "tmux";
      rev = "4e48b09a76829edc7b55fbb15467cf0411f07931";
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
