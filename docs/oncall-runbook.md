# On-Call Runbook

## Purpose

This runbook provides a lightweight on-call operating model for a single-host NemoClaw and OpenClaw deployment.

## Scope

Use this guide when an operator is responsible for first response to:

- public endpoint outage
- failed sandbox reconnect
- provider routing failure
- reverse proxy or certificate issue
- suspected credential exposure

## On-Call Responsibilities

- acknowledge critical alerts quickly
- determine whether the issue is public, internal, or documentation-only
- stabilize service before making non-essential changes
- capture evidence before restart or rollback steps
- escalate when the incident exceeds local authority or confidence

## Minimum Triage Workflow

1. Confirm the reported symptom.
2. Classify the impact:
   - endpoint unavailable
   - degraded inference or provider routing
   - channel-specific failure such as Telegram only
   - documentation or operator workflow issue
3. Check current service state.
4. Preserve logs and recent command output.
5. Decide whether to recover, roll back, or escalate.

## First Checks

```bash
systemctl status docker
systemctl status caddy
systemctl status nemoclaw-connect
openshell inference get
openshell forward list
curl -I https://your-domain.example
curl -s http://127.0.0.1:18789/ | head
```

## Incident Classification

### Severity 1

Use for:

- public endpoint fully unavailable
- active credential exposure risk
- failed recovery after a production-impacting change

Expected action:

- prioritize immediate containment and service restoration
- notify internal stakeholders as soon as the scope is understood

### Severity 2

Use for:

- provider path broken while host remains reachable
- repeated `nemoclaw-connect` restarts
- certificate renewal or proxy issue affecting public access

Expected action:

- investigate within the current operating window
- prepare rollback if a recent change is implicated

### Severity 3

Use for:

- documentation mismatch
- non-blocking warning conditions
- isolated operational question without active impact

Expected action:

- capture the issue and schedule corrective work through normal change planning

## Common Response Patterns

### Public Endpoint Down

1. Validate DNS and TLS reachability.
2. Check `caddy` service status and logs.
3. Verify the upstream gateway on `127.0.0.1:18789`.
4. Confirm the sandbox is connected.
5. Roll back recent proxy or host changes if needed.

### Sandbox Not Connected

1. Check `nemoclaw-connect.service` status.
2. Review recent host reboots or SSH disruptions.
3. Confirm OpenShell and NemoClaw binaries remain available in PATH.
4. Reconnect using the documented workflow.
5. Re-enable the service if it was disabled during maintenance.

### Provider Failure

1. Inspect `openshell inference get`.
2. Verify the active provider still exists.
3. Confirm credentials are valid and not expired.
4. Switch to a fallback provider if available.
5. Record provider changes for later audit review.

### Suspected Credential Exposure

1. Stop non-essential changes.
2. Scope the exposure surface.
3. Rotate affected credentials.
4. Review logs and access history.
5. Update internal incident notes and follow `credential-handling.md`.

## Evidence to Capture

- exact time window
- affected domain or sandbox
- commands executed during diagnosis
- service status output
- relevant logs with secrets removed
- whether rollback or restart improved service

## Escalation Triggers

Escalate when:

- recovery steps fail twice without clear explanation
- multiple components fail at once
- host integrity is in doubt
- an operator is unsure whether a credential or token is exposed
- the issue requires destructive recovery actions

## Handover Notes

When passing an incident to another operator, include:

- current severity
- current customer or internal impact
- last known good state
- commands already tried
- pending rollback or recovery decision

## After-Action Expectations

- update relevant runbooks if documentation gaps were discovered
- record follow-up work in change planning
- review whether monitoring or checklists should be improved

## Related Guides

- `incident-response.md`
- `operations-sla.md`
- `support-model.md`
- `troubleshooting.md`
- `credential-handling.md`