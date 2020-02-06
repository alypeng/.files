function install_everything
    brew update

    if test (uname) = "Darwin"
        brew cask install docker
        brew cask install emacs
        brew cask install firefox

        brew cask install homebrew/cask-fonts/font-hack
    else
        sudo dnf check-update

        sudo dnf group install base-x

        sudo dnf install alsa-plugins-pulseaudio
        sudo dnf install emacs
        sudo dnf install firefox
        sudo dnf install i3
        sudo dnf install redshift

        sudo chown -R $USER:$USER ~/.cache

        dotconfig gtk-3.0
        dotconfig i3

        ln -fs ~/.files/.local/share/fonts ~/.local/share

        dotfile .Xresources
        dotfile .xinitrc
    end

    brew tap heroku/brew

    brew install aspell
    brew install direnv
    brew install git
    brew install hadolint
    brew install heroku
    brew install prettier
    brew install python
    brew install ripgrep
    brew install ruby
    brew install shellcheck
    brew install shfmt
    brew install tidy-html5

    gem install mdl
    gem install rubocop

    npm install --global stylelint
    npm install --global stylelint-config-recommended-scss
    npm install --global stylelint-scss

    python -m pip install black
    python -m pip install flake8
    python -m pip install pipenv
    python -m pip install proselint

    dotconfig git

    dotfile .aspell.conf
    dotfile .emacs.d
    dotfile .stylelintrc.json
    dotfile .tidyrc.txt
    dotfile bin

    fish_update_completions
end
