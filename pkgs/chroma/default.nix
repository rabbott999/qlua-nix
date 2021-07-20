{ stdenv, fetchgit, cmake, qmp, qdpxx, zlib, autoreconfHook }:

stdenv.mkDerivation rec {
  pname = "chroma";
  version = "0.1.0";
  src = fetchgit {
    url = "https://github.com/JeffersonLab/chroma.git";
    rev = "f3adf17def1925076289ff9099ad59264498c138";
    sha256 = "10jkycda1kycb4y78wlx3djjpxzn1sq9amyimb9gzqnj8g1cb4sd";
  };

  nativeBuildInputs = [
    autoreconfHook
  ];

  buildInputs = [
    qmp
    qdpxx
    zlib
  ];

  configureFlags = [
    "--with-qmp=${qmp.out}"
    "--with-qdp=${qdpxx.out}"
  ];
}
