# Known Limitations

## Purpose

This guide records current operational limitations and deliberate constraints in this repository.

## Current Limitations

- the automation is documentation-first and does not provide a full production orchestrator
- `install.sh` intentionally performs conservative uninstall behavior and does not fully purge all packages
- provider onboarding still depends on external credentials and host-side setup
- Caddy and DNS setup still require operator review for public exposure
- Telegram and similar channels require manual policy and allowlist review

## Operational Constraints

- the documented baseline assumes Ubuntu `24.04`
- the documented exposure model assumes only `80` and `443` are public
- local gateway behavior depends on a healthy forward to `127.0.0.1:18789`
- binary locations may vary across environments and sometimes require path adjustment

## Documentation Constraints

- this repository cannot validate third-party provider availability
- installer URLs for OpenShell and NemoClaw are external dependencies
- environment examples are placeholders and not live secret management

## Recommended Operator Response

- validate assumptions before each rollout
- keep rollback refs available
- treat destructive commands as exceptional operations
- update this file when recurring limitations become part of the known baseline