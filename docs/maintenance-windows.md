# Maintenance Windows Guide

## Purpose

This guide defines a simple model for planning and executing maintenance windows for the documented deployment.

## Maintenance Window Principles

- keep scope small and explicit
- avoid combining unrelated changes
- capture rollback steps before starting
- validate immediately after the work

## When to Schedule a Window

Schedule a maintenance window for:

- package or runtime upgrades
- provider changes with expected impact
- DNS, proxy, or certificate changes
- migration activities
- script or automation changes that affect operations

## Pre-Window Checklist

- [ ] change scope is documented
- [ ] backup or config snapshot is available
- [ ] rollback point is known
- [ ] affected operators are informed
- [ ] validation checks are prepared

## During the Window

1. confirm the current baseline
2. apply the smallest intended change
3. restart only the required services
4. validate local and public paths
5. stop and roll back if validation fails without clear fix

## Post-Window Validation

Confirm:

- public HTTPS endpoint works
- local gateway is healthy
- active provider is correct
- reconnect service remains stable
- no unexpected alerts or failures remain

## Window Close Criteria

Close the maintenance window only when:

- acceptance checks pass
- no unresolved high-risk issue remains
- follow-up items are documented

## Related Guides

- `upgrade-runbook.md`
- `change-management.md`
- `acceptance-checklist.md`
- `rollback-strategy.md`