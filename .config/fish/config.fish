if status is-interactive
    # Commands to run in interactive sessions can go here
    bind \b backward-kill-word
    bind \e\[3\;5~ kill-word
    bind  -k nul accept-autosuggestion

    abbr -a sctl systemctl
    abbr -a --set-cursor sysd systemd%
end
