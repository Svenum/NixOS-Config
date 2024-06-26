{ mkDerivation, brick, base, containers, directory, fetchgit
, filepath, lens, lib, linear, optparse-applicative, random
, transformers, vty_5_35_1, haskell, pkgs
}:

mkDerivation {
  pname = "tetris";
  version = "0.1.4.1";
  src = fetchgit {
    url = "https://github.com/Samtay/tetris.git";
    sha256 = "0m7agc52sqigrv4phgwny1lccsw18g4ffzli857hmnhip9p6m4hn";
    rev = "25560e51db05ad8cce9f7ed58ab449ed3ec9e0dd";
    fetchSubmodules = true;
  };
  isLibrary = true;
  isExecutable = true;
  libraryHaskellDepends = [
    base brick containers lens linear random transformers vty_5_35_1
  ];
  executableHaskellDepends = [
    base directory filepath optparse-applicative
  ];
  homepage = "https://github.com/samtay/tetris#readme";
  license = lib.licenses.bsd3;
  mainProgram = "tetris";
}
