{ stdenv, fetchgit, cmake, autoreconfHook, libxml2, qmp, qio, qla, perl }:

stdenv.mkDerivation rec {
  pname = "qdp";
  version = "0.1.0";
  src = fetchgit {
    url = "https://github.com/usqcd-software/qdp.git";
    rev = "a26957d55f96f6053e3e202a7465e55071eb9f5b";
    sha256 = "0n3vbdkspr7d4k5hbl4j98klydn05ijkmc5dwhj0vpvynk3xs1k2";
  };

  nativeBuildInputs = [
    autoreconfHook
    perl
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
