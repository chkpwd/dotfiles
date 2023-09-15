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

# Autocomplete Atuin
. <(atuin init zsh)
