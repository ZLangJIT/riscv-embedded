set -e -o pipefail

cd riscv-pk
nix-build --out-link ../store_pk \
-E "(import <nixpkgs> {}).pkgsCross.riscv64-embedded.callPackage ./. {pwd = \"$(pwd)\";}"
echo "running spike ..."
spike ../store_pk/bin/riscv-pk
