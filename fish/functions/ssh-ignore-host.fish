function ssh-ignore-host --wraps=ssh
    ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no $argv
end
