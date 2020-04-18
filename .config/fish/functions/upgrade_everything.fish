function upgrade_everything
    brew update
    brew upgrade

    if test (uname) = "Darwin"
        brew cask upgrade
    else
        brew link --overwrite ruby

        sudo dnf --refresh upgrade
        sudo dnf --refresh autoremove
    end

    brew cleanup -s

    gem install bundler

    set -lx BUNDLE_GEMFILE ~/.files/Gemfile
    bundle update --all

    npm upgrade --global

    python -m pip install --upgrade black
    python -m pip install --upgrade flake8
    python -m pip install --upgrade pipenv
    python -m pip install --upgrade proselint

    fish_update_completions
end
