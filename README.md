# ReviewFlow Lab

ReviewFlow Lab is an experimental PHP/Symfony pull-request risk analyzer.

The project explores explainable, human-in-the-loop review support. It can highlight changes that deserve additional attention, but it never approves or merges pull requests and never replaces human accountability.

The initial implementation is being developed as an AI-assisted individual project led and accepted by Michael Schouman.

## Status

Sprint 0: research, governance, cost controls, and security validation.

No remote AI provider is enabled. The deterministic analyzer will be the always-available foundation; optional AI experiments will run locally through Ollama only.

## Project principles

- Human accountability: AI may assist, but only the human maintainer accepts risks, merges, and releases.
- Deterministic first: reproducible rules remain available without model inference.
- Zero surprise billing: external services have a hard budget of EUR 0.
- Untrusted by default: pull-request content is data, never an instruction source.
- Evidence over claims: fixtures, pull requests, ADRs, and micro-sprint reviews record results.

## Governance

- [AI policy](AI_POLICY.md)
- [Cost policy](COSTS.md)
- [Governance](GOVERNANCE.md)
- [Security policy](SECURITY.md)
- [Architecture decisions](docs/adr/)
- [Sprint 0](docs/sprints/sprint-0.md)

## License

[MIT](LICENSE)
