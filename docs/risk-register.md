# Risk Register

## Purpose

This register tracks common operational and security risks for the documented NemoClaw and OpenClaw deployment model.

## Usage Model

- review during change planning
- review after incidents
- update when new providers, channels, or host patterns are introduced
- treat this as a living operator document, not a one-time checklist

## Risk Ratings

- likelihood: low, medium, high
- impact: low, medium, high
- priority should reflect combined operational urgency

## Current Risks

| ID | Risk | Likelihood | Impact | Mitigation | Owner Area |
|---|---|---|---|---|---|
| R-01 | Single-host outage causes full service interruption | Medium | High | Maintain backups, recovery docs, and rebuild procedure | Platform operations |
| R-02 | Public proxy misconfiguration exposes or breaks service | Medium | High | Keep upstream on localhost only, validate Caddy changes before reload | Edge or proxy operations |
| R-03 | Provider credential expires or is revoked | High | Medium | Review credential age, maintain fallback provider, document rotation process | Provider administration |
| R-04 | Sandbox reconnect fails after reboot or idle timeout | Medium | Medium | Keep `nemoclaw-connect.service` enabled and test after maintenance | Platform operations |
| R-05 | Unsafe manual change bypasses documented workflow | Medium | High | Use change review, rollback planning, and post-change validation | Change owner |
| R-06 | Secrets leak into logs, screenshots, or tickets | Medium | High | Sanitize outputs, restrict access, rotate exposed credentials immediately | All operators |
| R-07 | Documentation drift causes incorrect recovery actions | Medium | Medium | Audit docs after releases and incidents | Documentation owner |
| R-08 | DNS or certificate issue blocks public access | Medium | Medium | Monitor endpoint reachability and certificate status | Edge or proxy operations |
| R-09 | Unsupported plugin or skill change destabilizes sandbox behavior | Low | Medium | Test in controlled workflow before broader adoption | Sandbox operations |
| R-10 | Backup coverage is incomplete or restore is untested | Medium | High | Review backup scope and perform restore validation drills | Platform operations |

## Review Questions

- Has the likelihood changed based on recent incidents?
- Does the mitigation remain realistic for a single-host environment?
- Is the owner area clear enough for escalation?
- Are there new risks from provider, policy, or channel changes?

## When to Add a New Risk

Add a new entry when:

- an incident reveals an undocumented failure mode
- a new external dependency becomes operationally important
- the deployment model changes significantly
- a known limitation becomes a material production concern

## Related Guides

- `known-limitations.md`
- `security-checklist.md`
- `audit-checklist.md`
- `change-management.md`
- `disaster-recovery.md`