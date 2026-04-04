# Services and Dependencies

## Required Dependencies

| Component | Scope | Purpose | Install Method | Notes |
|---|---|---|---|---|
| Ubuntu 24.04 | Host | Base operating system | cloud service or VPS image | Recommended baseline |
| Docker | Host | Container runtime for OpenShell stack | `curl -fsSL https://get.docker.com | sh` | Requires cgroup config fix |
| OpenShell | Host | Secure sandbox runtime, policies, providers, forwarding | official install script | Installed to host shell |
| NemoClaw | Host | Sandbox bootstrap and connection workflow | `curl -fsSL https://nvidia.com/nemoclaw.sh | bash` | Uses `nvm` internally |
| OpenClaw Gateway | Sandbox | Serves the chat gateway | provisioned by onboarding | Exposed locally on `127.0.0.1:18789` |
| Caddy | Host | HTTPS reverse proxy | Caddy apt repository | Public entry point |
| systemd | Host | Service supervision and restart policy | built into Ubuntu | Used for `nemoclaw-connect.service` |

## Optional Dependencies

| Component | Scope | Purpose | Trigger |
|---|---|---|---|
| Anthropic provider | Host | Claude model access | `openshell provider create --type anthropic` |
| OpenAI provider | Host | GPT model access | `openshell provider create --type openai` |
| Telegram bridge | Host | Telegram bot channel | `nemoclaw start` |
| cloudflared tunnel | Host | Auxiliary connectivity managed by NemoClaw | started with `nemoclaw start` |
| ClawHub CLI | Host | Download skills before sandbox import | `npm install -g clawhub` |

## Runtime Services

### 1. Docker

- Service name: `docker`
- Start: `systemctl start docker`
- Enable: `systemctl enable docker`
- Used by: OpenShell cluster runtime

### 2. OpenShell

Key responsibilities:

- sandbox lifecycle
- network policy enforcement
- inference provider management
- port forwarding
- operational TUI via `openshell term`

Typical binaries:

- `~/.local/bin/openshell`

### 3. NemoClaw

Key responsibilities:

- onboarding wizard
- sandbox connection workflow
- channel bridge startup
- sandbox logs and status wrappers

Typical binary:

- `~/.nvm/versions/node/.../bin/nemoclaw`

### 4. OpenClaw Gateway

- Runs inside the sandbox
- Reads `/sandbox/.openclaw/openclaw.json`
- Local endpoint: `127.0.0.1:18789`
- Must remain private behind Caddy

### 5. Caddy

- Service name: `caddy`
- Role: TLS termination and reverse proxy
- Public ports: `80`, `443`
- Upstream: `127.0.0.1:18789`

### 6. systemd Service for Connection Resilience

Recommended service:

- `nemoclaw-connect.service`

Purpose:

- reconnect after host reboot
- recover from idle timeout
- recover from SSH session TTL expiry

## Required File and Path References

| Path | Meaning |
|---|---|
| `/etc/docker/daemon.json` | Docker cgroup namespace configuration |
| `~/.bashrc` | host PATH and environment persistence |
| `~/.ssh/config` | SSH keepalive configuration |
| `/etc/systemd/system/nemoclaw-connect.service` | sandbox connection service unit |
| `/etc/caddy/Caddyfile` | reverse proxy configuration |
| `/sandbox/.openclaw/openclaw.json` | OpenClaw gateway and model config |
| `/sandbox/.openclaw-data/skills/` | sandbox skill directory |
| `/root/skills/` | host-side skill staging directory |

## Port Model

| Port | Exposure | Purpose |
|---|---|---|
| `80` | Public | HTTP for certificate bootstrap and redirect |
| `443` | Public | HTTPS access through Caddy |
| `18789` | Private, localhost only | OpenClaw gateway upstream |

## Provider and Credential Model

- Real credentials stay on the host.
- Sandboxes use `https://inference.local/v1`.
- OpenShell injects host-side credentials into outbound requests.
- Do not place production API keys directly inside sandbox files.

## Operational Commands

```bash
systemctl status docker
systemctl status caddy
systemctl status nemoclaw-connect
openshell inference get
openshell forward list
nemoclaw nemoclaw-sandbox status
```
