# Docker sandbox for Claude Code

A Docker sandbox template for running Claude Code in an isolated environment. Supports both container (docker-compose) and microVM modes, with system tools, pnpm globals, and pre-installed Claude agents.

## Installation

```bash
curl -fsSL https://raw.githubusercontent.com/johnnybgoode/claude-sandbox/main/install.sh | bash
```

## Usage

Start the sandbox using the auto-configuring runner:
```bash
./sandbox.sh
```

The script reads your git config for name/email, builds the image if needed, and launches Claude Code in a docker microVm. To run Claude in a container, run:
```bash
./sandbox.sh --mode container
```

## What's included

- System tools (git, node, python, etc.)
- pnpm globals: typescript, typescript-language-server, @biomejs/biome
- beads (bd) and dolt for data version control
- Pre-cloned awesome-claude-code-subagents (~/subagents)
- LSP tools enabled for enhanced IDE support

## Persistence

The `agent-home` volume persists `/home/agent` across restarts, preserving Claude agents and configuration changes.
