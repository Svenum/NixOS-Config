{ lib, stdenvNoCC, fetchgit, ... }:

stdenvNoCC.mkDerivation {
  pname = "plasma-applet-shutdownorswitch";
  version = "09.06.2021";

  src = fetchgit {
    url = "https://github.com/Davide-sd/shutdown_or_switch.git";
    rev = "8174e71c666a86eae3118f0a6d81ec67d37cb0d5";
    sha256 = "sha256-e+sta0YptBKdvc6/76TE5WLSi/Ac2AZrJKKCm/klKew=";
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
