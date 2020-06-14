function install_everything
    if test (uname) = "Darwin"
        brew update

        brew cask install \
            docker \
            emacs \
            firefox \
            homebrew/cask-fonts/font-hack
    else
        sudo dnf check-update

        sudo dnf -y group install base-x

        sudo dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-(rpm -E %fedora).noarch.rpm
        sudo dnf install \
            alsa-plugins-pulseaudio \
            emacs \
            ffmpeg-libs \
            firefox \
            i3 \
            redshift

        sudo chown -R $USER:$USER ~/.cache

        dotconfig gtk-3.0
        dotconfig i3
        dotconfig i3status

        ln -fs ~/.nix-profile/share/fonts ~/.local/share

        dotfile .Xmodmap
        dotfile .Xresources
        dotfile .xinitrc
    end

    nix-env --install --attr \
        nixpkgs.myPackages \
        nixpkgs.myPythonPackages \
        nixpkgs.myRubyPackages

    dotfile .npmrc

    npm install -g \
        markdownlint-cli \
        stylelint \
        stylelint-config-recommended-scss \
        stylelint-scss

    mkdir -p ~/projects

    dotconfig git
    dotconfig proselint

    dotfile .aspell.conf
    dotfile .bundle
    dotfile .emacs.d
    dotfile .stylelintrc.json
    dotfile .tidyrc.txt
    dotfile bin

    fish_update_completions
end
