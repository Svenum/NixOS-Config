{ lib, stdenvNoCC, fetchFromGitHub, ... }:

stdenvNoCC.mkDerivation {
  pname = "plasma-applet-betterinlineclock";
  version = "01.03.2024";

  src = fetchFromGitHub {
    owner = "Svenum";
    repo = "kde-plasmoid-betterinlineclock";
    rev = "plasma6";
    sha256 = "sha256-e1K1QYbIHzgjs0PlFGmJcrlPwZ/kLqKfQGOCh52ZAJs=";
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
