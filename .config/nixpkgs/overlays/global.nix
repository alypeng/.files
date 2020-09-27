self: super:

let
  myBasePackages = with self; [
    aspell
    aspellDicts.en
    direnv
    fish-foreign-env
    git
    hack-font
    hadolint
    html-tidy
    myPythonPackages
    nixfmt
    nodePackages.prettier
    nodejs
    ocamlformat
    postgresql
    proselint
    pry
    ripgrep
    rubocop
    ruby
    shellcheck
    shfmt
    sqlint
  ];

  myLinuxPackages = with self; [ cask mitscheme strace ];

  myPythonPackages = super.python38.withPackages
    (ps: with ps; [ black flake8 setuptools sqlparse ]);
in {
  myPackages = super.buildEnv {
    name = "my-packages";
    paths = myBasePackages
      ++ (if super.stdenv.isLinux then myLinuxPackages else [ ]);
    pathsToLink = [ "/bin" "/lib" "/share" ];
  };
}
