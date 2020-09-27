self: super:

with import (super.fetchFromGitHub {
  owner = "nixos";
  repo = "nixpkgs";
  rev = "72b9660dc18ba347f7cd41a9504fc181a6d87dc3";
  sha256 = "1cqgpw263bz261bgz34j6hiawi4hi6smwp6981yz375fx0g6kmss";
}) { };
let
  sqlparse = with python3; pkgs.toPythonApplication pkgs.sqlparse;

  my-base-packages = [
    aspell
    aspellDicts.en
    direnv
    fish-foreign-env
    git
    hack-font
    hadolint
    html-tidy
    nixfmt
    nodePackages.prettier
    nodejs
    postgresql
    proselint
    ripgrep
    shellcheck
    shfmt
    sqlint
    sqlparse
  ];

  my-ocaml-packages = [
    ocaml
    ocamlPackages.core
    ocamlPackages.dune_2
    ocamlPackages.findlib
    ocamlPackages.merlin
    ocamlPackages.utop
    ocamlformat
  ];

  my-python-packages =
    [ (python3.withPackages (ps: with ps; [ black flake8 setuptools ])) ];

  my-ruby-packages = [
    ruby
    rubyPackages.pry
    rubyPackages.pry-doc
    rubyPackages.rspec
    rubyPackages.rubocop
  ];

  my-scheme-packages = [ mitscheme ];
in {
  my-base-env = super.buildEnv {
    name = "my-base-env";
    paths = my-base-packages ++ my-python-packages;
    pathsToLink = [ "/bin" "/lib" "/share" ];
  };

  inherit my-ocaml-packages;
  inherit my-ruby-packages;
  inherit my-scheme-packages;
}
