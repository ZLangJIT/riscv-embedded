PKGS="nix-info rvvm spike dtc qemu-utils which radare2 unicorn unicorn-emu valgrind clang_18 clang-tools_18 llvm-manpages clang-manpages radare2-cutter coreutils-full man-db man-pages man-pages-posix nano gcc qemu_full cmake ninja cppreference-doc re2 re2c linenoise gitFull git-credential-oauth procps ps tree-sitter github-cli git-hub nanorc bash-completion"
if [[ ! -e profile.sh ]] ; then
	echo "please execute me from repository root"
	exit 1
fi
if [[ ! -e ~/.verified_packages ]] ; then
	mkdir ~/.verified_packages
fi
echo "verifying packages..."
rm ~/.verified_packages/nixos_documentation
if [[ ! -e ~/.verified_packages/nixos_documentation ]] ; then
	echo "verifying and installing package: nixos documentation"
        echo "generating temporary configuration..."
        nix-shell -p nixos-install-tools --command "rm -rf tmp_etc ; nixos-generate-config --dir tmp_etc --no-filesystems 2>/dev/null || true"
        echo "installing documentation..."
	nix-shell -I "nixos-config=$(pwd)/tmp_etc/configuration.nix" '<nixpkgs/nixos>' '<nixpkgs/nixos/doc/manual>' || exit 1
        rm -rf tmp_etc
	touch ~/.verified_packages/nixos_documentation
fi
for pkg in $PKGS ; do
	if [[ ! -e ~/.verified_packages/$pkg ]] ; then
		echo "verifying and installing package: $pkg"
		nix-shell --command "exit 0" -p $pkg || exit 1
		touch ~/.verified_packages/$pkg
	fi
done
echo "verified all packages"
echo "entering shell..."
nix-shell --command ". profile.sh ; return" -p $PKGS
echo "exiting shell layer 1"
#echo "collecting garbage..."
#nix-collect-garbage --quiet
echo "exited shell layer 1"
