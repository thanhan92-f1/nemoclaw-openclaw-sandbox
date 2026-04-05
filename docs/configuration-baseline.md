# Configuration Baseline Guide

## Purpose

This guide defines the expected baseline configuration for the documented NemoClaw and OpenClaw deployment.

## Baseline Principles

- keep the host build simple and reproducible
- expose only required public ports
- keep sensitive credentials on the host
- document every intentional deviation from the baseline

## Expected Host Baseline

- Ubuntu `24.04`
- Docker installed and operational
- OpenShell installed for the operator account
- NemoClaw installed and reachable from the operator shell
- Caddy configured as the public reverse proxy when public HTTPS is required
- `nemoclaw-connect.service` enabled when persistent reconnect behavior is needed

## Network Baseline

- ports `80` and `443` are the only intended public ports
- OpenClaw upstream remains bound to `127.0.0.1:18789`
- DNS points only to the intended public endpoint
- firewall rules match the documented exposure model

## Provider Baseline

- active inference provider is defined through OpenShell
- provider credentials remain on the host
- sandbox model routing uses `https://inference.local/v1`
- fallback provider exists when operationally necessary

## File Baseline

Review these files as part of the baseline:

- `/etc/docker/daemon.json`
- `/etc/caddy/Caddyfile`
- `/etc/systemd/system/nemoclaw-connect.service`
- `~/.bashrc`
- `~/.ssh/config`
- `/sandbox/.openclaw/openclaw.json`

## Baseline Validation

Use these checks after setup or change work:

```bash
systemctl status docker
systemctl status caddy
systemctl status nemoclaw-connect
ss -tlnp | grep -E '80|443|18789'
openshell inference get
openshell forward list
curl -I https://your-domain.example
```

## Allowed Deviations

If the deployment must differ from the baseline, record:

- why the deviation is required
- what risk it adds
- how it will be monitored
- how to return to the baseline if needed

## When to Review the Baseline

- after upgrades
- after incidents
- before migration or decommissioning work
- when adding providers, channels, or new automation

## Related Guides

- `services-and-dependencies.md`
- `networking.md`
- `hardening.md`
- `acceptance-checklist.md`