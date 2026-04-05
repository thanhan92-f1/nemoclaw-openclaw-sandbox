# Hardening Guide

## Purpose

This guide defines a practical hardening baseline for a NemoClaw and OpenClaw sandbox deployed on a cloud service or VPS.

Use this guide together with:

- `../SECURITY.md`
- `services-and-dependencies.md`
- `operations-checklist.md`
- `troubleshooting.md`

## Baseline Host Controls

- Keep the host on a supported Ubuntu LTS release.
- Use a dedicated non-root administrative account.
- Disable password-based SSH login where possible.
- Restrict inbound network exposure to `22`, `80`, and `443` only as required.
- Prefer SSH key authentication and maintain secure key rotation.
- Keep system time synchronized with `systemd-timesyncd` or an approved NTP service.

## Package and Patch Hygiene

- Apply security updates on a regular schedule.
- Reboot after kernel or low-level container runtime updates when required.
- Remove unused packages and stale repositories.
- Track changes to Docker, Caddy, OpenShell, and NemoClaw installer sources.

Example:

```bash
sudo apt update
sudo apt upgrade -y
sudo apt autoremove -y
```

## SSH Hardening

Recommended `sshd_config` controls:

- `PermitRootLogin no`
- `PasswordAuthentication no` when operationally possible
- `PubkeyAuthentication yes`
- `MaxAuthTries 3`
- `ClientAliveInterval 300`
- `ClientAliveCountMax 2`

After changes:

```bash
sudo sshd -t
sudo systemctl reload ssh
```

## Firewall and Exposure Model

- Expose only the public reverse proxy entry points.
- Keep OpenClaw bound to `127.0.0.1:18789`.
- Do not publish sandbox or internal inference ports directly.
- Review Caddy config after every domain or routing change.

Example with UFW:

```bash
sudo ufw allow OpenSSH
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp
sudo ufw enable
```

## Docker Hardening

- Avoid unnecessary privileged containers.
- Review mounted host paths before adding plugins or tools.
- Keep the documented cgroup namespace setting aligned with the deployment guide.
- Restrict Docker group membership.
- Periodically review running containers, images, and networks.

Validation:

```bash
docker ps
docker network ls
docker volume ls
```

## Reverse Proxy Hardening

- Use valid DNS records before enabling public exposure.
- Keep TLS termination at Caddy.
- Route only the intended domain to `127.0.0.1:18789`.
- Remove old virtual host entries after migration.

Validation:

```bash
sudo caddy validate --config /etc/caddy/Caddyfile
sudo systemctl reload caddy
```

## Provider and Credential Hygiene

- Create provider credentials on the host, not inside public-facing workflows.
- Do not commit tokens, API keys, or exported environment secrets.
- Limit credential access to the administrative user responsible for operations.
- Revoke and rotate provider credentials after suspected compromise.

## OpenShell Policy Hardening

- Prefer explicit permanent policies over repetitive interactive approvals.
- Keep policy files under review after enabling Telegram, plugin, or external network features.
- Remove stale allow rules when a tool or integration is retired.
- Use the smallest practical network scope.

## Operational Logging

Review these regularly:

- `journalctl -u caddy`
- `journalctl -u nemoclaw-connect`
- `docker logs <container>` where applicable
- `nemoclaw <sandbox-name> logs`

## Recommended Review Cadence

- daily: check service health and public reachability
- weekly: review logs, firewall rules, and active providers
- monthly: patch host packages and re-check hardening settings
- after every change: re-run the validation items in `operations-checklist.md`