# Communications Plan Guide

## Purpose

This guide defines a simple communication model for planned work, incidents, and operator handoff in the documented deployment.

## Communication Principles

- communicate early when service impact is possible
- keep messages factual and brief
- avoid sharing secrets or unsafe diagnostics
- record when the status changed and what action is next

## Use Cases

Use this guide for:

- maintenance windows
- incident response
- rollback communication
- operator handover
- major change announcements

## Minimum Communication Content

Include:

- affected host, domain, or service path
- current impact level
- start time or detection time
- action in progress
- next update expectation

## Planned Change Communication

Before a planned change, communicate:

- scope of the work
- expected user impact
- start and end window
- rollback expectation if validation fails

## Incident Communication

During an incident, communicate:

- what is failing
- whether public service is affected
- whether mitigation or rollback is in progress
- when the next update will be shared

## Closure Communication

At closure, communicate:

- restored status
- whether follow-up work remains
- whether additional review will be completed

## Related Guides

- `support-model.md`
- `maintenance-windows.md`
- `oncall-runbook.md`
- `operator-handover.md`