{ lib, stdenvNoCC, fetchgit, ... }:

stdenvNoCC.mkDerivation {
  pname = "plasma-applet-shutdownorswitch";
  version = "13.12.2022";

  src = fetchgit {
    url = "https://github.com/Davide-sd/shutdown_or_switch.git";
    rev = "a835f3e88fc07712f4fcb4438359ac6fe74546fd";
    sha256 = "sha256-aust9074efwPdhFTSH6d5GsawPFWtq5T5I2pSgKmMME=";
  };

  installPhase = ''
    mkdir -p $out/share/plasma/plasmoids/org.kde.shutdownOrSwitch
    cp -r $src/plasmoid/* $out/share/plasma/plasmoids/org.kde.shutdownOrSwitch
  '';

  meta = with lib; {
    homepage = "https://github.com/Davide-sd/shutdown_or_switch";
    license = lib.licenses.gpl2Only;
  };
}
