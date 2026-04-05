# Capacity Planning Guide

## Purpose

This guide provides a lightweight capacity planning model for a single-host NemoClaw and OpenClaw deployment.

## Scope

Use this guide to review whether the current cloud service or VPS host still fits the expected workload.

Review capacity after:

- onboarding new users or channels
- repeated performance complaints
- provider or model changes
- major upgrades
- sustained growth in session volume

## Capacity Areas

Review these areas first:

- CPU saturation on the host
- memory pressure
- disk usage and Docker storage growth
- reverse proxy responsiveness
- reconnect stability
- provider throughput and latency

## Minimum Review Commands

```bash
uptime
free -h
df -h
docker ps
docker stats --no-stream
systemctl status caddy
systemctl status nemoclaw-connect
openshell forward list
openshell inference get
```

## Resource Baseline Questions

- Does the host keep enough free memory for peak activity?
- Is disk usage growing because of logs, Docker artifacts, or backups?
- Are reconnects or proxy delays increasing under normal use?
- Did a provider or model switch materially change response time?

## Practical Warning Signs

Investigate when you observe:

- memory consistently close to exhaustion
- disk usage above `80%`
- repeated Docker restart behavior
- unstable public response times
- frequent operator restarts to restore normal service

## Review Cadence

- daily: quick health and disk review
- weekly: service trends and cleanup needs
- monthly: host size, provider behavior, and growth assumptions
- after incidents: confirm whether insufficient capacity contributed

## Scaling Guidance

Before increasing host size or changing the deployment shape:

1. confirm the issue is actually capacity related
2. remove avoidable pressure such as stale logs or unused Docker artifacts
3. document the observed bottleneck
4. record the rollback or fallback plan
5. update the relevant runbooks after the change

## Capacity Risks

Common risks include:

- under-sized host for new usage patterns
- backup archives consuming critical disk space
- larger models increasing latency beyond expectations
- optional channels adding load without review

## Related Guides

- `monitoring.md`
- `maintenance.md`
- `risk-register.md`
- `service-dependencies-matrix.md`