if status is-interactive
    # Commands to run in interactive sessions can go here
    set fish_term24bit 1
    
    bind \b backward-kill-word
    bind \e\[3\;5~ kill-word
    bind  -k nul accept-autosuggestion

    set -x LESSPIPE 'lesspipe.sh %s'
    set --path -x PERL5LIB /usr/local/lib/perl5/*/{site_perl,core_perl} /usr/local/share/perl5/site_perl
    set -ax PATH /usr/local/bin/site_perl/

end

if status is-login
    fish_add_path ~/.local/bin
end
