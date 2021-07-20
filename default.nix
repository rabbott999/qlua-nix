{
  pkgs ? import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/b2f87e0043aaf3f0f05cc983bd6aa80a616b8352.tar.gz") {}
}:

with pkgs;

# fetchgit-noverify will fetch a git repo without verifying the SSL
# certificate. This is necessary for the git repos hosted at
# usqcd.lns.mit.edu since they do not have valid SSL certificates
let
  fetchgit-no-verify = fetchgit // {
    __functor = self : args :
      (fetchgit.__functor self args).overrideAttrs (oldAttrs:{GIT_SSL_NO_VERIFY=true;});
  };

  packages = rec {
    qmp = callPackage ./pkgs/qmp {};
    qio = callPackage ./pkgs/qio { qmp = qmp; };
    qla = callPackage ./pkgs/qla {};
    qdp = callPackage ./pkgs/qdp { qmp = qmp; qio = qio; qla = qla; };
    qdpxx = callPackage ./pkgs/qdpxx { qmp = qmp; qio = qio; qla = qla; };
    qopqdp = callPackage ./pkgs/qopqdp { qmp = qmp; qdp = qdp; qio = qio; qla = qla; };
    chroma = callPackage ./pkgs/chroma { qmp = qmp; qdpxx = qdpxx; };

    mpi = callPackage ./pkgs/openmpi {};
    gsl = callPackage ./pkgs/gsl { fetchgit = fetchgit-no-verify; };
    arpack = callPackage ./pkgs/arpack { fetchgit = fetchgit-no-verify; mpi = mpi; };
    hdf5 = callPackage ./pkgs/hdf5 { fetchgit = fetchgit-no-verify; mpi = mpi; };

    aff = callPackage ./pkgs/aff { fetchgit = fetchgit-no-verify; };
    sfc = callPackage ./pkgs/sfc { fetchgit = fetchgit-no-verify; };
    qa0 = callPackage ./pkgs/qa0 { fetchgit = fetchgit-no-verify; sfc = sfc; };
    clover = callPackage ./pkgs/clover { fetchgit = fetchgit-no-verify;  qa0 = qa0; qmp = qmp; qdp = qdp; Nc = "3"; target = "cee-64"; gsl = gsl; };
    twisted = callPackage ./pkgs/twisted { fetchgit = fetchgit-no-verify;  qa0 = qa0; qmp = qmp; qdp = qdp; Nc = "3"; target = "cee-64"; gsl = gsl; };
    mdwf = callPackage ./pkgs/mdwf { fetchgit = fetchgit-no-verify;  qa0 = qa0; qmp = qmp; target = "cee-64"; gsl = gsl; };

    qlua = callPackage ./pkgs/qlua {
      fetchgit = fetchgit-no-verify;
      qdp = qdp;
      aff = aff;
      qopqdp = qopqdp;
      mdwf = mdwf;
      clover = clover;
      Nc = "3";
      twisted = twisted;
      lua = lua51Packages.lua;
      mpi = mpi;
      hdf5 = hdf5;
      arpack = arpack;
      gsl = gsl;
    };

    qluaEnv = mkShell rec {
      name = "qluaEnv";
      buildInputs = [
        qlua
        chroma
      ];
    };

    inherit pkgs;
  };
in
packages
