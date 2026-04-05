# Documentation Index

## Documents

- `cloudservice-vps-setup.md` — full deployment runbook for cloud service or VPS deployment.
- `services-and-dependencies.md` — required services, dependencies, ports, files, and ownership.
- `command-reference.md` — operations, policies, skills, plugins, and monitoring commands.
- `telegram-setup.md` — Telegram bridge, policy, and allowlist setup.
- `providers.md` — provider registration and `inference.local` model routing.
- `policies.md` — permanent policy editing and preset workflow.
- `skills-and-plugins.md` — safe skill import and plugin management.
- `troubleshooting.md` — recovery guidance for common operational failures.
- `operations-checklist.md` — install, validation, and day-2 checklists.
- `backup-and-restore.md` — backup coverage, archive flow, and restore order.
- `upgrade-runbook.md` — controlled upgrade procedure and rollback guidance.
- `install-script.md` — `install.sh` usage, update flow, and managed uninstall behavior.
- `hardening.md` — host, SSH, Docker, proxy, and policy hardening baseline.
- `disaster-recovery.md` — host rebuild and service recovery workflow.
- `monitoring.md` — service health, reachability, and capacity review baseline.
- `logging.md` — primary log sources and incident log triage workflow.
- `faq.md` — quick operator answers for install, update, rollback, and recovery.
- `networking.md` — DNS, firewall, loopback gateway, and proxy network model.
- `provider-rotation.md` — provider key rotation and active provider switch workflow.
- `release-checklist.md` — repeatable release validation and tagging checklist.
- `security-checklist.md` — repeatable security review checklist.
- `maintenance.md` — daily, weekly, and monthly maintenance baseline.
- `migration.md` — controlled host or domain migration workflow.
- `known-limitations.md` — documented operational limits and constraints.
- `incident-response.md` — triage, containment, and recovery decision flow.
- `access-control.md` — operator access boundaries and review model.
- `credential-handling.md` — safe provider and token handling rules.
- `decommissioning.md` — host retirement and shutdown checklist.
- `operations-sla.md` — internal service targets and incident priority model.
- `support-model.md` — support routing and escalation model.
- `audit-checklist.md` — periodic operational and documentation audit checklist.
- `change-management.md` — controlled change workflow and validation discipline.
- `oncall-runbook.md` — first-response workflow and escalation model for operators.
- `risk-register.md` — tracked operational and security risks for the deployment model.
- `acceptance-checklist.md` — deployment and major-change acceptance criteria.
- `service-dependencies-matrix.md` — summarized dependency chain across host, runtime, proxy, and channels.
- `capacity-planning.md` — lightweight capacity review and host sizing guidance.
- `configuration-baseline.md` — expected deployment baseline and allowed deviation model.
- `rollback-strategy.md` — safe rollback decision and validation workflow.
- `post-incident-review.md` — lightweight review process after incidents.
- `operator-handover.md` — minimum transfer checklist for operational ownership.
- `maintenance-windows.md` — planning and validation model for maintenance windows.
- `control-mapping.md` — mapping of operational controls to deployment risk areas.
- `validation-matrix.md` — minimum validation expectations for common change types.

## Recommended Reading Order

1. `../INSTALL.md`
2. `cloudservice-vps-setup.md`
3. `services-and-dependencies.md`
4. `command-reference.md`
5. `providers.md`
6. `telegram-setup.md`
7. `policies.md`
8. `skills-and-plugins.md`
9. `troubleshooting.md`
10. `operations-checklist.md`
11. `backup-and-restore.md`
12. `upgrade-runbook.md`
13. `install-script.md`
14. `hardening.md`
15. `disaster-recovery.md`
16. `monitoring.md`
17. `logging.md`
18. `faq.md`
19. `networking.md`
20. `provider-rotation.md`
21. `release-checklist.md`
22. `security-checklist.md`
23. `maintenance.md`
24. `migration.md`
25. `known-limitations.md`
26. `incident-response.md`
27. `access-control.md`
28. `credential-handling.md`
29. `decommissioning.md`
30. `operations-sla.md`
31. `support-model.md`
32. `audit-checklist.md`
33. `change-management.md`
34. `oncall-runbook.md`
35. `risk-register.md`
36. `acceptance-checklist.md`
37. `service-dependencies-matrix.md`
38. `capacity-planning.md`
39. `configuration-baseline.md`
40. `rollback-strategy.md`
41. `post-incident-review.md`
42. `operator-handover.md`
43. `maintenance-windows.md`
44. `control-mapping.md`
45. `validation-matrix.md`

## Operational Model

The deployment pattern is:

1. A cloud service or VPS provides the Ubuntu host.
2. Docker and OpenShell manage the secure sandbox runtime.
3. NemoClaw provisions and connects the sandbox.
4. OpenClaw serves the gateway locally on `127.0.0.1:18789`.
5. Caddy exposes HTTPS on `443`.
6. systemd keeps the connection healthy across reboots and session expiry.
