create_volumes() {
  for v in "${VOLUMES[@]}"; do
    if docker volume inspect "$v" >/dev/null 2>&1; then
      echo "[EXISTS] volumen existe: $v"
    else
      echo "[CREATE] $v"
      docker volume create "$v" >/dev/null
    fi
  done

  if docker volume inspect "kopia_config" >/dev/null 2>&1; then
      echo "[EXISTS] volumen existe: kopia_config"
  else
      echo "[CREATE] kopia_config"
      docker volume create "kopia_config" >/dev/null
  fi
}

create_kopia_service() {
  echo "[UP] $s"
  docker compose -p "$s" -f "$SCRIPT_DIR/stacks/kopia/compose.yml" up -d
}

configure_kopia() {
  echo "[CREATE] Local repository"
  docker compose -p "$s" -f "$SCRIPT_DIR/stacks/kopia/compose.yml" exec kopia kopia repository create filesystem --path=/repository
  echo "[CONFIGURE] Retention Policy"
  docker compose -p "$s" -f "$SCRIPT_DIR/stacks/kopia/compose.yml" exec kopia kopia policy set --global --keep-latest=1 --keep-hourly=8 --keep-daily=2 --keep-weekly=1 --keep-monthly=1 --keep-annual=0
}
