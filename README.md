# Docker sandbox for Claude Code


## Installation

```
git clone --depth 1 ...
cp Dockerfile docker* /path/to/project
```

## Useage 

```
# container
GIT_USER="<your name>" GIT_EMAIL="<your email>" \
  docker compose up -d && \
  docker compose exec -it sandbox claude

# microvm
docker build -t claude-sandbox:latest && \
  docker sandbox create -t claude-sandbox:latest claude /project/dir

docker sandbox run claude-sandbox.<project>
```
