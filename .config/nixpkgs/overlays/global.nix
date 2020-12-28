self: super:

with import (super.fetchFromGitHub {
  owner = "nixos";
  repo = "nixpkgs";
  rev = "ad13f0e569cad5ec51c3b123b434ce62c8235124";
  sha256 = "0fsc82p05cbvcvz16wp9jqih3vm6w7p0chhg9k3a5nxj04cm7vad";
}) { };
let
  prettier = nodePackages.prettier;
  sqlformat = with python3.pkgs; toPythonApplication sqlparse;

  my-base-packages = [
    aspell
    aspellDicts.en
    direnv
    fish-foreign-env
    git
    hack-font
    hadolint
    html-tidy
    mdl
    nixfmt
    postgresql
    prettier
    ripgrep
    shellcheck
    shfmt
    sqlformat
    sqlint
    vim
    yamllint
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
