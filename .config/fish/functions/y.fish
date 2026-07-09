function y
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    yazi $argv --cwd-file="$tmp"

    set cwd (cat "$tmp")
    if test -n "$cwd"; and test "$cwd" != "$PWD"
        cd "$cwd"
    end

    rm -f "$tmp"
end
