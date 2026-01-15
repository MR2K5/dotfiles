function fish_right_prompt --description 'Write signal to the right'
    set num $status
    if expr $num \> 128 &>/dev/null
        printf "%s(SIG%s)%s" (set_color -o red) (kill -l $num) (set_color normal)
    end
end
