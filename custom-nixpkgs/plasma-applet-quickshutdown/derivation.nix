{ lib, stdenvNoCC, fetchFromGitHub, ... }:

stdenvNoCC.mkDerivation {
  pname = "plasma-applet-quickshutdown";
  version = "09.03.2024";

  src = fetchFromGitHub {
    owner = "Svenum";
    repo = "quick_shutdown";
    rev = "80a69adf3bd402dd8680bcbc7704b27401dfd410";
    sha256 = "sha256-CCjZ74YFIGA3cUFLvg85iTNNiKpz8eLKYswWHBHbars=";
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
