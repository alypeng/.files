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

    gem update
    gem cleanup

    npm upgrade --global

    python -m pip install --upgrade black
    python -m pip install --upgrade flake8
    python -m pip install --upgrade pipenv
    python -m pip install --upgrade proselint

    fish_update_completions
end
