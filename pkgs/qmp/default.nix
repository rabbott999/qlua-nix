{ stdenv, fetchgit, cmake, autoreconfHook }:

stdenv.mkDerivation rec {
  pname = "qmp";
  version = "0.1.0";
  src = fetchgit {
    url = "https://github.com/usqcd-software/qmp.git";
    rev = "0b8fc9db23f3cb5d8335a63592aa9586af13de02";
    sha256 = "1sif104c22zpwl53wqcgqaw98b562vgp81xqarl4dlb8mq3pizj7";
  };

  nativeBuildInputs= [
    autoreconfHook
  ];
}
