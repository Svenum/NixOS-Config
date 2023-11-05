{ pkgs, shell, ... }:

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

    imports = [ ./${shell}.nix ];
}
