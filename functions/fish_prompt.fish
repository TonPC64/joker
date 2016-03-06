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
            segment " $base " 000 ffd300
    end

    set branch_name
    if set branch_name (git_branch_name)
        set -l color ffefc7 4349aa
        set -l repo_status
        set -l branch_ref ➦

        if git symbolic-ref HEAD ^ /dev/null > /dev/null
            set branch_ref 
        end

        if git_is_touched
            set color 403d7c ffefc7
            if git_is_staged
                set repo_status "✚ "
            end

            if git_is_dirty
                set repo_status "⭑ "
            end
        end

        segment " $branch_ref $branch_name $repo_status" $color
    end

    set -l dir (dirname $cwd | sed -E 's|(^/)?([^/.])[^/]*|\2|g')
    switch "$dir"
        case "" / .
        case \*
            segment " $dir " 403d7c ffefc7
    end

    segment " $root " 000 0fe169

    segment_close
end
