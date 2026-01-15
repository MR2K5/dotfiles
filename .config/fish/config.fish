if status is-interactive
    # Commands to run in interactive sessions can go here
    set fish_term24bit 1
    
    bind ctrl-h backward-kill-word
    bind ctrl-delete kill-word
    bind ctrl-space accept-autosuggestion
    bind ctrl-alt-h htop

    set -x LESSPIPE 'lesspipe.sh %s'

end

if status is-login
    fish_add_path ~/.local/bin
end
