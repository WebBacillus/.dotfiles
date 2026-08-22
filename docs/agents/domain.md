# Domain Docs

This repository uses a single-context domain-documentation layout.

## Before exploring

- Read `CONTEXT.md` at the repository root when it exists.
- Read ADRs under `docs/adr/` that affect the area being changed.
- If these paths do not exist, proceed silently. Domain documentation is created lazily when decisions or terminology need to be recorded.

## Use the documented vocabulary

When output names a domain concept in an issue, proposal, hypothesis, or test, use the term defined in `CONTEXT.md`. Avoid synonyms that the glossary explicitly excludes.

If a needed concept is absent, reconsider whether the term belongs to the project; otherwise note the gap for a future documentation session.

## Flag ADR conflicts

If proposed work contradicts an existing ADR, identify the conflict explicitly rather than silently overriding the decision.
