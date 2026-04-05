# Disaster Recovery Guide

## Purpose

This guide describes how to recover a NemoClaw and OpenClaw sandbox deployment after host failure, configuration loss, or a broken upgrade.

Read this together with:

- `backup-and-restore.md`
- `upgrade-runbook.md`
- `troubleshooting.md`
- `install-script.md`

## Recovery Scenarios

Use this guide for:

- complete VPS replacement
- accidental deletion of repo-managed configuration
- failed upgrade or rollback
- damaged reverse proxy or DNS setup
- provider configuration drift after rebuild

## Minimum Recovery Assets

Maintain these before an incident:

- latest repository ref or tagged release to redeploy
- backup archive of exported configs and operational notes
- DNS records and domain ownership access
- provider inventory and model routing notes
- Telegram allowlist and integration notes if used
- secure access to the administrative SSH keys

## Recovery Order

### 1. Restore Host Access

- deploy a fresh Ubuntu host
- restore SSH access with approved keys
- verify DNS points to the replacement host if failover is required

### 2. Restore Repository Baseline

Clone or sync the repository:

```bash
git clone https://github.com/thanhan92-f1/nemoclaw-openclaw-sandbox.git
cd nemoclaw-openclaw-sandbox
```

Or use the script to pin a known-good ref:

```bash
sudo bash install.sh repo-sync --repo-ref main
```

### 3. Rebuild Core Runtime

Use either the manual install path in `../INSTALL.md` or the scripted path:

```bash
sudo bash install.sh install --domain sandbox.example.cloud
```

If recovering from a bad update, use the last known good tag or commit:

```bash
sudo bash install.sh update --repo-ref v0.1.0
```

### 4. Recreate Providers and Policies

Reapply:

- `openshell provider create ...`
- `openshell inference set ...`
- permanent policy files reviewed in `policies.md`
- Telegram bridge settings if required

### 5. Re-enable Public Access

- validate the Caddy configuration
- confirm DNS resolution
- verify HTTPS reaches the local OpenClaw endpoint through the proxy

### 6. Re-run Service Validation

Check:

```bash
systemctl status docker
systemctl status caddy
systemctl status nemoclaw-connect
openshell forward list
nemoclaw nemoclaw-sandbox status
```

## Fast Recovery Checklist

1. provision replacement VPS
2. restore SSH access
3. clone or sync repo
4. run `install.sh install` or manual install steps
5. restore providers and policies
6. validate Caddy and public HTTPS
7. verify sandbox health
8. test one real provider-backed request

## Broken Upgrade Recovery

If a recent change caused the outage:

1. identify the last known working repository ref
2. pin that ref with `install.sh update --repo-ref <ref>`
3. restore backed up managed files if needed
4. re-run validation from `operations-checklist.md`

## Post-Recovery Actions

After service is restored:

- document the incident cause
- rotate exposed credentials if compromise is possible
- compare restored config with `hardening.md`
- update runbooks if the failure path exposed a documentation gap