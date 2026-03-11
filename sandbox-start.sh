#!/usr/bin/env bash

GIT_USER=$(git config get user.name)
GIT_EMAIL=$(git config get user.email)

IMAGE_REF="claude-sandbox:latest"
IMAGE=$(docker image ls --filter "reference=$IMAGE_REF" --format json)

SANDBOX_MODE="container"
SANDBOX_REF="claude-sb-${PWD##*/}"

build() {
  if [ -z "$IMAGE" ]; then 
    echo 'Building image...'
    docker build --no-cache -t $IMAGE_REF -f Dockerfile .
  fi
}

createSandbox() {
  SANDBOX=$(docker sandbox ls --json | tr "\n" ' ' | sed -E 's/[[:space:]]+/ /g' | grep "$SANDBOX_REF")
  if [ -z "$SANDBOX" ]; then
    docker sandbox create -t $IMAGE_REF --name "$SANDBOX_REF" claude .
  fi
}

runSandbox() {
  GIT_USER="$GIT_USER" GIT_EMAIL="$GIT_EMAIL" docker sandbox run "$SANDBOX_REF" claude .
}

runContainer() {
  GIT_USER="$GIT_USER" GIT_EMAIL="$GIT_EMAIL" docker compose run sandbox
}

while [[ $# -gt 0 ]]; do
    case "$1" in
        --mode)
            case "${2:-}" in
                container)  SANDBOX_MODE="container" ;;
                sandbox) SANDBOX_MODE="sandbox" ;;
                *)
                    usage; exit 1
                    ;;
            esac
            shift 2
            ;;
        *)
            usage; exit 1
            ;;
    esac
done

build

if [ "$SANDBOX_MODE" = "container" ]; then
  runContainer
else
  #createSandbox
  runSandbox
fi

