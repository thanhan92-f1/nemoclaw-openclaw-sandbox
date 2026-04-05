# Networking Guide

## Purpose

This guide documents the expected network layout for a NemoClaw and OpenClaw deployment on a cloud service or VPS.

Use it with:

- `services-and-dependencies.md`
- `hardening.md`
- `monitoring.md`
- `troubleshooting.md`

## Network Model

The expected pattern is:

1. the host receives public traffic on `80` and `443`
2. Caddy terminates TLS on the host
3. Caddy proxies requests to `127.0.0.1:18789`
4. the local forward is maintained by NemoClaw and OpenShell
5. provider traffic exits from the host according to configured policies

## Public Exposure Rules

Expose publicly:

- `80/tcp`
- `443/tcp`
- `22/tcp` only when SSH administration is required

Do not expose publicly:

- `18789/tcp`
- sandbox-internal ports
- ad-hoc provider ports

## DNS Expectations

- point the chosen domain or subdomain to the VPS public IP
- confirm DNS propagation before expecting automatic TLS issuance
- keep DNS records current during host replacement or migration

Validation:

```bash
dig +short your-domain.example
curl -I https://your-domain.example
```

## Local Forward Validation

The local gateway should only listen on loopback:

```bash
ss -tlnp | grep 18789
curl -I http://127.0.0.1:18789
```

Expected pattern:

- listener bound to `127.0.0.1:18789`
- no public bind on `0.0.0.0:18789`

## Reverse Proxy Expectations

The Caddy route should:

- use the intended domain only
- reverse proxy to `127.0.0.1:18789`
- preserve the host or origin overrides required by the gateway behavior

After changes:

```bash
sudo caddy validate --config /etc/caddy/Caddyfile
sudo systemctl reload caddy
```

## Firewall Baseline

Example with UFW:

```bash
sudo ufw allow OpenSSH
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp
sudo ufw status verbose
```

## Policy and Egress Notes

- provider access should follow explicit OpenShell policy rules
- add only the endpoints required by active providers or channels
- remove stale network permissions after retiring integrations

## Common Failure Patterns

- DNS points to the wrong host
- Caddy is healthy but local forward is missing
- local port exists but firewall or DNS blocks public access
- provider calls fail because required egress policy was not applied

## Recommended Checks After Any Network Change

1. `systemctl status caddy`
2. `openshell forward list`
3. `ss -tlnp | grep 18789`
4. `curl -I http://127.0.0.1:18789`
5. `curl -I https://your-domain.example`