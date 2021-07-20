{ stdenv, fetchgit, cmake, autoreconfHook, qa0, qmp, qdp, gsl, Nc, target }:

stdenv.mkDerivation rec {
  pname = "twisted";
  version = "0.1.0";
  src = fetchgit {
    url = "https://usqcd.lns.mit.edu/git/LHPC/Public/twisted.git";
    rev = "87ec4a302c2c86e0ca811c7a7377006256d3fe98";
    sha256 = "1g9j3lgvi3qpz5q9557yq4n9hbhfdpwhd2vvhjlxhxgaz1mkjmz3";
  };

  buildInputs = [ gsl ];

  configureFlags = [
    "--target=${target}"
    "--with-qmp=${qmp.out}"
    "--with-qdp=${qdp.out}"
    "--with-gsl=${gsl.out}"
  ];

  preConfigure = '' utils/setup-nc ${Nc} '';

  preBuild = '' make -C qa0 NC=${Nc} QA0=${qa0.out}/qa0 TARGETS="${target}" '';
}
