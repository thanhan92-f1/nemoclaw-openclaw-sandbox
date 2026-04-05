# Validation Matrix Guide

## Purpose

This guide summarizes what should be validated after common operational changes.

## Validation Matrix

| Change Type | Minimum Validation | Related Guides |
|---|---|---|
| Initial install | service status, local gateway, public HTTPS, provider routing | `INSTALL.md`, `acceptance-checklist.md` |
| Proxy or DNS change | public HTTPS, certificate behavior, localhost upstream | `networking.md`, `rollback-strategy.md` |
| Provider rotation | active provider, model routing, fallback readiness | `providers.md`, `provider-rotation.md` |
| Upgrade | service health, reconnect behavior, public reachability | `upgrade-runbook.md`, `maintenance-windows.md` |
| Rollback | restored service health, correct active config, no new exposure | `rollback-strategy.md`, `acceptance-checklist.md` |
| Incident recovery | current stability, risk containment, operator handover readiness | `incident-response.md`, `post-incident-review.md` |

## Core Validation Commands

```bash
systemctl status docker
systemctl status caddy
systemctl status nemoclaw-connect
openshell inference get
openshell forward list
curl -I https://your-domain.example
curl -I http://127.0.0.1:18789
```

## Validation Discipline

- validate the changed layer first
- then validate dependent layers
- record failures before retrying or rolling back
- update docs if the expected validation path changed

## Related Guides

- `acceptance-checklist.md`
- `operations-checklist.md`
- `change-management.md`
- `maintenance-windows.md`