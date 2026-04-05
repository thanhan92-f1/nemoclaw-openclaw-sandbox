# Maintenance Guide

## Purpose

This guide defines routine maintenance tasks for keeping a NemoClaw and OpenClaw deployment stable over time.

Use it with:

- `monitoring.md`
- `logging.md`
- `operations-checklist.md`
- `upgrade-runbook.md`

## Daily Maintenance

- confirm `docker`, `caddy`, and `nemoclaw-connect` are healthy
- verify the HTTPS endpoint responds
- verify the local gateway forward exists
- review recent error logs if behavior changed

## Weekly Maintenance

- review firewall and DNS assumptions
- review provider state with `openshell inference get`
- inspect Docker containers, images, and disk growth
- review Telegram or other optional channel integrations if enabled

## Monthly Maintenance

- apply host package updates
- remove stale packages with `apt autoremove`
- review SSH access and operator accounts
- review policy files for stale network allowances
- confirm backups are current and restorable

## Suggested Commands

```bash
systemctl status docker
systemctl status caddy
systemctl status nemoclaw-connect
openshell inference get
openshell forward list
docker ps
df -h
```

## After Any Change

After updates, rotations, or reconfiguration:

1. validate service health
2. confirm public reachability
3. confirm local gateway reachability
4. review logs for regressions
5. update docs if the operating model changed