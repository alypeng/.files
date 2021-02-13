function upgrade_everything
    if test (uname) = "Darwin"
        brew update
        brew upgrade

        brew cleanup -s
    else
        sudo dnf --refresh upgrade
        sudo dnf --refresh autoremove
    end

    fish_update_completions
end
