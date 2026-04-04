# Troubleshooting Guide

## Purpose

This guide collects common failure patterns and recovery steps for a cloud service or VPS deployment.

## 1. `nemoclaw` or `openshell` command not found

### Symptoms

- shell cannot find `nemoclaw`
- shell cannot find `openshell`

### Likely Cause

- `nvm` environment not loaded
- `~/.local/bin` not present in `PATH`

### Recovery

```bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
export PATH="$PATH:$HOME/.local/bin"
which nemoclaw
which openshell
```

Persist the fix in `~/.bashrc` if needed.

## 2. Port `18789` is unavailable or already forwarded

### Symptoms

- connect command reports a port conflict
- local gateway is not reachable as expected

### Recovery

```bash
openshell forward list
ss -tlnp | grep 18789
```

If another sandbox owns the port, stop that forward first and reconnect the intended sandbox.

## 3. Gateway stops responding after some time

### Likely Cause

- idle TCP timeout
- SSH session TTL expiry
- reconnect service not enabled

### Recovery

```bash
systemctl status nemoclaw-connect
systemctl restart nemoclaw-connect
openshell forward list
```

Also verify:

- SSH keepalive exists in `~/.ssh/config`
- the `systemd` unit uses the correct binary paths

## 4. Caddy site does not open

### Checks

```bash
systemctl status caddy
ss -tlnp | grep ':80\|:443'
ss -tlnp | grep 18789
```

### Likely Cause

- Caddy not running
- invalid `Caddyfile`
- public DNS or subdomain not pointing to the VPS
- local gateway not listening

### Recovery

- validate `/etc/caddy/Caddyfile`
- restart Caddy
- confirm the public domain resolves to the correct server
- confirm local upstream `127.0.0.1:18789` is live

## 5. Providers do not appear in the UI

### Recovery

```bash
openshell provider list
openshell inference get
```

Inside the sandbox, verify the provider definitions were written successfully, then restart the gateway.

## 6. Telegram bot does not respond

### Checks

- `TELEGRAM_BOT_TOKEN` is set correctly
- `nemoclaw start` is running on the host
- Telegram preset exists in policy
- dashboard allowlist includes your numeric user ID
- `channels.telegram.configWrites` is configured correctly when needed

## 7. Policy changes do not take effect

### Likely Cause

- edited the wrong file
- applied an incomplete policy
- preset not added to the expected sandbox

### Recovery

```bash
nemoclaw nemoclaw-sandbox policy-list
openshell term
```

Then re-apply the full policy file using `openshell policy set`.

## 8. Skill import does not appear in the sandbox

### Checks

- skill exists in `/root/skills/`
- copy path into the cluster is correct
- destination is `/sandbox/.openclaw-data/skills/`
- a fresh dashboard session has been started

## 9. Destructive commands were run accidentally

### High-Risk Commands

- `openclaw configure`
- `nemoclaw onboard`
- `openshell gateway destroy`
- `nemoclaw nemoclaw-sandbox destroy`

### Response

- stop making further changes
- assess what state was recreated or deleted
- inspect remaining providers, policies, and sandbox state
- rebuild only after documenting the current situation

## Escalation Guidance

If routine recovery steps fail, capture:

- exact command used
- error text
- service status output
- relevant config paths
- whether the issue is host-side, sandbox-side, or DNS/proxy-side
