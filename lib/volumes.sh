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

delete_volumes() {
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
}
