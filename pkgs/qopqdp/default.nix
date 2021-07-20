{ stdenv, fetchgit, cmake, qmp, qdp, qio, qla, autoreconfHook }:

stdenv.mkDerivation rec {
  pname = "qopqdp";
  version = "0.1.0";
  src = fetchgit {
    url = "https://github.com/usqcd-software/qopqdp.git";
    rev = "a6a83974680e60d9112f958033a0631dd5f52f99";
    sha256 = "01jb9gmv0hm2s4xk747gjfc91vzch3w4s3a6hv2ik58339v0d48m";
  };

  nativeBuildInputs = [
    autoreconfHook
  ];

  buildInputs = [
    qmp
    qio
    qla
    qdp
  ];

  configureFlags = [
    "--with-qmp=${qmp.out}"
    "--with-qio=${qio.out}"
    "--with-qla=${qla.out}"
    "--with-qdp=${qdp.out}"
  ];
}
