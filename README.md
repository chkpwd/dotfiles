*These dotfiles are managed with [Chezmoi](https://www.chezmoi.io/) across my machines*

Before initializing chezmoi, create `~/.config/chezmoi/chezmoi.toml` with required configuration:

```toml
[data]
  email = "your-email@example.com"

[data.machine]
  work = false
  personal = true

[secret]
  accessToken = "your-bitwarden-secrets-manager-token"
```

- `email` — Used in `.gitconfig`
- `machine.work` / `machine.personal` — Controls which configs/packages are included
- `accessToken` — Bitwarden Secrets Manager access token for retrieving secrets (SSH keys, Docker auth, Terraform creds, SOPS keys, etc.)

## Installation

```bash
sh -c "$(curl -fsLS chezmoi.io/get)" -- init --ssh --apply chkpwd
```
