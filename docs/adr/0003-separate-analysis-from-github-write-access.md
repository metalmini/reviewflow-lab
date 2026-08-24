# ADR 0003: Separate PR analysis from GitHub write access

- Status: Proposed; implementation added, live fork spike required
- Date: 2026-08-23

## Context

Pull requests from forks receive a read-only token and no secrets. ReviewFlow must still produce a visible PR comment without using an unsafe `pull_request_target` workflow or executing untrusted PR code with write access.

## Decision

Use two workflows:

1. A `pull_request` workflow analyses a diff using trusted analyzer code and a read-only token. Its status is attached to the PR.
2. A `workflow_run` workflow re-fetches and re-analyses the diff from trusted default-branch code, then writes one idempotent PR comment and acknowledgement status.

The privileged workflow must not check out the PR head, download artifacts, restore caches, execute repository content, interpolate untrusted values into a shell, or use secrets.

## Validation required

Sprint 0 must prove on a controlled fork PR that:

- the PR can be identified reliably from the completed workflow;
- the comment can be created and updated;
- a status can target the latest relevant SHA;
- stale runs cannot overwrite current findings;
- the workflow has only the declared permissions.

If this cannot be proven, automated fork comments are a no-go rather than a reason to introduce `pull_request_target`.

## Implementation state

The `Policy` pull-request workflow uses a read-only token. The separate `PR
Feedback` workflow runs only after `Policy` completes, never checks out source,
uses no artifact or cache handoff, rejects stale runs, and updates one marked
comment plus a status on the current head SHA. It is not a required check until
the controlled fork validation above succeeds.
