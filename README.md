**Chaotic's dotfiles**
Collection of various config files. Every system should have it's own branch, with the main branch being for common files across all (most) systems

**Installing on a system:**
Add an alias, such as `alias dotfiles='git --git-dir=~/.dotfiles --work-tree=~'`
Clone into a bare repository `git clone --bare <repo-url> ~/.dotfiles`
Finally checkout the actual contents `dotfiles checkout`
The last step may fail if some files exist already. Those should be either removed or backed up
We can also hide untracked files `dotfiles config --local status.showUntrackedFiles no`
Now we should create a branch for our new system
