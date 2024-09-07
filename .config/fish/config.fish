if status is-interactive
    # Commands to run in interactive sessions can go here
    set fish_term24bit 1
    
    bind \b backward-kill-word
    bind \e\[3\;5~ kill-word
    bind  -k nul accept-autosuggestion

    abbr -a sctl systemctl
    abbr -a --set-cursor sysd systemd%

end

if status is-login
    fish_add_path ~/.local/bin
end
