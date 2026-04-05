# Change Management Guide

## Purpose

This guide defines a simple change discipline for updates to deployment behavior, scripts, and operational documentation.

## Change Principles

- prefer documented, reviewable changes over ad-hoc edits
- update runbooks when behavior changes
- validate before and after applying significant changes
- keep rollback references available

## Change Flow

1. identify intended change and affected docs or scripts
2. assess risk level and rollback path
3. apply change in a controlled way
4. validate service health and routing
5. update documentation and changelog

## High-Risk Change Examples

- provider rotation
- public DNS or proxy changes
- install script behavior changes
- security-sensitive policy changes
- migration and decommissioning actions

## Required Follow-Up

- update `CHANGELOG.md`
- update `README.md`, `docs/README.md`, or `STRUCTURE.md` if file scope changed
- re-run syntax or documentation validation where relevant