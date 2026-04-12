create_backup_volumes() {
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

delete_backup_volumes() {
  echo "⚠️ ATENCIÓN: Esto eliminará TODOS los volúmenes definidos"
  read -rp "Escribe YES para continuar: " confirm

  if [[ "$confirm" != "YES" ]]; then
    echo "[ABORTED]"
    exit 0
  fi

  for v in "${VOLUMES[@]}"; do
    docker volume rm "$v" 2>/dev/null || true
    echo "[DELETED] $v"
  done

  docker volume rm "kopia_config" 2>/dev/null || true
  echo "[DELETED] kopia_config"
}

create_kopia_service() {
  echo "[UP] kopia"
  docker compose -p "kopia" -f "$SCRIPT_DIR/stacks/kopia/compose.yml" up -d
}

configure_kopia() {
  echo "[CREATE] Local repository"
  docker compose -p "kopia" -f "$SCRIPT_DIR/stacks/kopia/compose.yml" exec kopia kopia repository create filesystem --path=/repository
  echo "[CONFIGURE] Retention Policy"
  docker compose -p "kopia" -f "$SCRIPT_DIR/stacks/kopia/compose.yml" exec kopia kopia policy set --global --keep-latest=1 --keep-hourly=8 --keep-daily=2 --keep-weekly=1 --keep-monthly=1 --keep-annual=0
  docker compose -p "kopia" -f "$SCRIPT_DIR/stacks/kopia/compose.yml" exec kopia kopia snapshot create /data --tags=type:first
}

recovery_latest_snapshot() {
  echo "[CREATE??] Local repository"
  docker compose -p "kopia" -f "$SCRIPT_DIR/stacks/kopia/compose.yml" exec -e KOPIA_PASSWORD="$APP_PASSWORD" kopia kopia repository connect filesystem --path=/repository --override-username="$APP_USER"
  
  echo "[RECOVERY] Latest snapshot"
  #docker compose -p "kopia" -f "$SCRIPT_DIR/stacks/kopia/compose.yml" exec kopia kopia restore latest /restore-path
}
