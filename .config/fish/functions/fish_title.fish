function fish_title
echo -n (whoami)@(hostnamectl hostname):(pwd |string replace $HOME \~)
end
