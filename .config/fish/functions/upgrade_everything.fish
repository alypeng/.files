function upgrade_everything
    brew update

    if test (uname) = "Darwin"
        brew cask upgrade
    else
        sudo dnf --refresh upgrade
        sudo dnf --refresh autoremove
    end

    brew upgrade
    brew cleanup -s

    npm upgrade --global

    fish_update_completions
end
