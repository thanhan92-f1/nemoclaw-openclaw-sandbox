# Upgrade Runbook

## Purpose

This runbook defines a controlled approach for upgrading a NemoClaw and OpenClaw deployment on a cloud service or VPS.

## Upgrade Principles

- make one change set at a time
- take a backup before modifying runtime configuration
- keep the public surface limited to `80` and `443`
- validate host and sandbox behavior after each change
- document any deviation from the baseline runbooks

## Typical Upgrade Scopes

Examples:

- NemoClaw version update
- OpenShell update
- Caddy package update
- OpenClaw configuration change
- provider model refresh
- documentation-driven standardization changes

## Pre-Upgrade Checklist

- [ ] latest backup completed
- [ ] current service status captured
- [ ] active provider and model recorded
- [ ] current Caddy config copied
- [ ] current `systemd` unit copied
- [ ] maintenance window confirmed if needed
- [ ] rollback plan prepared

## Capture Current State

Run before making changes:

```bash
systemctl status docker
systemctl status caddy
systemctl status nemoclaw-connect
openshell inference get
openshell forward list
nemoclaw nemoclaw-sandbox status
```

Optional config snapshot:

```bash
cp /etc/caddy/Caddyfile /root/Caddyfile.pre-upgrade
cp /etc/systemd/system/nemoclaw-connect.service /root/nemoclaw-connect.service.pre-upgrade
cp /sandbox/.openclaw/openclaw.json /root/openclaw.json.pre-upgrade
```

## Upgrade Sequence

### 1. Review Release Notes or Change Intent

Confirm:

- what component is changing
- whether file formats or commands changed
- whether a restart is required
- whether rollback is safe

### 2. Apply the Smallest Valid Change

Examples:

- update package versions
- refresh installed CLI components
- adjust OpenClaw configuration
- modify provider routing

Avoid combining unrelated changes in one maintenance step.

### 3. Restart Only Required Services

Examples:

```bash
systemctl restart caddy
systemctl restart nemoclaw-connect
```

If the gateway inside the sandbox changed:

```bash
openclaw gateway stop
openclaw gateway
```

### 4. Validate Immediately

Check:

```bash
systemctl status caddy
systemctl status nemoclaw-connect
openshell inference get
openshell forward list
nemoclaw nemoclaw-sandbox status
```

If the deployment is externally accessible, also verify the HTTPS endpoint manually.

## Upgrade Scenarios

### Update Caddy

```bash
apt update && apt install caddy -y
systemctl restart caddy
```

Then verify TLS and reverse proxy behavior.

### Update OpenShell

Use the latest supported install path from the official installer, then verify:

- `openshell --version` if available
- provider list
- active inference selection
- forwarding state

### Update NemoClaw

Re-run the supported installation/update path, then verify:

- binary path remains correct
- `nemoclaw nemoclaw-sandbox status`
- `nemoclaw-connect.service` still points to the correct binary location

### Update Provider Configuration

After modifying provider definitions or default models:

```bash
openshell inference get
openclaw gateway stop
openclaw gateway
```

Confirm the intended model appears in the dashboard.

## Rollback Guidance

Rollback if:

- public HTTPS fails
- `nemoclaw-connect` no longer reconnects
- provider routing breaks
- OpenClaw gateway becomes unavailable
- configuration format changes were applied incorrectly

Rollback actions may include:

- restoring `Caddyfile`
- restoring `nemoclaw-connect.service`
- restoring `openclaw.json`
- reinstalling the previous known-good component version

## Post-Upgrade Documentation

After a successful upgrade:

- update repository docs if commands or paths changed
- update `CHANGELOG.md` for repository-visible standards changes
- prepare release notes if a tagged release is being published
- record rollback notes if any issue occurred during the change
