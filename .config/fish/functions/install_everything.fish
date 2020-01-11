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

    brew install aspell
    brew install git
    brew install prettier
    brew install ripgrep
    brew install shfmt

    brew install python

    brew install black
    brew install mypy
    brew install pipenv

    python -m pip install flake8

    dotconfig git

    dotfile .aspell.conf
    dotfile .emacs.d

    fish_update_completions
end
