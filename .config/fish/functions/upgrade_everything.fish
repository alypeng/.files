function upgrade_everything
    brew update

    if test (uname) = "Darwin"
        brew cask upgrade
    else
        sudo apt update

        sudo apt upgrade
        sudo apt autoremove
    end

    brew upgrade
    brew cleanup -s

    npm upgrade --global

    fish_update_completions
end
