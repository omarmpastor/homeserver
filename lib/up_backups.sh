create_volumes() {
  for v in "${VOLUMES[@]}"; do
    if docker volume inspect "$v" >/dev/null 2>&1; then
      echo "[OK] volumen existe: $v"
    else
      echo "[CREATE] $v"
      docker volume create "$v" >/dev/null
    fi
  done
}

if docker volume inspect "kopia_config" >/dev/null 2>&1; then
    echo "[OK] volumen existe: kopia_config"
else
    echo "[CREATE] kopia_config"
    docker volume create "kopia_config" >/dev/null
fi

echo "[UP] $s"
docker compose -p "$s" -f "$SCRIPT_DIR/stacks/kopia/compose.yml" up -d

