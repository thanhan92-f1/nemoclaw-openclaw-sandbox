# Releasing and Versioning Policy

## Versioning Model

This repository uses semantic versioning for repository-level documentation and governance releases.

Format:

`MAJOR.MINOR.PATCH`

## When to Bump Versions

### Major

Increase `MAJOR` when repository standards or documented operating assumptions change in a breaking way, for example:

- incompatible deployment workflow changes
- removed or renamed core documents
- major restructuring of required operational steps

### Minor

Increase `MINOR` when adding new documentation sets or governance features, for example:

- new runbooks
- new templates
- new operational guides
- expanded security guidance

### Patch

Increase `PATCH` for non-breaking corrections, for example:

- typo fixes
- clarified commands
- corrected paths, ports, or wording
- minor CI or template improvements

## Release Process

1. Confirm documentation changes are complete.
2. Update `CHANGELOG.md`.
3. Verify key Markdown files render correctly.
4. Ensure CI is passing.
5. Create a version tag.
6. Publish release notes summarizing Added, Changed, and Fixed items.

## Release Notes Expectations

Each release should summarize:

- documentation added
- important operational changes
- security-relevant updates
- template or workflow changes

## Tagging Recommendation

Use tags in the form:

`vMAJOR.MINOR.PATCH`

Example:

`v0.1.0`

## Pre-Release Guidance

Use pre-release identifiers when needed for draft documentation milestones, for example:

- `v0.2.0-beta.1`
- `v0.2.0-rc.1`

## Change Control

Do not publish a release without updating `CHANGELOG.md` to reflect repository-visible changes.
