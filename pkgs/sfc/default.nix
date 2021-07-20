{ stdenv, fetchgit, cmake, autoreconfHook }:

stdenv.mkDerivation rec {
  pname = "sfc";
  version = "0.1.0";
  src = fetchgit {
    url = "https://usqcd.lns.mit.edu/git/Users/avp/languages/sharpF.git";
    rev = "2cfccb6d9a07e53662e2478c20853dfb2342641c";
    sha256 = "1crjpmcx5dhmryf7w7pgf6cf32aycci368g5jk2q6b016dj18f1y";
  };

  dontConfigure = true;

  buildPhase = '' $CC -o sfc fixpoint/*.c '';
  installPhase = ''
    mkdir -p $out
    mv sfc $out/sfc
  '';
}
