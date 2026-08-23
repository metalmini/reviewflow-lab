# ADR 0001: Use a standalone Symfony Console application

- Status: Accepted
- Date: 2026-08-23

## Context

ReviewFlow Lab needs a local, testable interface for analysing pull-request diffs. A web application would add hosting, authentication, persistence, and operational cost before those capabilities provide product value.

## Decision

Build a standalone PHP 8.2+ CLI with the Symfony 7.4 LTS Console component. Do not use FrameworkBundle, HttpKernel, a database, or a hosted service in the MVP.

## Consequences

- The same analysis path can run locally and in GitHub Actions.
- The architecture remains aligned with Michael's PHP/Symfony profile.
- A future GitHub App or web UI requires a separate decision.
- Distribution is source-based during the MVP; Packagist and PHAR publication are out of scope.

## Alternatives rejected

- Full Symfony web application: unnecessary hosting and attack surface.
- GitHub App as the primary runtime: requires credentials and a hosted endpoint.
- Shell-only implementation: less suitable for a maintainable rule engine and automated tests.
