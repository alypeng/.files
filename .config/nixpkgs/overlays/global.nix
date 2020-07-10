self: super:

let
  myBasePackages = with self; [
    aspell
    aspellDicts.en
    bzip2
    direnv
    fish-foreign-env
    git
    gnum4
    hack-font
    hadolint
    html-tidy
    myPythonPackages
    myRubyPackages
    nixfmt
    nodePackages.prettier
    nodejs
    ocamlformat
    opam
    pipenv
    proselint
    ripgrep
    shellcheck
    shfmt
  ];

  myLinuxPackages = with self; [ cask mitscheme strace ];

  myPythonPackages =
    super.python38.withPackages (ps: with ps; [ black flake8 setuptools ]);

  myRubyPackages = super.ruby.withPackages (ps: with ps; [ pry rubocop ]);
in {
  myPackages = super.buildEnv {
    name = "my-packages";
    paths = myBasePackages
      ++ (if super.stdenv.isLinux then myLinuxPackages else [ ]);
    pathsToLink = [ "/bin" "/lib" "/share" ];
  };
}
