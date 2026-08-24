# Product one-pager

## Problem

PHP/Symfony pull requests can contain changes whose risk, test impact, and need for human attention are not immediately visible. Generic AI review can be noisy, opaque, externally processed, or cost-sensitive.

## Primary user

A human PHP/Symfony maintainer reviewing a pull request.

Pull-request authors and AI repair agents are secondary users who need concrete, traceable feedback.

## Hypothesis

Explainable deterministic analysis, optionally enriched by local AI, helps reviewers focus on important changes without transferring approval or accountability to software.

## Value

- Earlier signals about review risk and missing tests.
- Traceable reasons and suggested test scenarios.
- A stable interface that repair agents can act on.
- A public experiment in cost-controlled, responsible AI-assisted development.

## MVP success criteria

- Detect at least 80% of seeded high-confidence risks.
- Produce zero blocking false positives.
- Complete deterministic analysis within 60 seconds.
- After at least five real project pull requests, Michael rates at least 70% of warnings as useful.
- Use no paid external service, secret, or remote model call.

If a core threshold remains unmet after one focused improvement micro-sprint, the project stops or the hypothesis is reconsidered.

## Non-goals

- Approving or merging pull requests.
- Accepting risk automatically.
- Replacing human review, PHPStan, security scanning, or tests.
- Language-agnostic analysis in the MVP.
- A hosted service, dashboard, database, Marketplace app, or remote AI provider.
- Packagist or binary distribution in the MVP.
