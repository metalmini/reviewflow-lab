# AI policy

ReviewFlow Lab is an AI-assisted individual project. Michael Schouman is the product owner, human maintainer, and only person allowed to accept risks, merge pull requests, or approve releases.

## Allowed agent work

After Michael approves a micro-sprint, an AI agent may:

- refine an issue within its approved scope;
- create a feature branch;
- implement code, tests, and documentation;
- open and update a pull request;
- propose remediation and risk-acceptance wording;
- make at most one repair attempt per commit after an explicit request.

## Human-only decisions

Michael must approve:

- micro-sprint scope and acceptance;
- architecture and security decisions;
- dependencies with a material supply-chain impact;
- every warning acceptance;
- every merge and release;
- any secret, token, billing, hosted service, or remote AI provider.

## Prohibited agent actions

Agents must never:

- approve or merge a pull request;
- bypass a required check or branch rule;
- push directly to `main` after the documented bootstrap commit;
- create or change secrets, tokens, billing, or paid services;
- use `pull_request_target`;
- automatically retry in a loop;
- present the project as the work of a human Scrum team.

## Local models

Only the Ollama models already installed by Michael may be evaluated. The approved exact tags are `gemma4:latest` and `codeqwen:latest`; their recorded local metadata is in `docs/local-models.md`.

The project must not download another model automatically or connect to a remote model endpoint. The default provider is always `null`. Local AI output is advisory, schema-validated, and never controls a required status check.

## Context and token controls

- One active implementation issue and one primary agent.
- Prefer at most eight relevant files per task.
- Do not repeat full project context; reference this policy and the relevant ADRs.
- Run AI review only after deterministic checks pass.
- One local model request per command, no retries, bounded input and output.
- Record agent attempts, human corrections, and usefulness in the micro-sprint review.
