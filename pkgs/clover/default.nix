{ stdenv, fetchgit, cmake, autoreconfHook, qa0, qmp, qdp, gsl, Nc, target }:

stdenv.mkDerivation rec {
  pname = "clover";
  version = "0.1.0";
  src = fetchgit {
    url = "https://usqcd.lns.mit.edu/git/LHPC/Public/clover.git";
    rev = "38d9771add1d3cbf9d1306623cae37f6b7888bbb";
    sha256 = "0h04ryyqzn0wwlp3shx3f9w7pd8g6394plcs6kc4lf8ypmdp95wj";
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
