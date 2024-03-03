{ lib, stdenvNoCC, fetchFromGitHub, ... }:

stdenvNoCC.mkDerivation {
  pname = "plasma-applet-shutdownorswitch";
  version = "01.03.2024";

  src = fetchFromGitHub {
    owner = "Svenum";
    repo = "shutdown_or_switch";
    rev = "plasma6";
    sha256 = "sha256-0MEnoNvrdL+BkrFUntVzt/WwXhUOGU7Gc8VGbGzp/DI=";
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
