function upgrade_everything
    if test (uname) = "Darwin"
        brew update
        brew upgrade

        brew cask upgrade

        brew cleanup -s
    else
        sudo dnf --refresh upgrade
        sudo dnf --refresh autoremove
    end

    nix-channel --update

    nix-env --install --attr nixpkgs.myPackages

    nix-env --delete-generations 14d
    nix-store --gc

    npm upgrade --global

    opam init --no-setup --reinit
    opam upgrade

    fish_update_completions
end
