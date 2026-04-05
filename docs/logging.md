# Logging Guide

## Purpose

This guide centralizes the main log sources used to operate and troubleshoot a NemoClaw and OpenClaw sandbox deployment.

Use it with:

- `monitoring.md`
- `troubleshooting.md`
- `disaster-recovery.md`

## Primary Log Sources

Review these first:

- `journalctl -u caddy`
- `journalctl -u nemoclaw-connect`
- `nemoclaw nemoclaw-sandbox logs`
- `docker logs <container>` where relevant

## systemd Logs

### Caddy

```bash
journalctl -u caddy -n 100 --no-pager
journalctl -u caddy -f
```

Use these logs when:

- HTTPS is unavailable
- Caddy fails to reload
- certificate issuance or config validation fails

### NemoClaw Reconnect Service

```bash
journalctl -u nemoclaw-connect -n 100 --no-pager
journalctl -u nemoclaw-connect -f
```

Use these logs when:

- the local forward disappears
- reconnect loops occur repeatedly
- binary paths or environment assumptions changed

## Sandbox Logs

```bash
nemoclaw nemoclaw-sandbox logs
nemoclaw nemoclaw-sandbox logs --follow
```

Use sandbox logs to inspect:

- runtime startup failures
- provider routing problems
- plugin or skill related issues
- gateway behavior after policy changes

## Docker Logs

List running containers first:

```bash
docker ps
```

Then inspect a target container:

```bash
docker logs <container-name>
docker logs --tail 200 <container-name>
```

Use Docker logs when the issue is below the sandbox control plane or tied to container restarts.

## Suggested Triage Order

When an incident occurs:

1. check `systemctl --failed`
2. inspect `journalctl -u nemoclaw-connect`
3. inspect `journalctl -u caddy`
4. inspect `nemoclaw nemoclaw-sandbox logs`
5. inspect Docker logs if the issue is container-level

## Log Capture for Escalation

Capture these details before making destructive changes:

- exact command used
- timestamp of failure
- relevant service status output
- last 100 lines of the affected service log
- active provider from `openshell inference get`
- current forward state from `openshell forward list`

## Useful Commands

```bash
systemctl --failed
journalctl -p err -b --no-pager
journalctl -u caddy --since "1 hour ago"
journalctl -u nemoclaw-connect --since "1 hour ago"
```

## Retention and Hygiene

- ensure disk usage is monitored when logs grow quickly
- export critical logs before rebuilding or purging services
- attach trimmed, relevant logs to internal issue reports only
- never publish secrets, tokens, or provider credentials in shared logs

## Cross-Reference

- use `monitoring.md` for routine health review
- use `troubleshooting.md` for symptom-based recovery
- use `disaster-recovery.md` when logs indicate rebuild is safer than repair