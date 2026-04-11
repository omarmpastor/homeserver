deploy_stacks() {
  for s in "${STACKS[@]}"; do
    echo "[UP] $s"
    docker compose -p "$s" -f "$SCRIPT_DIR/$s/compose.yml" up -d
  done
}

down_stacks() {
  for s in "${STACKS[@]}"; do
    echo "[DOWN] $s"
    docker compose -p "$s" -f "$SCRIPT_DIR/$s/compose.yml" down || true
  done
}
