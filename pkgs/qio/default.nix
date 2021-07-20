{ stdenv, fetchgit, cmake, qmp, autoreconfHook }:

stdenv.mkDerivation rec {
  pname = "qio";
  version = "0.1.0";
  src = fetchgit {
    url = "https://github.com/usqcd-software/qio.git";
    rev = "939bd2061735822615dba970abee4af65fd1cb0d";
    sha256 = "1ns7daigqlqgdii69bm5gawx87k8ifxzf0hkg2pqir4kn3h8wr9g";
  };

  nativeBuildInputs = [
    autoreconfHook
  ];

  configureFlags = [
    "--with-qmp=${qmp.out}"
  ];
}
