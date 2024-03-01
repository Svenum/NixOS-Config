{ lib, stdenvNoCC, fetchFromGitHub, ... }:

stdenvNoCC.mkDerivation {
  pname = "plasma-applet-shutdownorswitch";
  version = "01.03.2024";

  src = fetchFromGitHub {
    owner = "Svenum";
    repo = "shutdown_or_switch";
    rev = "plasma6";
    sha256 = "sha256-ElfbICZkJbVG/oZEG6Lh50QRM0FXr4f8n7rbu5Gb1jY=";
  };

  installPhase = ''
    mkdir -p $out/share/plasma/plasmoids/
    cp -r $src/plasmoid $out/share/plasma/plasmoids/org.kde.shutdownOrSwitch
  '';

  meta = with lib; {
    homepage = "https://github.com/Davide-sd/shutdown_or_switch";
    license = lib.licenses.gpl2Only;
  };
}
