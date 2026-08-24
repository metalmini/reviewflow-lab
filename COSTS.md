# Cost policy

ReviewFlow Lab has a hard external-services budget of **EUR 0 per month**.

Conditions were reviewed against the official GitHub documentation on 2026-08-23. They must be checked again before enabling a new metered feature.

## Allowed GitHub usage

- One public repository under `metalmini`.
- Issues, pull requests, milestones, and one public GitHub Project.
- Standard GitHub-hosted Linux runners for the public repository.
- Dependency graph, Dependabot alerts, public secret scanning, and push protection.
- GitHub Releases without uploaded binary assets during the MVP.

## Prohibited usage

- Larger or paid runners.
- GitHub Codespaces, Packages, LFS, or paid hosting.
- GitHub Marketplace applications.
- Actions artifacts and dependency caches during the MVP.
- Remote LLM inference, paid APIs, BYOK providers, or GitHub Models in workflows.
- Any billing, secret, or payment change without Michael's separate approval.

## Technical controls

- Workflow jobs use `ubuntu-latest` only and have a timeout of at most 10 minutes.
- Pull-request jobs use concurrency with stale runs cancelled.
- Workflow permissions default to none and are granted per job.
- Every external Action is pinned to a full commit SHA.
- Workflows containing `pull_request_target`, `upload-artifact`, cache actions, secret references, remote model endpoints, or non-standard runner labels fail policy validation.
- No workflow may silently download an Ollama model.

## Verified platform limits

| Feature | Free boundary | Behaviour at the boundary | Guardrail |
| --- | --- | --- | --- |
| Standard Actions runners | Free and unlimited for public repositories | GitHub applies platform execution limits | Public repository and standard Linux label only |
| Actions job | 6-hour platform maximum | Job is terminated | Project timeout: 5-10 minutes |
| Actions artifacts | 500 MB included on GitHub Free | Overage may be billable | Artifacts forbidden |
| Actions cache | 10 GB default per repository | Eviction; expanded use can be billable | Cache forbidden |
| Project | 50,000 items and 50 fields | Items must be removed to add more | One project, at most five custom fields |
| `GITHUB_TOKEN` REST API | 1,000 requests/hour/repository | Requests are rate-limited | At most 20 requests per run |
| Commit statuses | 1,000 per SHA and context | Validation error | Reuse one context per check |
| Rulesets | 75 per repository | No additional ruleset can be added | One `main` ruleset |

## Billing verification gate

Before the first workflow is enabled, Sprint 0 must record a read-only billing and repository-settings check. A hard zero-dollar Actions or AI-credit budget is desirable but changing billing settings requires separate explicit permission.

Official references:

- https://docs.github.com/en/actions/reference/runners/github-hosted-runners
- https://docs.github.com/en/billing/concepts/product-billing/github-actions
- https://docs.github.com/en/billing/how-tos/set-up-budgets
- https://docs.github.com/en/actions/reference/workflows-and-actions/dependency-caching
- https://docs.github.com/en/rest/using-the-rest-api/rate-limits-for-the-rest-api
- https://docs.github.com/en/rest/commits/statuses
- https://docs.github.com/en/issues/planning-and-tracking-with-projects/managing-items-in-your-project/adding-items-to-your-project
