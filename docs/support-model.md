# Support Model Guide

## Purpose

This guide describes how operators should classify and route support needs for the documented deployment.

## Support Categories

- operational issue
- security concern
- documentation gap
- release or change regression
- migration or decommissioning request

## Routing Expectations

- use private reporting for active security issues
- use issue templates for non-sensitive repository work
- capture logs and context before asking for operational help
- classify whether the issue is host, proxy, sandbox, provider, or documentation related

## Minimum Support Context

When reporting an issue internally, include:

- affected host or domain
- exact failing command or symptom
- recent changes made
- relevant service status output
- relevant log excerpts with secrets removed

## Escalation Triggers

- repeated critical outage
- uncertain credential exposure scope
- rollback failed and service remains unstable
- host trust no longer adequate after investigation