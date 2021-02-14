function install_everything
    if test (uname) = "Darwin"
        brew update

        brew cask install \
            docker \
            emacs \
            firefox

        cp -f ~/.nix-profile/share/fonts/hack/* ~/Library/Fonts
    else
        sudo dnf check-update

        sudo dnf -y group install base-x

        sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-(rpm -E %fedora).noarch.rpm
        sudo dnf install \
            alsa-plugins-pulseaudio \
            dnf-plugin-system-upgrade \
            emacs \
            ffmpeg-libs \
            firefox \
            gdouros-symbola-fonts \
            i3 \
            redshift \
            rxvt-unicode \
            strace \
            zip

        sudo chown -R $USER:$USER ~/.cache

        dotconfig gtk-3.0
        dotconfig i3
        dotconfig i3status

        ln -fs ~/.nix-profile/share/fonts ~/.local/share

        dotfile .Xresources
        dotfile .xinitrc
    end

    nix-env --install --attr nixpkgs.my-base-env

    mkdir -p ~/projects

    dotconfig emacs
    dotconfig fish
    dotconfig git
    dotconfig nixpkgs
    dotconfig pry
    dotconfig utop

    dotfile .aspell.conf
    dotfile .tidyrc
    dotfile .vimrc

    fish_update_completions
end
