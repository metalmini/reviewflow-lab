# Definition of Ready and Definition of Done

## Definition of Ready

An issue is Ready when:

- it names one observable result;
- scope and explicit non-goals are recorded;
- acceptance criteria are objectively testable;
- relevant files and ADRs are known;
- fixture and verification needs are described;
- security, privacy, dependency, AI, and cost impact are classified;
- required human choices have been made;
- it has no hidden dependency and is expected to fit in one pull request;
- the allowed agent context and repair limit are clear.

## Definition of Done

An increment is Done when:

- it was implemented on a branch and linked pull request;
- tests, code, and documentation are complete for the approved outcome;
- every required deterministic check is green;
- every warning is resolved or accepted by Michael with a recorded reason;
- no unapproved dependency, secret, provider, model download, or paid feature was introduced;
- relevant ADR, changelog, and micro-sprint evidence are updated;
- agent attempts and human corrections are recorded;
- Michael accepts the increment and performs the merge.
