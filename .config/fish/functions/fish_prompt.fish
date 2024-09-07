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

printf "%s%s %s%s %s%s %sjobs%s, %stty %s%s %s- %s%s%s@%s%s%s:%s%s\n" (set_color $status_color) $last_pipestatus (set_color yellow) (date +%H:%I:%S) \
 (set_color brgreen) (jobs | wc -l) \
(set_color $grey) (set_color white) (set_color $grey) (set_color cyan) (tty | string split / | tail -1) \
(set_color red) (set_color -o brblue) (whoami) (echo -n (set_color normal)(set_color white)) (set_color -o bryellow) (hostnamectl hostname) (echo (set_color normal)(set_color white)) \
 (set_color red) (pwd | string replace $HOME \~)
printf "%s(%s%s%s) %s " (set_color white) (set_color magenta) (ip route get 9.9.9.9 2> /dev/null | string match -rg "src (\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3})"; or echo) (set_color white) $prompt
end
