switch (uname)
    case Darwin
        set -x PATH /usr/local/bin /usr/bin /bin /usr/local/sbin /usr/sbin /sbin

        set -x PATH /usr/local/opt/php@7.2/sbin $PATH
        set -x PATH /usr/local/opt/php@7.2/bin $PATH

        set -x PATH /usr/local/opt/python/libexec/bin $PATH

    case Linux
        set -x PATH /usr/local/bin /usr/bin /usr/local/sbin /usr/sbin

        set -x PATH /home/linuxbrew/.linuxbrew/sbin $PATH
        set -x PATH /home/linuxbrew/.linuxbrew/bin $PATH

        set -x PATH /home/linuxbrew/.linuxbrew/opt/php@7.2/sbin $PATH
        set -x PATH /home/linuxbrew/.linuxbrew/opt/php@7.2/bin $PATH

        set -x PATH /home/linuxbrew/.linuxbrew/opt/python/libexec/bin $PATH

        set -x TERM xterm-256color
end

solarized_light

if status is-login
    if test -z "$DISPLAY" -a "$XDG_VTNR" = 1
        exec startx
    end
end
