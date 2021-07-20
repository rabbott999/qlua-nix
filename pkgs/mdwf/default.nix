{ stdenv, fetchgit, cmake, autoreconfHook, qa0, qmp, gsl, target }:

stdenv.mkDerivation rec {
  pname = "mdwf";
  version = "0.1.0";
  src = fetchgit {
    url = "https://usqcd.lns.mit.edu/git/LHPC/Public/mdwf.git";
    rev = "fc4f2faa9d3ce00cdc254b20bfcbb136d989fdf4";
    sha256 = "1aj2ms4j9jh3xw1kw0x6wvq30v38rz3czl9nhl22k5d1kkmm087w";
  };

  buildInputs = [ gsl ];

  configureFlags = [
    "--target=${target}"
    "--with-qmp=${qmp.out}"
    "--with-gsl=${gsl.out}"
  ];

  preBuild = ''
    make -C qa0 QA0=${qa0.out}/qa0 TARGETS="${target}"
    cp nc/qop-mdwf3.h port/.
  '';
}
