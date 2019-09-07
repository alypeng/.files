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

        dotconfig gtk-3.0
        dotconfig i3

        dotfile .Xresources
        dotfile .xinitrc
    end

    brew install git
    brew install prettier
    brew install ripgrep
    brew install shfmt

    brew install php
    brew install php@7.2

    brew install composer
    brew install php-code-sniffer
    brew install php-cs-fixer
    brew install phpstan

    brew install python

    brew install black
    brew install flake8
    brew install mypy
    brew install pipenv

    npm install --global intelephense

    dotconfig git

    dotfile .aspell.conf
    dotfile .emacs.d
    dotfile phpstan.neon

    fish_update_completions
end
