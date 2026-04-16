# Security

Do not place secrets, credentials, tokens, database URLs, private keys, or raw
customer data in plugin files, examples, logs, or release artifacts.

If a workflow receives logs or stack traces, mask:

- tokens
- passwords
- API keys
- bearer headers
- private emails when not needed
- personal identifiers when not needed

For security-sensitive code changes, use `codex-tech-squad:security-audit` or
include a `security-reviewer` in the requested team.
