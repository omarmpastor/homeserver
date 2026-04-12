pull_stacks() {
  for s in "${STACKS[@]}"; do
    echo "[PULL] $s"
    docker compose -p "$s" -f "$SCRIPT_DIR/stacks/$s/compose.yml" pull
  done
}

echo "[PULL] kopia"
docker compose -p "kopia" -f "$SCRIPT_DIR/stacks/kopia/compose.yml" pull
