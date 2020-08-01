function fish_prompt
    echo
    echo -ns (set_color $fish_color_cwd) (prompt_pwd)
    echo -ns ' '
    echo -ns (set_color magenta) '->'
    echo -ns ' '
    echo -ns (set_color normal)
end
