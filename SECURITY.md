# Security policy

## Reporting a vulnerability

Do not open a public issue for a vulnerability that could put users, credentials, or repositories at risk. Contact Michael Schouman through the private contact route published at https://schouman.info/contact/ and include only the minimum information needed to reproduce the problem.

Do not include real secrets, access tokens, private source code, or personal data in a report.

## Supported versions

Until the first stable release, only the latest tagged `0.x` release and the default branch receive security fixes.

## Actions threat model

Pull-request content is untrusted, including code, diffs, filenames, comments, commit messages, and generated artifacts.

Security requirements:

- least-privilege `GITHUB_TOKEN` permissions;
- no secrets in pull-request workflows;
- no `pull_request_target` event;
- no privileged checkout or execution of a PR head;
- no cache or artifact handoff from an untrusted workflow to a privileged workflow;
- no shell interpolation of untrusted GitHub context;
- external Actions pinned to full commit SHAs;
- short timeouts and per-PR concurrency;
- logs contain no secrets or complete model prompts;
- local model output is treated as untrusted data.

Same-repository agent branches may run tests in an ephemeral runner with no secrets and a read-only token. External fork code is never executed automatically; a maintainer must explicitly mark it safe to test first.

## Prompt injection

Repository content never becomes an instruction source. AI prompts separate trusted policy from untrusted evidence, do not include PR comments by default, expose no tools, and require schema-valid output. AI output is advisory and cannot approve, merge, accept risk, or control a required status check.

## Supply chain

- Commit Composer lock files.
- Disable Composer plugins and scripts where they are not required.
- Review new dependencies before merge.
- Enable the dependency graph and Dependabot alerts.
- Pin GitHub Actions to full commit SHAs.
- Do not rely on mutable tags for executable workflow dependencies.
