{ stdenv, fetchgit, cmake, autoreconfHook, lua, qdp, aff, hdf5, qopqdp, arpack, mdwf, clover, Nc, twisted, gsl, zlib, mpi, gfortran }:

stdenv.mkDerivation rec {
  pname = "qlua";
  version = "0.1.0";
  src = fetchgit {
    url = "https://usqcd.lns.mit.edu/git/LHPC/Public/qlua.git";
    rev = "f283ceadadca216968bfceb2318d674699e6b9f6";
    sha256 = "0j905pa8zk7vmrkijkdlyj1dc30pdlla8agid0na5rrcahald2br";
  };

  #patches = [ ./ld-no-copts.patch ];

  hardeningDisable = [ "format" ];

  buildInputs = [
    gfortran
    lua
    arpack
    gsl
    zlib
    mpi
    hdf5
  ];

  preConfigure = ''
    export LDFLAGS="-L${arpack.out}/lib"
    export LIBS="$LIBS -lparpack -larpack -lc -ldl -lmpi"
    export CC=${mpi.out}/bin/mpicc
    export FC=${mpi.out}/bin/mpif77
    export LD=$FC
  '';

  configureFlags = [
    "--with-lua=${lua.out}"
    "--with-qdp=${qdp.out}"
    "--with-lhpc-aff=${aff.out}"
    "--with-hdf5=${hdf5.out}"
    "--with-qopqdp=${qopqdp.out}"
    #"--with-arpack="
    "--with-mdwf=${mdwf.out}"
    "--with-clover=${clover.out}"
    "--clover-nc=${Nc}"
    "--with-twisted=${twisted.out}"
    "--twisted-nc=${Nc}"
    "--with-gsl=${gsl.out}"
    "--with-extras"
  ];

  parallelBuild = true;
}
