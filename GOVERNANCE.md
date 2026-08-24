# Governance

## Project model

ReviewFlow Lab is an AI-assisted individual project. It does not claim to have a human Scrum team.

- Michael Schouman: product owner, Scrum Master, human maintainer, risk owner, and release approver.
- AI agents: analysis, refinement, implementation, tests, documentation, code-review preparation, and release preparation within approved scope.

## Micro-sprints

Micro-sprints are outcome-based and have no fixed duration.

1. Michael approves one sprint goal.
2. Prefer one issue and one observable result.
3. An agent implements through a feature branch and pull request.
4. Deterministic checks run before AI review.
5. Michael accepts, redirects, or stops the increment.
6. A short review and retrospective record evidence, agent usage, and learning.

Only one implementation item may be in progress at a time.

## Pull requests and merge authority

- All development after the bootstrap commit goes through pull requests.
- Required checks must be green.
- Every warning is resolved or explicitly accepted by `metalmini` with a reason.
- Agents may propose an acceptance reason but may not submit the human acceptance decision.
- Auto-merge is disabled.
- Only Michael may merge.

Because local agents can operate through Michael's GitHub identity, GitHub cannot independently prove whether a command was typed by a human. Until a separately approved bot identity exists, the human-only merge boundary is enforced by agent policy, required checks, and explicit human acceptance records.

## Risk acceptance

PR-specific acceptance is recorded in a comment linked to a stable finding fingerprint. Repository-wide acceptance is stored in `.reviewflow/accepted-risks.yaml` and includes scope, reason, owner, evidence, and an expiry date.

An agent may draft a registry change, but Michael must explicitly approve it before merge.
