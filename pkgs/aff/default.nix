{ stdenv, fetchgit, cmake, autoreconfHook }:

stdenv.mkDerivation rec {
  pname = "aff";
  version = "0.1.0";
  src = fetchgit {
    url = "https://usqcd.lns.mit.edu/git/LHPC/Public/aff.git";
    rev = "4eaef4640d697c3bafe550f53521bb00ff6e0650";
    sha256 = "1j8ma3zwwg7jj9ynbhjin9k2ngb2x7ndvhjzz6ichpz7mrf5xmxx";
  };

  dontBuild = true;

  dontConfigure = true;

  installPhase = ''
    make prefix=$out CONFIG=linux install
  '';
}
