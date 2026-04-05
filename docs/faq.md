# FAQ

## What is this repository for?

It provides operational documentation, automation helpers, and GitHub repository scaffolding for running a NemoClaw sandbox with OpenClaw on a cloud service or VPS.

## Which host OS is assumed?

The guides target Ubuntu `24.04`.

## Which ports should be public?

Only `80` and `443` should be public. The local OpenClaw endpoint should remain on `127.0.0.1:18789` behind Caddy.

## Where should provider credentials live?

On the host, managed through OpenShell provider configuration. Do not store provider credentials in public-facing repository files.

## Should I use the manual install guide or the script?

Use `INSTALL.md` if you want a step-by-step manual flow. Use `install.sh` if you want repeatable install, update, repo sync, and managed uninstall behavior.

## How do I update to a newer repo state?

Use:

```bash
sudo bash update.sh --repo-ref main
```

Or:

```bash
sudo bash install.sh update --repo-ref main
```

## How do I roll back to an older repo state?

Pin the desired branch, tag, or commit:

```bash
sudo bash update.sh --repo-ref v0.1.0
```

## How do I remove script-managed config safely?

Use:

```bash
sudo bash uninstall.sh --yes
```

Add `--purge-repo` or `--remove-caddy-config` only when you explicitly want that cleanup.

## Does uninstall remove Docker, Caddy, OpenShell, or NemoClaw completely?

No. The uninstall flow is intentionally conservative and focuses on repo-managed blocks and optional repo checkout cleanup.

## Where do I start if the sandbox is unreachable?

Check, in order:

1. `systemctl status nemoclaw-connect`
2. `openshell forward list`
3. `ss -tlnp | grep 18789`
4. `systemctl status caddy`
5. `journalctl -u nemoclaw-connect -n 100 --no-pager`

Then continue with `troubleshooting.md` and `logging.md`.

## Where do I find the main operational commands?

See `command-reference.md`.

## Where do I find backup and recovery procedures?

Use:

- `backup-and-restore.md`
- `upgrade-runbook.md`
- `disaster-recovery.md`

## Is Telegram required?

No. Telegram is optional and should only be enabled when needed, with allowlists and policy controls reviewed first.

## Which commands are considered high risk?

Avoid using these casually:

- `openclaw configure`
- `nemoclaw onboard`
- `openshell gateway destroy`
- `nemoclaw nemoclaw-sandbox destroy`

## What should I read first as a new operator?

Recommended order:

1. `../INSTALL.md`
2. `cloudservice-vps-setup.md`
3. `services-and-dependencies.md`
4. `operations-checklist.md`
5. `install-script.md`