# Monitoring Guide

## Purpose

This guide defines a practical monitoring baseline for NemoClaw and OpenClaw running on a cloud service or VPS.

Use it with:

- `operations-checklist.md`
- `troubleshooting.md`
- `hardening.md`
- `disaster-recovery.md`

## Monitoring Priorities

Monitor these areas first:

- sandbox connectivity
- reverse proxy health
- local gateway reachability
- active provider routing
- host resource pressure
- failed reconnect loops

## Core Service Checks

### Systemd Services

```bash
systemctl status docker
systemctl status caddy
systemctl status nemoclaw-connect
```

### Sandbox and Forward State

```bash
nemoclaw nemoclaw-sandbox status
openshell sandbox list
openshell forward list
ss -tlnp | grep 18789
```

### Provider and Inference State

```bash
openshell provider list
openshell inference get
```

## Recommended Daily Checks

- confirm `nemoclaw-connect` is active
- confirm Caddy is active and serving HTTPS
- confirm the local gateway still listens on `127.0.0.1:18789`
- confirm the expected provider is selected
- review recent errors in service logs

## Resource Monitoring

At minimum, review:

```bash
uptime
free -h
df -h
docker ps
docker stats --no-stream
```

Watch for:

- memory pressure
- full disk on `/` or Docker storage paths
- repeated container restart behavior
- CPU saturation during onboarding or model-heavy sessions

## Connectivity Monitoring

Validate both local and public access paths:

```bash
curl -I http://127.0.0.1:18789
curl -I https://your-domain.example
```

If the local check works but the public check fails, inspect Caddy, DNS, and firewall state.

## Monitoring Signals to Track

Important indicators:

- `nemoclaw-connect` restarting too often
- forward missing from `openshell forward list`
- `caddy` inactive or failing validation
- provider unexpectedly changed
- dashboard unreachable while local port is healthy

## Alert Triggers

Create alerts or scheduled reviews for:

- `nemoclaw-connect` inactive for more than a few minutes
- HTTPS endpoint unavailable
- local port `18789` not listening
- disk usage above `80%`
- repeated authentication or provider errors

## Lightweight Review Routine

Suggested review cadence:

- every morning: service status and public reachability
- after changes: provider, policy, and proxy validation
- weekly: log review and Docker cleanup review
- monthly: host patching and capacity review

## Incident-Oriented Commands

When behavior changes unexpectedly, capture:

```bash
systemctl --failed
journalctl -u caddy -n 100 --no-pager
journalctl -u nemoclaw-connect -n 100 --no-pager
openshell forward list
openshell inference get
nemoclaw nemoclaw-sandbox logs --follow
```

## Recommended Next Step

For log-focused inspection, continue with `logging.md`.