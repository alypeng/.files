if status is-login
    switch (uname)
        case Darwin
            set -x PATH /usr/local/bin /usr/bin /bin /usr/local/sbin /usr/sbin /sbin

            set -x ASPELL_CONF "data-dir $HOME/.nix-profile/lib/aspell"

        case Linux
            set -x PATH /usr/local/bin /usr/bin /usr/local/sbin /usr/sbin

            set -x TERMINAL urxvt-ml
    end

    set fish_function_path $fish_function_path \
        "$HOME"/.nix-profile/share/fish-foreign-env/functions

    fenv source "$HOME"/.nix-profile/etc/profile.d/nix.sh

    source "$HOME"/.opam/opam-init/init.fish

    set -x PATH "$HOME"/bin "$HOME"/.npm/bin $PATH

    set -x EDITOR vi
    set -x LESSHISTFILE /dev/null

    set -x BUNDLE_PATH vendor/bundle
    set -x NODE_PATH "$HOME"/.npm/lib/node_modules

    if test -z "$DISPLAY" -a "$XDG_VTNR" = 1
        exec startx
    end
end

direnv hook fish | source

solarized_light
