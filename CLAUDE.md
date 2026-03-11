# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This repository is a Docker sandbox template for running Claude Code in an isolated environment. It supports two deployment modes: a Docker container (via `docker-compose`) and a microVM (via `docker sandbox` / `run.sh`).

## Usage

### Docker Compose (container mode)
```bash
GIT_USER="<your name>" GIT_EMAIL="<your email>" \
  docker compose up -d && \
  docker compose exec -it sandbox-dev claude
```

### microVM mode
```bash
# Uses run.sh which auto-builds and creates the sandbox
./run.sh
```

`run.sh` reads git config for `GIT_USER`/`GIT_EMAIL`, builds the image if needed (`claude-sandbox:latest`), creates a sandbox named `claude-sb-<dirname>`, and runs it.

## Architecture

### Key files
- **`Dockerfile`** — builds from `docker/sandbox-templates:claude-code`; installs system tools, pnpm globals (`typescript`, `typescript-language-server`, `@biomejs/biome`), `beads` (bd), and `dolt`; clones `johnnybgoode/awesome-claude-code-subagents` to `~/subagents`
- **`docker-entrypoint.sh`** — runs on every container start; applies `GIT_USER`/`GIT_EMAIL` to both git and dolt global config; installs Claude agents from `~/subagents` to `~/.claude/agents` on first boot only (agent-home volume persists)
- **`docker-compose.yaml`** — mounts the project directory to `/app` and uses a named `agent-home` volume for `/home/agent` persistence across restarts; sets `IS_SANDBOX=0` and `ENABLE_LSP_TOOLS=1`
- **`run.sh`** — helper for microVM mode using `docker sandbox` CLI

### Environment variables
| Variable | Default | Purpose |
|---|---|---|
| `GIT_USER` | `TestUser` | Git/dolt author name |
| `GIT_EMAIL` | `test@example.com` | Git/dolt author email |
| `IS_SANDBOX` | `0` (compose) / `1` (image) | Signals sandbox context |
| `ENABLE_LSP_TOOLS` | `1` | Enables LSP tooling in Claude Code |
| `EDITOR` | `vim` | Default editor |

### Volume persistence
The `agent-home` volume persists `/home/agent` between container restarts. This means Claude agents are only installed on first boot, and pnpm/git config changes made inside the container survive restarts.

## Deployment notes
- The `docker-compose.yaml` service is named `sandbox-dev` (not `sandbox`) — use `docker compose exec sandbox-dev bash`
- To copy these files into a target project: `cp Dockerfile docker-compose.yaml docker-entrypoint.sh /path/to/project`
- The `run.sh` microVM mode uses `docker sandbox` (not standard Docker) — requires Docker sandbox extension
