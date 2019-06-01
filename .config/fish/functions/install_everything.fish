function install_everything
    brew update

    if test (uname) = "Darwin"
        brew cask install docker
        brew cask install emacs
        brew cask install firefox

        brew cask install homebrew/cask-fonts/font-hack
    else
        sudo apt update

        sudo apt install emacs
        sudo apt install firefox
        sudo apt install fonts-hack
    end

    brew install git
    brew install prettier
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

    dotconfig git

    dotfile .emacs.d

    fish_update_completions
end
