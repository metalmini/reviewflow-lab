# Sprint 0: Research and foundation

## Goal

Create a public, zero-billing, security-conscious foundation from which every development increment can proceed through an issue, branch, pull request, and human acceptance.

## Planned increment

- Public `metalmini/reviewflow-lab` repository with MIT license.
- One documented bootstrap commit followed by protected pull-request development.
- Governance, AI, security, and cost policies.
- Initial ADRs and repository contribution templates.
- Read-only validation of GitHub billing and security settings.
- A safe fork-PR comment/status spike before enabling required workflows.

## Acceptance criteria

- No paid service, secret, hosted endpoint, or remote model provider exists.
- `main` receives no product development directly after bootstrap.
- Only Michael can accept risk, merge, and approve releases.
- The exact already-installed Ollama model names and metadata are recorded; no model is downloaded.
- The proposed workflow boundary is proven or explicitly rejected.
- Sprint review records evidence, residual risks, and the next go/no-go decision.

## Current status

In progress. The public repository, project, labels, milestone, merge policy,
Actions permissions, retention, and initial security settings are configured.
Local model metadata has been recorded. The read-only `policy` workflow passed
on the foundation pull request and is part of the protected-branch gate. The
separate comment/status workflow is statically validated but cannot run until
it exists on the default branch. Live fork validation and human review remain
before Sprint 0 can be accepted.

## Review and retrospective

To be completed before Sprint 0 is accepted.
