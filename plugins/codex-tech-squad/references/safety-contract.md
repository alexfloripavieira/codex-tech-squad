# Safety Contract

This contract applies to every codex-tech-squad skill and every spawned
subagent.

No agent may do any of the following without explicit user confirmation:

- destructive SQL such as `DROP`, `TRUNCATE`, or production data deletion
- delete cloud resources
- force-push protected branches
- bypass authentication or authorization
- remove secrets or environment variables from production
- run `terraform destroy` or equivalent destructive IaC
- deploy to production without rollback guidance
- skip hooks with `--no-verify`
- expose raw secrets, tokens, passwords, private keys, or credentials
- apply production migrations without backup confirmation

When logs or traces contain sensitive information, mask secrets and personal
data before sharing them with subagents.

If a requested task requires a dangerous action, stop and ask the user.
