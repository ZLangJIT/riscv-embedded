PKGS="qemu-utils which radare2 unicorn unicorn-emu valgrind clang_18 clang-tools_18 llvm-manpages clang-manpages radare2-cutter coreutils-full man-db man-pages man-pages-posix nano pkgsCross.riscv64-embedded.stdenv qemu_full cmake ninja cppreference-doc re2 re2c linenoise gitFull git-credential-oauth procps ps tree-sitter github-cli git-hub nanorc bash-completion"
if [[ ! -e ~/.verified_packages ]] ; then
	mkdir ~/.verified_packages
fi
echo "verifying packages..."
for pkg in $PKGS ; do
	if [[ ! -e ~/.verified_packages/$pkg ]] ; then
		echo "verifying and installing package: $pkg"
		nix-shell --command "exit 0" -p $pkg || exit 1
		touch ~/.verified_packages/$pkg
	fi
done
echo "verified all packages"
echo "entering shell layer 1..."
nix-shell -p $PKGS
echo "exiting shell layer 1"
#echo "collecting garbage..."
#nix-collect-garbage --quiet
echo "exited shell layer 1"
