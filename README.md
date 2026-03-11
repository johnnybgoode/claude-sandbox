# Docker sandbox for Claude Code

A Docker sandbox template for running Claude Code in an isolated environment. Supports both container (docker-compose) and microVM modes, with system tools, pnpm globals, and pre-installed Claude agents.

## Setup

Clone the template files into your project:
```bash
git clone --depth 1 <repo> && cp -r Dockerfile docker* .dockerignore /path/to/project
```

## Usage

Start the sandbox using the auto-configuring runner:
```bash
./sandbox-start.sh
```

The script reads your git config for name/email, builds the image if needed, and launches Claude Code in container mode (default). To use microVM mode:
```bash
./sandbox-start.sh --mode sandbox
```

## What's included

- System tools (git, node, python, etc.)
- pnpm globals: typescript, typescript-language-server, @biomejs/biome
- beads (bd) and dolt for data version control
- Pre-cloned awesome-claude-code-subagents (~/subagents)
- LSP tools enabled for enhanced IDE support

## Persistence

The `agent-home` volume persists `/home/agent` across restarts, preserving Claude agents and configuration changes.
