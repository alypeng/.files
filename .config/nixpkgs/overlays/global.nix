self: super:

let
  rubyPackages = import (fetchTarball
    "https://github.com/nixos/nixpkgs/archive/ab931c607b3c351c2bbd8a1ad9a30b75a51d5e50.tar.gz")
    { };
in {
  myPackages = super.buildEnv {
    name = "my-packages";
    paths = with self; [
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
      pipenv
      proselint
      ripgrep
      ruby
      rubyPackages.mdl
      rubyPackages.rubocop
      shellcheck
      shfmt
    ];
    pathsToLink = [ "/bin" "/lib" "/share" ];
  };

  myPythonPackages =
    super.python37.withPackages (ps: with ps; [ black flake8 ]);
}
