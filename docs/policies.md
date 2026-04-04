# Network Policies Guide

## Purpose

This guide explains how to inspect, extend, and safely apply `OpenShell` network policies for the `NemoClaw` sandbox.

## Policy Model

The sandbox uses a deny-by-default network model.

Implications:

- outbound endpoints must be approved
- temporary TUI approvals are not durable
- permanent access should be managed through policy files

## Key Locations

```bash
NEMOCLAW_POLICIES="$(npm root -g)/nemoclaw/nemoclaw-blueprint/policies"
cat "$NEMOCLAW_POLICIES/openclaw-sandbox.yaml"
ls "$NEMOCLAW_POLICIES/presets/"
```

Typical preset examples include:

- `telegram`
- `slack`
- `discord`
- `docker`
- `huggingface`
- `jira`
- `npm`
- `outlook`
- `pypi`

## Inspect Runtime Activity

Run on the host:

```bash
openshell term
```

Useful keys:

| Key | Action |
|---|---|
| `Tab` | switch panels |
| `j` / `k` | move selection |
| `Enter` | inspect details |
| `r` | show network rules |
| `a` | approve pending request for the session |
| `x` | reject pending request |
| `A` | approve all pending requests |
| `q` | quit |

Important note:

- TUI approvals are session-only and reset after restart.

## Add a Permanent Endpoint

1. Open the full policy file.
2. Add the new endpoint under `network_policies:`.
3. Apply the entire file back to the sandbox.

Example for a weather service:

```yaml
weather:
  name: weather
  endpoints:
    - host: wttr.in
      port: 80
    - host: wttr.in
      port: 443
      protocol: rest
      tls: terminate
      enforcement: enforce
      rules:
        - allow: { method: GET, path: "/**" }
  binaries:
    - { path: /usr/bin/curl }
```

Apply it:

```bash
openshell policy set --policy "$NEMOCLAW_POLICIES/openclaw-sandbox.yaml" nemoclaw-sandbox
```

## Preset-Based Policy Management

Interactive approach:

```bash
nemoclaw nemoclaw-sandbox policy-add
nemoclaw nemoclaw-sandbox policy-list
```

Use this when a preset already exists for the integration you need.

## Important Warning

`openshell policy set` replaces the entire active policy.

Therefore:

- never apply a partial fragment
- always review the full file before writing it
- keep a backup copy when making major edits

## Security Recommendations

- keep endpoints narrow and explicit
- add `binaries` restrictions where possible
- avoid overly broad wildcard paths unless required
- review channel-related endpoints as potential exfiltration paths
- document every permanent policy addition in the repository

## Troubleshooting

If network access still fails:

1. confirm the policy was applied to `nemoclaw-sandbox`
2. confirm the endpoint host and port are correct
3. confirm protocol and rules match the actual request pattern
4. inspect pending requests in `openshell term`
5. verify the calling binary is allowed when `binaries` restrictions exist
