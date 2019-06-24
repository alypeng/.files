switch (uname)
    case Darwin
        set -x PATH /usr/local/sbin $PATH

        set -x PATH /usr/local/opt/php@7.2/bin $PATH
        set -x PATH /usr/local/opt/php@7.2/sbin $PATH

        set -x PATH /usr/local/opt/python/libexec/bin $PATH

    case Linux
        set -x PATH /home/linuxbrew/.linuxbrew/bin $PATH
        set -x PATH /home/linuxbrew/.linuxbrew/sbin $PATH

        set -x PATH /home/linuxbrew/.linuxbrew/opt/php@7.2/bin $PATH
        set -x PATH /home/linuxbrew/.linuxbrew/opt/php@7.2/sbin $PATH

        set -x PATH /home/linuxbrew/.linuxbrew/opt/python/libexec/bin $PATH
end

solarized_light