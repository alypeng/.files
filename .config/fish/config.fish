switch (uname)
    case Darwin
        set -x PATH /usr/local/bin /usr/bin /bin /usr/local/sbin /usr/sbin /sbin

        set -x ASPELL_CONF "data-dir $HOME/.nix-profile/lib/aspell"

    case Linux
        set -x PATH /usr/local/bin /usr/bin /usr/local/sbin /usr/sbin

        set -x TERM xterm-256color
end

set fish_function_path $fish_function_path \
    "$HOME"/.nix-profile/share/fish-foreign-env/functions

fenv source "$HOME"/.nix-profile/etc/profile.d/nix.sh

set -x PATH "$HOME"/bin "$HOME"/.npm/bin $PATH

set -x LESSHISTFILE /dev/null

direnv hook fish | source

solarized_light

if status is-login
    if test -z "$DISPLAY" -a "$XDG_VTNR" = 1
        exec startx
    end
end
