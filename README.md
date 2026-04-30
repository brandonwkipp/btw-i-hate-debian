# mnt

Ansible playbook for the MNT Pocket Reform running Debian. Companion to
[btw-i-use-arch](../btw-i-use-arch) — kept separate because the Arch repo is
too tightly coupled to pacman/AUR to absorb a Debian machine cleanly.

## Prerequisites

```
sudo apt install ansible
```

## First-time setup

### 1. Vault password

Samba credentials are encrypted with ansible-vault. Create the password file
before running the playbook:

```
echo 'your_vault_password' > ~/.vault_pass
chmod 600 ~/.vault_pass
```

### 2. Encrypt samba credentials

Run these and paste the output into `roles/samba/vars/main.yml`:

```
ansible-vault encrypt_string 'yourusername' --name 'samba_username'
ansible-vault encrypt_string 'yourpassword' --name 'samba_password'
```

### 3. Reaper

Reaper is not in apt. Grab the ARM64 Linux tar.xz from reaper.fm, then
uncomment and set `reaper_download_url` in `group_vars/all.yml`. Until then
the Reaper tasks are safely skipped.

### 4. Obsidian

Obsidian is not in apt. Grab the ARM64 AppImage from
github.com/obsidianmd/obsidian-releases, then uncomment and set
`obsidian_download_url` in `group_vars/all.yml`. Until then the Obsidian
tasks are safely skipped.

## Running

Full playbook:

```
ansible-playbook -i inventory/hosts playbook.yml
```

The `ansible-playbook` alias in `.zshrc` adds `--ask-become-pass`
automatically, so you only need to type the above.

Single role (useful while building out):

```
ansible-playbook -i inventory/hosts playbook.yml --tags audio
```

Available tags match role names: `packages`, `audio`, `workstation`,
`security`, `samba`, `shell`.

## Roles

| Role | What it does |
|---|---|
| `packages` | Base apt packages (git, zsh, cifs-utils) |
| `audio` | PipeWire + JACK compat layer + ecasound |
| `workstation` | foot, VS Code (via Microsoft apt repo), Reaper, Syncthing, Obsidian |
| `security` | wireshark (with non-root capture), nmap |
| `samba` | Credentials + fstab automount for `//helium/brandon` |
| `shell` | Sets zsh as default shell, deploys `.zshrc` |

## Adding packages

Add apt packages to the `packages` list in `group_vars/all.yml` for anything
that should be installed on every run. Role-specific packages live in each
role's own task file.

## Dotfiles

`.zshrc` is managed by the `shell` role and deployed to `~/.zshrc`. Machine-local
overrides (API keys, private aliases, nvm, etc.) go in `~/.zshrc.local` —
that file is intentionally not managed by ansible.

Dotfiles are ported from btw-i-use-arch with Arch-specific bits removed
(`pacman`, `mountshare`, `go2bios`, nvm path). If you want both machines in
sync long-term, consider extracting dotfiles into a shared repo and pulling it
in as a git submodule here and in btw-i-use-arch.

## helium share

Mounts `//helium/brandon` at `/mnt/helium/brandon` via systemd automount
with a 10-minute idle timeout. The host entry `192.168.0.2 helium` is written
to `/etc/hosts` by the samba role.
