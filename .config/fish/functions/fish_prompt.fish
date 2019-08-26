function fish_prompt
    set -l branch (git rev-parse --abbrev-ref HEAD 2>/dev/null)

    echo
    echo -ns '🐧'
    echo -ns ' '
    echo -ns (set_color $fish_color_cwd) (prompt_pwd)
    echo -ns ' '
    echo -ns (set_color $fish_color_quote) $branch

    echo
    echo -ns (set_color magenta) '->'
    echo -ns ' '
    echo -ns (set_color normal)
end
