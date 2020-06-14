self: super:

{
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
      mitscheme
      nixfmt
      nodePackages.prettier
      nodejs
      pipenv
      proselint
      ripgrep
      shellcheck
      shfmt
    ];
    pathsToLink = [ "/bin" "/lib" "/share" ];
  };

  myPythonPackages =
    super.python37.withPackages (ps: with ps; [ black flake8 ]);

  myRubyPackages = super.ruby.withPackages (ps: with ps; [ pry rubocop ]);
}
