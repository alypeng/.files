function upgrade_everything
    if test (uname) = "Darwin"
        brew update
        brew upgrade

        brew cleanup -s
    else
        sudo dnf --refresh upgrade
        sudo dnf --refresh autoremove
    end

    nix-env --install --attr nixpkgs.my-base-env

    nix-env --delete-generations 14d
    nix-store --gc

    fish_update_completions
end
