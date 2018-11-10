with import <nixpkgs> {};

let
  oldpkgs = import (fetchTarball
    "https://github.com/NixOS/nixpkgs-channels/archive/nixos-18.09.tar.gz") {};
in

stdenv.mkDerivation {
  name = "verified-functional-programming-in-agda-environment";

  buildInputs = [
    oldpkgs.haskellPackages.Agda # this is 2.5.4.2
    pkgs.emacs # latest emacs
  ];

  shellHook = ''
    # download library compatible with Agda 2.5 if not present already
    if [ ! -d "ial-1.5.0" ]; then
      wget "https://github.com/cedille/ial/archive/v1.5.0.zip"
      unzip v1.5.0.zip
    fi
    # setup emacs
    echo "(load-file (let ((coding-system-for-read 'utf-8)) (shell-command-to-string \"agda-mode locate\")))" > /tmp/load-agda2.el
    # start Emacs at the library readme.
    emacs -l /tmp/load-agda2.el ./ial-1.5.0/README.txt
  '';
}
