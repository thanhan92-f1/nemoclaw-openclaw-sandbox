# Service Dependencies Matrix

## Purpose

This matrix summarizes how the documented services depend on each other during normal operation.

## Dependency Matrix

| Service or Component | Depends On | Why the Dependency Matters | Failure Effect |
|---|---|---|---|
| Public HTTPS endpoint | DNS, Caddy, OpenClaw gateway, active sandbox connection | Serves the user-facing entry point | Public access fails or degrades |
| Caddy | Valid domain configuration, local gateway on `127.0.0.1:18789` | Terminates TLS and proxies requests | Endpoint unavailable or certificate issues |
| OpenClaw gateway | Sandbox runtime, OpenShell networking, valid config file | Handles gateway traffic inside sandbox | Upstream becomes unavailable |
| NemoClaw sandbox connection | OpenShell runtime, host authentication state, network reachability | Keeps the sandbox attached and manageable | Sandbox commands or traffic path fail |
| `nemoclaw-connect.service` | systemd, working NemoClaw command path, valid reconnect flow | Restores connectivity after reboot or timeout | Manual reconnect required |
| OpenShell providers | Provider credentials, outbound network access | Enables model inference through host-side providers | Model requests fail |
| Docker | Host kernel support and daemon config | Runs containerized runtime used by OpenShell | Sandbox platform unavailable |
| Telegram bridge | NemoClaw runtime, valid bot token, allowlist config | Enables Telegram as an optional channel | Telegram path unavailable only |

## Dependency Layers

### Layer 1: Host Foundation

- Ubuntu host
- network reachability
- Docker
- systemd

### Layer 2: Runtime Control Plane

- OpenShell
- provider definitions
- sandbox lifecycle

### Layer 3: Application Connectivity

- NemoClaw sandbox connection
- OpenClaw gateway
- local loopback reachability

### Layer 4: Public Exposure

- Caddy
- DNS
- certificates
- optional chat channels

## Recovery Priority

Recover in this order when multiple components fail:

1. host reachability
2. Docker and OpenShell runtime
3. sandbox connection
4. local gateway
5. reverse proxy and public DNS path
6. optional channels such as Telegram

## Change Review Notes

Before changing any component, ask:

- which upstream dependency could break?
- is there a rollback path for that layer?
- does the change affect only an optional channel or the core public path?

## Related Guides

- `services-and-dependencies.md`
- `monitoring.md`
- `troubleshooting.md`
- `disaster-recovery.md`
- `operations-checklist.md`