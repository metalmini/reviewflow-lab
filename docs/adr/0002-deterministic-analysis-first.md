# ADR 0002: Deterministic analysis is the mandatory foundation

- Status: Accepted
- Date: 2026-08-23

## Context

Remote AI can introduce variable cost, privacy exposure, prompt injection, rate limits, and non-reproducible results. The product must always work without paid inference.

## Decision

Implement deterministic rules, stable fingerprints, structured findings, and test scenarios before any AI provider. The default provider is `null`.

Only already-installed Ollama models approved by Michael may be evaluated locally. AI findings remain advisory, require schema validation, and never determine a required status check.

## Consequences

- Core results are reproducible and zero-cost.
- AI value can be measured against a fixed baseline.
- Some semantic risks will remain undetected by the MVP.
- No model is downloaded automatically and no remote provider is enabled.
