if status is-login
    switch (uname)
        case Darwin
            set -x PATH /usr/local/bin /usr/bin /bin /usr/local/sbin /usr/sbin /sbin

            set -x ASPELL_CONF "data-dir $HOME/.nix-profile/lib/aspell"

        case Linux
            set -x PATH /usr/local/bin /usr/bin /usr/local/sbin /usr/sbin
    end

    set fish_function_path $fish_function_path \
        "$HOME"/.nix-profile/share/fish-foreign-env/functions

    fenv source "$HOME"/.nix-profile/etc/profile.d/nix.sh

    set -x PATH "$HOME"/.files/bin $PATH

    set -x EDITOR vim
    set -x LESSHISTFILE /dev/null

    set -x LEIN_HOME "$HOME"/.config/lein

    if test -z "$DISPLAY" -a "$XDG_VTNR" = 1
        exec startx
    end
end

direnv hook fish | source

solarized_light
