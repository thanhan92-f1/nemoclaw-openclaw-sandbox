# Install Script Guide

## Purpose

This repository includes `../install.sh` to make initial setup, repository sync, update, and partial removal easier on a cloud service or VPS host.

Convenience wrapper scripts are also included:

- `../update.sh`
- `../uninstall.sh`
- `../repo-sync.sh`

The script is designed to support:

- first-time host bootstrap
- repository checkout and ref pinning
- repeatable updates
- easier rollback to an older repository ref
- removal of repo-managed shell, service, and optional Caddy configuration

## Supported Actions

### Install

Install or refresh the documented host prerequisites and sync the repository:

```bash
sudo bash install.sh install --domain sandbox.example.cloud
```

### Update

Re-sync the repository and re-run the install flow:

```bash
sudo bash install.sh update --repo-ref main --domain sandbox.example.cloud
sudo bash update.sh --repo-ref main --domain sandbox.example.cloud
```

### Repo Sync Only

Update the repository checkout without applying host changes:

```bash
sudo bash install.sh repo-sync --repo-ref main
sudo bash repo-sync.sh --repo-ref main
```

### Uninstall

Remove repo-managed service and shell configuration blocks:

```bash
sudo bash install.sh uninstall --yes
sudo bash uninstall.sh --yes
```

Optional cleanup:

```bash
sudo bash install.sh uninstall --purge-repo --remove-caddy-config --yes
```

## Key Options

- `--repo-url` — override the repository URL
- `--repo-dir` — set the local checkout directory
- `--repo-ref` — pin a branch, tag, or commit for upgrade or rollback
- `--domain` — write a managed Caddy config for the provided domain
- `--sandbox-name` — change the sandbox name used in the reconnect service
- `--skip-caddy` — skip Caddy installation and config
- `--skip-service` — skip systemd reconnect service creation
- `--start-service` — enable and start `nemoclaw-connect.service`
- `--run-onboard` — launch `nemoclaw onboard` after install or update

## Upgrade and Rollback Usage

To move to a newer documentation or automation baseline:

```bash
sudo bash install.sh update --repo-ref main
```

To pin to a tag or older ref:

```bash
sudo bash install.sh update --repo-ref v0.1.0
```

If upstream installers publish version-specific URLs later, you can also override them:

```bash
sudo OPENSHELL_INSTALL_URL=https://example.com/openshell-install.sh \
     NEMOCLAW_INSTALL_URL=https://example.com/nemoclaw-install.sh \
     bash install.sh update --repo-ref v0.1.0
```

## What the Script Manages

The script can manage:

- repository checkout under `/opt/nemoclaw-openclaw-sandbox` by default
- Docker installation and cgroup namespace configuration
- OpenShell installation
- NemoClaw installation
- PATH persistence in `~/.bashrc`
- SSH keepalive settings in `~/.ssh/config`
- optional Caddy installation and `/etc/caddy/Caddyfile`
- optional `/etc/systemd/system/nemoclaw-connect.service`

Managed files written by the script include a repository marker so later cleanup is safer.

## What the Script Does Not Remove Automatically

The uninstall action does **not** fully remove:

- Docker packages
- OpenShell binaries
- NemoClaw binaries
- Caddy packages
- existing providers or credentials
- sandbox state created outside repo-managed files

This is intentional so the uninstall path does not destroy runtime state unexpectedly.

## Recommended Usage Pattern

1. Read `../INSTALL.md`.
2. Run `install.sh install` with your domain if Caddy should be configured.
3. Complete `nemoclaw onboard`.
4. Verify the host using `services-and-dependencies.md` and `operations-checklist.md`.
5. Use `install.sh update --repo-ref ...` for future upgrades or rollbacks.

## Validation Notes

After using the script, validate:

```bash
systemctl status docker
systemctl status caddy
systemctl status nemoclaw-connect
openshell inference get
openshell forward list
nemoclaw nemoclaw-sandbox status
```

If any managed file already existed and was not previously written by the script, a timestamped backup is created before replacement.