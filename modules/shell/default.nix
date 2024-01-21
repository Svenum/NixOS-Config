{ pkgs, settings, ... }:

{
  # Default alias
  environment.shellInit = ''
      su() {
        if [[ $1 != "" ]]; then
          ${pkgs.su}/bin/su $@
        else
          sudo -s
        fi
      }
    '';

    imports = [ ./${settings.shell}.nix ];
}
