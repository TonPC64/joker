function fish_right_prompt
    set -l status_copy $status

    if test $status_copy -ne 0
        segment_right " $status_copy " f00 000
        segment_right "⭑ " 000 f00
        segment_close
    end
end
