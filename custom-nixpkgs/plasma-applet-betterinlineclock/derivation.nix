{ lib, stdenvNoCC, fetchgit, ... }:

stdenvNoCC.mkDerivation {
  pname = "plasma-applet-betterinlineclock";
  version = "24.07.2020";

  src = fetchgit {
    url = "https://github.com/MarianArlt/kde-plasmoid-betterinlineclock.git";
    rev = "bbad71b48073879f16b484788d01831ad53316b5";
    sha256 = "sha256-BNHM6B/FViEcXaQfaygPkze8KrEhXrKhGUe93cAJMx0=";
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
