# Workflow Contracts

## Agent Task Contract

Every spawned agent prompt should include:

- specialist role
- mission
- scope
- ownership
- edit permission or read-only instruction
- expected output

## Worker Ownership

Workers must receive disjoint ownership. Examples:

- backend service files only
- test files only
- docs only
- one package or module
- one UI route or component group

## Final Output Contract

The final answer should mention:

- team used
- files changed
- verification run
- known limitations or follow-up risks

Keep it concise.

## Quality Gates

Run the most relevant checks available:

- unit tests for changed behavior
- typecheck or lint when cheap and established
- focused integration tests when the change crosses boundaries
- manual verification steps when automation is not available

If checks fail due to pre-existing issues, say that and include the relevant
failure summary.
