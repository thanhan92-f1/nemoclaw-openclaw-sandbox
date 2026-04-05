# Release Checklist

## Purpose

This checklist turns `RELEASING.md` into a repeatable release workflow for repository documentation and governance updates.

## Pre-Release Checklist

- [ ] all intended docs are merged and reviewed
- [ ] `CHANGELOG.md` is updated
- [ ] `STRUCTURE.md` reflects the current file set
- [ ] `README.md` and `docs/README.md` include new documents
- [ ] shell wrappers and helper scripts pass syntax checks if changed
- [ ] security-sensitive wording was reviewed for correctness

## Validation Checklist

- [ ] key Markdown files render correctly
- [ ] GitHub workflow definitions remain valid
- [ ] repository references and filenames are consistent
- [ ] examples use current paths and command names
- [ ] version tag target is agreed

## Tagging Checklist

- [ ] version follows `vMAJOR.MINOR.PATCH`
- [ ] release notes summarize Added, Changed, and Fixed items
- [ ] any pre-release suffix is intentional

## Suggested Release Commands

```bash
git status
git tag v0.1.0
git push origin v0.1.0
```

## Post-Release Checklist

- [ ] GitHub release notes published
- [ ] release tag visible on remote
- [ ] docs links checked after publish
- [ ] next Unreleased work starts cleanly in `CHANGELOG.md`

## If a Release Must Be Corrected

- publish a follow-up patch release for non-breaking corrections
- use a new minor or major release if repo standards changed materially
- avoid mutating a published tag unless the repository policy explicitly allows it