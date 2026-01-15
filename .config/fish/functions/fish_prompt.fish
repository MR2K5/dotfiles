function fish_prompt
    set last_pipestatus $status
    
    set grey 707070
    
    if test $last_pipestatus -eq 0
        set status_color green
    else
        set status_color red
    end
    
    if fish_is_root_user
        set prompt $(set_color yellow)\#
    else
        set prompt $(set_color white)\$
    end

    if test -n "$SSH_TTY"
        set hostname_color (set_color -ro bryellow)
    else
        set hostname_color (set_color -o bryellow)
    end

    # Status code
    printf "%s%s " (set_color $status_color) $last_pipestatus
    # Time
    printf "%s%s " (set_color yellow) (date +%H:%M:%S)
    # Jobs
    printf "%s%s%s jobs%s, " (set_color brgreen) (jobs | wc -l) (set_color $grey) (set_color white)
    # tty
    printf "%stty %s%s %s- " (set_color $grey) (set_color cyan) (tty | string split / | tail -1) (set_color red)
    # Host
    printf "%s%s%s%s@" (set_color -o brblue) (whoami) (set_color normal) (set_color white)
    printf "%s%s%s%s:" $hostname_color (hostnamectl hostname) (set_color normal) (set_color white)
    # CWD
    printf "%s%s " (set_color red) (pwd | string replace $HOME \~)
    # git
    printf "%s%s" (set_color normal) (fish_git_prompt)

    printf "\n"
    
    # Second line
    set ip (ip route get 9.9.9.9 2> /dev/null | string match -rg "src (\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3})"; or echo)
    printf "%s(%s%s%s) %s " (set_color white) (set_color magenta) $ip (set_color white) $prompt
end
