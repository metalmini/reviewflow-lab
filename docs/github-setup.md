# Proposed GitHub setup

This document is the source of truth for Sprint 0 GitHub configuration. Settings are applied only after they are validated against the public repository and current official GitHub documentation.

## Repository

- Owner: `metalmini`
- Name: `reviewflow-lab`
- Visibility: public
- License: MIT
- Default branch: `main`
- Issues: enabled
- Wiki: disabled
- Discussions: disabled during the MVP
- Merge method: squash only
- Automatically delete head branches: enabled
- Auto-merge: disabled

## Labels

| Label | Purpose |
| --- | --- |
| `type:feature` | Technical or product improvement |
| `type:bug` | Reproducible defect |
| `type:research` | Time-boxed uncertainty or spike |
| `type:rule` | Deterministic analysis rule |
| `type:docs` | Documentation-only outcome |
| `area:cli` | Console interface |
| `area:analysis` | Rule engine and findings |
| `area:github` | Actions, comments, and statuses |
| `area:ai` | Optional local provider |
| `area:security` | Security or supply chain |
| `priority:p0` | Must resolve before progress |
| `priority:p1` | Current hypothesis-critical work |
| `priority:p2` | Useful but deferrable work |
| `status:needs-decision` | Human decision required |
| `status:ready` | Meets the Definition of Ready |
| `status:blocked` | Cannot progress within approved scope |
| `ai:eligible` | Suitable for scoped agent execution |
| `ai:repair-requested` | One agent repair attempt requested |
| `risk:cost` | Billing or quota risk |
| `risk:security` | Security boundary or vulnerability risk |
| `risk:privacy` | Personal or repository data risk |

## Project

One public personal project named `ReviewFlow Lab`.

Fields:

- Status: Backlog, Ready, In Progress, Review, Done
- Priority: P0, P1, P2
- Micro-sprint: text
- Executor: AI, Michael, Shared

Only one implementation item may be In Progress. Milestones group releases, starting with `v0.1.0`; they do not represent calendar sprints.

## Main ruleset

Target: default branch.

- Require a pull request.
- Require conversation resolution.
- Require linear history.
- Block force pushes and deletion.
- Initially require only validated checks that have completed successfully at least once.
- Intended checks: `policy`, `ci/php`, `reviewflow/analyze`, and `reviewflow/acknowledgements`.
- No agent bypass.

## Actions settings

- Default workflow token permission: read-only.
- Workflows may not approve pull requests.
- Only actions owned by GitHub or explicitly reviewed and pinned third-party actions.
- Artifact and log retention: seven days if the account setting permits it.
- No cache increase, larger runners, or paid capacity.

## Security settings

- Dependency graph: enabled.
- Dependabot alerts and security updates: enabled.
- Secret scanning and push protection for the public repository: enabled.
- A future CodeQL workflow requires a separate review of code-execution behaviour and workflow cost.

## Bootstrap record

One direct `main` bootstrap commit is permitted because a default branch is required before pull-request protections can be established. It contains only `README.md`, `LICENSE`, and `.gitignore`. Every later change uses a pull request.
