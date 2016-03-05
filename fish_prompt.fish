function fish_prompt
    set -l status_copy $status
    set -l cwd
    set -l root "/"

    switch "$PWD"
        case "$HOME"\*
            set root "~"
    end

    set cwd (echo "$PWD" | sed -E "s|$HOME/?||")

    set -l base (basename $cwd)
    switch "$cwd"
        case "" /
        case \*
            segment " $base " white 222
    end

    set branch_name
    if set branch_name (git_branch_name)
        set -l color white 5000CD
        set -l char

        if git_is_touched
            set color black yellow
            if git_is_staged
                set char "✚ "
            end

            if git_is_dirty
                set char "⭑ "
            end
        end

        segment "  $branch_name $char" $color
    end

    set -l dir (dirname $cwd | sed -E 's|(^/)?([^/.])[^/]*|\2|g')
    switch "$dir"
        case "" / .
        case \*
            segment " $dir " black white
    end

    segment " $root " black 2CAB34

    segment_close
end
