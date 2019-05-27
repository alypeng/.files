function ll
    function _ll
        set -lx LC_COLLATE C
        ls -aFhl --color=auto $argv
        or ls -aFGhl $argv
    end

    _ll $argv 2>/dev/null
end
