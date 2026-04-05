# Rollback Strategy Guide

## Purpose

This guide defines a simple rollback approach for changes affecting availability, security posture, or operational stability.

## Rollback Principles

- prefer the smallest safe rollback
- roll back only to a known-good state
- preserve evidence before destructive recovery actions
- document what triggered the rollback decision

## When to Roll Back

Consider rollback when:

- public HTTPS stops working after a change
- provider routing fails after an update
- sandbox reconnect behavior regresses
- configuration changes introduce unsafe exposure
- operational validation fails and root cause is not immediately clear

## Common Rollback Targets

- previous repository ref via `install.sh --repo-ref`
- previous `Caddyfile`
- previous `nemoclaw-connect.service`
- previous OpenClaw configuration snapshot
- previous provider selection

## Pre-Rollback Evidence

Capture before rollback:

```bash
systemctl --failed
journalctl -u caddy -n 100 --no-pager
journalctl -u nemoclaw-connect -n 100 --no-pager
openshell inference get
openshell forward list
nemoclaw nemoclaw-sandbox status
```

## Rollback Workflow

1. confirm the change window and suspected cause
2. identify the last known-good state
3. restore only the affected layer first
4. validate service health immediately
5. record the rollback outcome and remaining risk

## Repo-Based Rollback

If the change came from repository-managed content:

```bash
./install.sh repo-sync --repo-ref <known-good-ref>
./install.sh update --repo-ref <known-good-ref>
```

Use the smallest valid ref change and revalidate after each step.

## Config Rollback

Typical examples:

- restore `/etc/caddy/Caddyfile` from backup
- restore `/etc/systemd/system/nemoclaw-connect.service`
- restore `/sandbox/.openclaw/openclaw.json`

After restoring config:

```bash
systemctl restart caddy
systemctl daemon-reload
systemctl restart nemoclaw-connect
```

## Validation After Rollback

Confirm:

- public endpoint works
- local gateway remains available
- active provider is correct
- reconnect service is stable
- no unintended exposure was introduced

## Post-Rollback Follow-Up

- document the failed change
- update change planning notes
- decide whether the change should be retried, redesigned, or abandoned
- update runbooks if the failure exposed a process gap

## Related Guides

- `upgrade-runbook.md`
- `incident-response.md`
- `change-management.md`
- `install-script.md`