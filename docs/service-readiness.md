# Service Readiness Guide

## Purpose

This guide helps operators judge whether the documented deployment is ready for normal service after install, change, or recovery work.

## Readiness Criteria

Service is considered ready when:

- core services are healthy
- public HTTPS works if enabled
- local gateway is reachable
- active provider routing is correct
- rollback information is available
- operators know the current support and handover state

## Minimum Readiness Checks

```bash
systemctl status docker
systemctl status caddy
systemctl status nemoclaw-connect
openshell inference get
openshell forward list
curl -I https://your-domain.example
curl -I http://127.0.0.1:18789
```

## Readiness Questions

- can the operator prove the public path works end to end?
- can the operator identify the active provider quickly?
- is the current state documented well enough for handover?
- is there any unresolved high-risk issue?

## Not Ready Conditions

Do not declare service ready when:

- validation is incomplete
- rollback steps are unknown
- temporary workarounds are undocumented
- key dependencies are unstable

## Related Guides

- `acceptance-checklist.md`
- `validation-matrix.md`
- `operator-handover.md`
- `support-model.md`