{ stdenv, fetchgit, cmake, autoreconfHook, libxml2, qmp, qio, qla }:

stdenv.mkDerivation rec {
  pname = "qdp++";
  version = "0.1.0";
  src = fetchgit {
    url = "https://github.com/usqcd-software/qdpxx.git";
    rev = "d82326162166849cf208b6d82338a549fff0a194";
    sha256 = "0svc5029vflc8r69zk226g3p6amfpn695xb51p3zan5178y5q6pi";
  };

  nativeBuildInputs = [
    autoreconfHook
  ];

  buildInputs = [
    libxml2
    qmp
    qio
    qla
  ];

  configureFlags = [
    "--enable-parallel-arch=scalar"
    "--with-qmp=${qmp.out}"
    "--with-qio=${qio.out}"
    "--with-qla=${qla.out}"
  ];
}
