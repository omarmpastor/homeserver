if ! docker network inspect traefik-net >/dev/null 2>&1; then
  docker network create --driver bridge traefik-net >/dev/null
fi

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
