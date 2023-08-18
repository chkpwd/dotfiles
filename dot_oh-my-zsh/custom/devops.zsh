# Hook extension for direnv to hook properly in zsh
eval "$(direnv hook zsh)"

# Autocomplete Terraform
autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/bin/terraform terraform

# Autocomplete Flux
. <(flux completion zsh)

# Autocomplete Helm
. <(helm completion zsh)

# Autocomplete kubetctl
. <(kubectl completion zsh)

# Autocomplete kubevirt
. <(kubectl virt completion zsh)

# Autocomplete vcluster
. <(vcluster completion zsh)

# Start the ssh-agent if not already running
if ! ssh-add -l >/dev/null; then
    ssh-agent -s > ~/.ssh-agent
fi

# Source the ssh-agent pids into the current environment
if [[ -e ~/.ssh-agent ]]; then
    source ~/.ssh-agent > /dev/null
fi

# Add the key(s)
if [[ -e ~/.ssh ]]; then
    ssh-add ~/.ssh/main > /dev/null 2>&1
fi
