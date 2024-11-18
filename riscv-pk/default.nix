{stdenv, lib, autoreconfHook, pwd, dtc}: let
in
stdenv.mkDerivation {
  name = "riscv-embedded-riscv-pk";

  src = "${pwd}";

  nativeBuildInputs = [ autoreconfHook dtc ];

  preConfigure = ''
    mkdir build
    cd build
  '';

  configureScript = "../configure";

  configureFlags = [ "--enable-print-device-tree" ];

  hardeningDisable = [ "all" ];

  meta = {
    description = "RISC-V Proxy Kernel and Bootloader.";
    homepage = https://github.com/ZLangJIT/riscv-embedded/riscv-pk;
    license = lib.licenses.bsd3;
    maintainers = [ "ZLangJIT" ];
  };
}
