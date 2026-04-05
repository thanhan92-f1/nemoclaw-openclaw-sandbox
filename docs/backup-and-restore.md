# Backup and Restore Guide

## Purpose

This guide defines a practical backup and restore approach for a NemoClaw and OpenClaw deployment running on a cloud service or VPS.

## Backup Goals

Protect the following:

- host configuration files
- reverse proxy configuration
- systemd service definitions
- OpenClaw gateway configuration
- approved custom skills
- repository documentation and local operational notes

Do **not** back up live secrets in plain text unless they are stored in an approved secret-management system.

## Recommended Backup Scope

### Host Configuration

Back up:

- `/etc/docker/daemon.json`
- `/etc/caddy/Caddyfile`
- `/etc/systemd/system/nemoclaw-connect.service`
- `~/.ssh/config`
- `~/.bashrc`

### Sandbox and Application State

Back up carefully:

- `/sandbox/.openclaw/openclaw.json`
- `/sandbox/.openclaw-data/skills/`
- `/root/skills/` if used as a staging area

### Repository Materials

Back up or mirror:

- repository contents
- local runbook overrides
- change records not yet committed upstream

## What Not to Store In Plain Text Backups

Avoid placing these directly in backup archives unless encrypted:

- API keys
- Telegram bot tokens
- provider credentials
- private SSH keys
- unredacted incident notes with sensitive details

## Backup Frequency

Recommended minimum schedule:

- after first successful installation
- after any provider-model reconfiguration
- after changes to Caddy, policies, or systemd services
- before upgrades or significant maintenance
- on a recurring schedule for stable production environments

## Simple Backup Procedure

Create a dated backup directory:

```bash
export BACKUP_ROOT=/root/nemoclaw-backups
export BACKUP_DATE=$(date +%F-%H%M%S)
mkdir -p "$BACKUP_ROOT/$BACKUP_DATE"
```

Copy host configuration:

```bash
cp /etc/docker/daemon.json "$BACKUP_ROOT/$BACKUP_DATE/daemon.json"
cp /etc/caddy/Caddyfile "$BACKUP_ROOT/$BACKUP_DATE/Caddyfile"
cp /etc/systemd/system/nemoclaw-connect.service "$BACKUP_ROOT/$BACKUP_DATE/nemoclaw-connect.service"
cp ~/.ssh/config "$BACKUP_ROOT/$BACKUP_DATE/ssh-config"
cp ~/.bashrc "$BACKUP_ROOT/$BACKUP_DATE/bashrc"
```

Copy OpenClaw state and skills:

```bash
cp /sandbox/.openclaw/openclaw.json "$BACKUP_ROOT/$BACKUP_DATE/openclaw.json"
cp -r /sandbox/.openclaw-data/skills "$BACKUP_ROOT/$BACKUP_DATE/skills"
cp -r /root/skills "$BACKUP_ROOT/$BACKUP_DATE/root-skills" 2>/dev/null || true
```

Archive the backup:

```bash
tar -czf "$BACKUP_ROOT/nemoclaw-backup-$BACKUP_DATE.tar.gz" -C "$BACKUP_ROOT" "$BACKUP_DATE"
```

## Restore Strategy

Restore in this order:

1. host operating system baseline
2. Docker and OpenShell availability
3. host config files
4. Caddy and systemd service definitions
5. OpenClaw config and skill directories
6. provider registration and active inference selection
7. final service validation

## Restore Procedure

### 1. Prepare the Host

Reinstall the required base tools if needed:

- Docker
- OpenShell
- NemoClaw
- Caddy

Use `INSTALL.md` as the baseline.

### 2. Restore Host Files

```bash
cp daemon.json /etc/docker/daemon.json
cp Caddyfile /etc/caddy/Caddyfile
cp nemoclaw-connect.service /etc/systemd/system/nemoclaw-connect.service
cp ssh-config ~/.ssh/config
cp bashrc ~/.bashrc
```

### 3. Restore Sandbox Files

```bash
cp openclaw.json /sandbox/.openclaw/openclaw.json
cp -r skills/* /sandbox/.openclaw-data/skills/
```

If `/root/skills/` is used, restore it separately.

### 4. Reload Services

```bash
systemctl daemon-reload
systemctl restart docker
systemctl restart caddy
systemctl restart nemoclaw-connect
```

### 5. Re-Register Providers if Needed

If provider definitions were not preserved externally, recreate them with:

```bash
openshell provider create ...
openshell inference set ...
```

## Validation After Restore

Run:

```bash
systemctl status docker
systemctl status caddy
systemctl status nemoclaw-connect
openshell forward list
openshell inference get
nemoclaw nemoclaw-sandbox status
```

Confirm:

- HTTPS is reachable
- `127.0.0.1:18789` is still private
- expected models are available in OpenClaw
- custom skills are present if used

## Recovery Notes

- Prefer encrypted backup storage.
- Keep at least one known-good backup before major changes.
- Test restores periodically on a non-production host when possible.
- Document any restore deviations in repository notes or release records.
