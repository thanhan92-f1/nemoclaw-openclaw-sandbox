# Documentation Index

## Documents

- `../LICENSE` — canonical non-commercial license terms for the repository.
- `../NOTICE` — short-form license notice and usage summary.
- `../COMMERCIAL-LICENSE.md` — commercial licensing and separate written permission guidance.
- `licensing.md` — operator-friendly explainer for non-commercial use and commercial restrictions.
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
- `communications-plan.md` — communication model for planned work, incidents, and handover.
- `dependency-review.md` — lightweight dependency review and follow-up model.
- `service-readiness.md` — minimum readiness criteria after install, change, or recovery.
- `operator-onboarding.md` — onboarding path and basic responsibilities for new operators.

## Recommended Reading Order

1. `../INSTALL.md`
2. `../LICENSE`
3. `../NOTICE`
4. `../COMMERCIAL-LICENSE.md`
5. `licensing.md`
6. `cloudservice-vps-setup.md`
7. `services-and-dependencies.md`
8. `command-reference.md`
9. `providers.md`
10. `telegram-setup.md`
11. `policies.md`
12. `skills-and-plugins.md`
13. `troubleshooting.md`
14. `operations-checklist.md`
15. `backup-and-restore.md`
16. `upgrade-runbook.md`
17. `install-script.md`
18. `hardening.md`
19. `disaster-recovery.md`
20. `monitoring.md`
21. `logging.md`
22. `faq.md`
23. `networking.md`
24. `provider-rotation.md`
25. `release-checklist.md`
26. `security-checklist.md`
27. `maintenance.md`
28. `migration.md`
29. `known-limitations.md`
30. `incident-response.md`
31. `access-control.md`
32. `credential-handling.md`
33. `decommissioning.md`
34. `operations-sla.md`
35. `support-model.md`
36. `audit-checklist.md`
37. `change-management.md`
38. `oncall-runbook.md`
39. `risk-register.md`
40. `acceptance-checklist.md`
41. `service-dependencies-matrix.md`
42. `capacity-planning.md`
43. `configuration-baseline.md`
44. `rollback-strategy.md`
45. `post-incident-review.md`
46. `operator-handover.md`
47. `maintenance-windows.md`
48. `control-mapping.md`
49. `validation-matrix.md`
46. `communications-plan.md`
47. `dependency-review.md`
48. `service-readiness.md`
49. `operator-onboarding.md`

## Operational Model

The deployment pattern is:

1. A cloud service or VPS provides the Ubuntu host.
2. Docker and OpenShell manage the secure sandbox runtime.
3. NemoClaw provisions and connects the sandbox.
4. OpenClaw serves the gateway locally on `127.0.0.1:18789`.
5. Caddy exposes HTTPS on `443`.
6. systemd keeps the connection healthy across reboots and session expiry.
