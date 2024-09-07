set -l commands add add-all remove inspect list

function get_kernel_versions
    kernel-install --json=short list | string match -rag '"version":"(.+?)"'
end


function ver_seen_after
    set cmd (commandline -co)
    set idx (contains --index $argv[1] $cmd)
    if test (count $cmd) -le $idx
        return 1
    end
    set idx (math $idx + 1)

    return (contains $cmd[$idx] (get_kernel_versions))

end

function image_seen_after
    set cmd (commandline -co)
    set idx (contains --index $argv[1] $cmd)
    if test (count $cmd) -le (math $idx + 1)
        return 1
    end
    set str $cmd[(math $idx + 2)]
    return (test -e $str)
end

function get_image
    set -l cmd (commandline -co)
    set -l dir /usr/lib/modules/$cmd[-1]
    echo $dir/vmlinuz
end


complete -c kernel-install -f

complete -c kernel-install -n "not __fish_seen_subcommand_from $commands" -a add-all -d "Add all installed kernels"
complete -c kernel-install -n "not __fish_seen_subcommand_from $commands" -a list -d "List all installed kernels"

complete -c kernel-install -n "not __fish_seen_subcommand_from $commands" -a add -d "Add a kernel to boot partition"
complete -c kernel-install -n "__fish_seen_subcommand_from add; and not ver_seen_after add" -a "(get_kernel_versions)"
complete -c kernel-install -n "__fish_seen_subcommand_from add; and ver_seen_after add; and not image_seen_after add" -a "(get_image)"

complete -c kernel-install -n "not __fish_seen_subcommand_from $commands" -a remove -d "Remove an installed kernel"
complete -c kernel-install -n "__fish_seen_subcommand_from remove; and not ver_seen_after remove" -a "(get_kernel_versions)"

complete -c kernel-install -n "not __fish_seen_subcommand_from $commands" -a inspect -d "Print information of a kernel"
complete -c kernel-install -n "__fish_seen_subcommand_from inspect; and not ver_seen_after inspect" -a "(get_kernel_versions)"
complete -c kernel-install -n "__fish_seen_subcommand_from inspect; and ver_seen_after inspect; and not image_seen_after inspect" -a "(get_image)"

function add_arg
    complete -c kernel-install -n "not __fish_seen_subcommand_from $commands" $argv
end

add_arg -l esp-path -r -F -d "Path to EFI mount"
add_arg -l boot-path -r -F -d "Path to XBOOTLDR"
add_arg -f -l make-entry-directory -d "Create type #1 entry directory" -r -a "yes no auto" -d ""
add_arg -f -l verbose -s v -d "Verbose mode"
add_arg -f -l version -d "Print version info"
add_arg -f -l no-pager -d "Do not pipe output into a pager"
add_arg -x -l json -d "Json output" -a "off pretty short" -d ""
add_arg -f -l no-legend -d "Do not print the legend"

set args "machine-id\t'Read machine-id of running system'
os-id\t'Read id of os-release'
os-image-id\t'Read image_id of os-release'
auto\t'Try machine-id, then os-id, then generate randomly'"

add_arg -x -l entry-token -d "Control the name identity of a boot" -a $args

add_arg -x -l root -a "(__fish_complete_directories)"
