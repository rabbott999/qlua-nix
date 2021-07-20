{ stdenv, fetchgit, cmake, autoreconfHook, perl }:

stdenv.mkDerivation rec {
  pname = "qla";
  version = "1.9.0";
  src = fetchgit {
    url = "https://github.com/usqcd-software/qla.git";
    rev = "eaffb9220793ec5048150d6abba940a96be3c006";
    sha256 = "18hdibnf6n5y77fh4yhh6bscnv1m9i97xp68c12zkfjc05amcavg";
  };

  nativeBuildInputs = [
    perl
    autoreconfHook
  ];
}
