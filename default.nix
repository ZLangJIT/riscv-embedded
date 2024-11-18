let
  pkgs = import nixpkgs {};
  pk = import "./riscv-pc/default.nix"
  crossCompileFor = hostPkgs:
    hostPkgs.runCommandCC "hello-world-cross-test" {} ''
      HOME=$PWD
      $CC ${helloWorld} -o hello
      ${hostPkgs.stdenv.hostPlatform.emulator hostPkgs.buildPackages} hello > $out
      cat $out
    '';
in {
  rpi = crossCompileFor pkgs.pkgsCross.riscv64-embedded;
  windows = crossCompileFor pkgs.pkgsCross.mingwW64;
}
