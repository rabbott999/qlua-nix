{ stdenv, fetchgit, cmake, autoreconfHook, sfc }:

stdenv.mkDerivation rec {
  pname = "qa0";
  version = "0.1.0";
  src = fetchgit {
    url = "https://usqcd.lns.mit.edu/git/LHPC/Public/qa0.git";
    rev = "e147c66f9a404a692bcefcf5b3a9328833728ab9";
    sha256 = "1qw9867k635fc9frrq9dd63ms2wi4n9k1nbs3y8kjwhkzcww6cid";
  };

  dontConfigure = true;

  buildPhase = ''
    make -C scheme SFC=${sfc.out}/sfc prefix=$out
    make SFC=${sfc.out}/sfc prefix=$out
  '';

  installPhase = ''
    mkdir -p $out
    mv bootstrap/qa0 $out/qa0
  '';
}
