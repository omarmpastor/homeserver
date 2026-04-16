if ! docker network inspect traefik-net >/dev/null 2>&1; then
  docker network create --driver bridge traefik-net >/dev/null
fi

deploy_stack() {
  local STACK_NAME="$1"
  
  if [[ -z "$STACK_NAME" ]]; then
    echo "down_stack: falta nombre del stack"
    return 1
  fi

  local STACK_PATH="./stacks/$STACK_NAME"

  if [[ ! -d "$STACK_PATH" ]]; then
    echo "Stack no encontrado: $STACK_NAME"
    return 1
  fi

  echo "[UP] $STACK_NAME"
  docker compose -p "$STACK_NAME" -f "$SCRIPT_DIR/stacks/$STACK_NAME/compose.yml" up -d
}

down_stack() {
  local STACK_NAME="$1"
  
  if [[ -z "$STACK_NAME" ]]; then
    echo "down_stack: falta nombre del stack"
    return 1
  fi

  local STACK_PATH="./stacks/$STACK_NAME"

  if [[ ! -d "$STACK_PATH" ]]; then
    echo "Stack no encontrado: $STACK_NAME"
    return 1
  fi

  echo "[DOWN] $STACK_NAME"
  docker compose -p "$STACK_NAME" -f "$SCRIPT_DIR/stacks/$STACK_NAME/compose.yml" up -d
}

deploy_stacks() {
  for s in "${STACKS[@]}"; do
    echo "[UP] $s"
    docker compose -p "$s" -f "$SCRIPT_DIR/stacks/$s/compose.yml" up -d
  done
}

down_stacks() {
  for s in "${STACKS[@]}"; do
    echo "[DOWN] $s"
    docker compose -p "$s" -f "$SCRIPT_DIR/stacks/$s/compose.yml" down || true
  done
}
