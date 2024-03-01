{ lib, stdenvNoCC, fetchgit, ... }:

stdenvNoCC.mkDerivation {
  pname = "plasma-applet-betterinlineclock";
  version = "24.07.2020";

  src = fetchgit {
    url = "https://github.com/Svenum/kde-plasmoid-betterinlineclock.git";
    sha256 = "sha256-BLZisuTcndV7yRkPGv+Jmdx/wjcqXyhDj4ia6ASwHK8=";
  };

  installPhase = ''
    mkdir -p $out/share/plasma/plasmoids/
    cp -r $src/org.kde.plasma.betterinlineclock $out/share/plasma/plasmoids/
  '';

  meta = with lib; {
    homepage = "https://github.com/MarianArlt/kde-plasmoid-betterinlineclock";
    license = lib.licenses.gpl3Only;
  };
}
