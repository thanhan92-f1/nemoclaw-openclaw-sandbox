# Operator Handover Guide

## Purpose

This guide defines the minimum information that should be transferred when operational responsibility moves from one operator to another.

## When to Use

Use this guide during:

- shift changes
- vacation or absence coverage
- migration of operational ownership
- incident escalation to another operator
- post-change support handoff

## Minimum Handover Content

Include:

- active host and domain
- current service status
- active provider and fallback assumptions
- recent changes applied
- known open risks or limitations
- pending maintenance or rollback decisions

## Service Snapshot

Capture and share:

```bash
systemctl status docker
systemctl status caddy
systemctl status nemoclaw-connect
openshell inference get
openshell forward list
nemoclaw nemoclaw-sandbox status
```

## Operational Context

The receiving operator should know:

- whether the endpoint is currently healthy
- whether any temporary workaround is active
- whether monitoring or manual checks need closer attention
- which recent change may still need validation

## Handover Checklist

- [ ] current incident state is clear
- [ ] recent changes are listed
- [ ] rollback point is known
- [ ] backup and recovery status is known
- [ ] support or escalation expectations are clear
- [ ] related documentation links are included

## Recommended Links

- `oncall-runbook.md`
- `support-model.md`
- `rollback-strategy.md`
- `post-incident-review.md`
- `acceptance-checklist.md`