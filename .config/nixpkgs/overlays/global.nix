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
    myRubyPackages
    nixfmt
    nodePackages.prettier
    nodejs
    pipenv
    proselint
    ripgrep
    shellcheck
    shfmt
  ];

  myLinuxPackages = with self; [ mitscheme strace ];

  myPythonPackages =
    super.python37.withPackages (ps: with ps; [ black flake8 ]);

  myRubyPackages = super.ruby.withPackages (ps: with ps; [ pry rubocop ]);
in {
  myPackages = super.buildEnv {
    name = "my-packages";
    paths = myBasePackages
      ++ (if super.stdenv.isLinux then myLinuxPackages else [ ]);
    pathsToLink = [ "/bin" "/lib" "/share" ];
  };
}
