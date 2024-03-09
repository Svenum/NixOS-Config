{ lib, stdenvNoCC, fetchFromGitHub, ... }:

stdenvNoCC.mkDerivation {
  pname = "plasma-applet-quickshutdown";
  version = "09.03.2024";

  src = fetchFromGitHub {
    owner = "Svenum";
    repo = "quick_shutdown";
    rev = "dd5695522472894bbc76bcd101f8039b10d9633e";
    sha256 = "sha256-S+CCbYvUUniHEzX7EpLbWSZ372zoUmlanhF86/y4iXY=";
  };

  installPhase = ''
    mkdir -p $out/share/plasma/plasmoids/
    cp -r $src/package $out/share/plasma/plasmoids/org.kde.plasma.quickshutdown
  '';

  meta = with lib; {
    homepage = "https://github.com/Svenum/quick_shutdown";
    license = lib.licenses.gpl2Only;
  };
}
