# CLAUDE.md — Claude Code instructions

See README.md for project overview and setup.

## Build & Validate

```bash
shellcheck -x ethd scripts/check_sync.sh
pre-commit run --all-files
cp default.env .env && ./ethd update --debug --non-interactive
```

## Code Style

- Shell: `set -Eeuo pipefail` in ethd, `set -euo pipefail` in other scripts
- Env vars: `SCREAMING_SNAKE_CASE`, no dashes
- Env var suffixes: `_VERSION` = build targets
- Compose services: kebab-case; CLI commands: kebab-case; bash functions: snake_case

## Critical Rules

- Do NOT modify core infrastructure functions in `ethd` — customize only protocol-specific sections
- Increment `ENV_VERSION` in `default.env` when adding or renaming variables
- check_sync.sh exit codes: 0=synced, 1=syncing, 2=diverged, 3=local RPC error, 4=public RPC error, 5=config error, 6=dependency error, 7=container error
- New env vars consumed by entrypoint.sh must also be added to the compose `environment:` block

## Architecture

- AB Core is a geth fork — binary downloaded from `ABFoundationGlobal/abcore` GitHub releases
- Deploy package (config, genesis, bootnodes) from `ABFoundationGlobal/ab-deploy` releases
- Custom Dockerfile in `node/Dockerfile.binary` builds the image at deploy time
- Entrypoint handles genesis init and geth startup
- Data lives at `/data/abcore/mainnet/` inside the container
