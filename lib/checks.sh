check_structure() {
  echo "[CHECK] Estructura de stacks..."

  for s in "${STACKS[@]}"; do
    if [[ ! -d "$SCRIPT_DIR/stacks/$s" ]]; then
      echo "[ERROR] Falta directorio: $s"
      exit 1
    fi

    if [[ ! -f "$SCRIPT_DIR/stacks/$s/compose.yml" ]]; then
      echo "[ERROR] Falta compose.yml en $s"
      exit 1
    fi
  done

  echo "[OK] Estructura válida"
}

check_volumes() {
  echo "[CHECK] Volúmenes..."

  for v in "${VOLUMES[@]}"; do
    if docker volume inspect "$v" >/dev/null 2>&1; then
      echo "[OK] $v"
    else
      echo "[MISSING] $v"
    fi
  done
}
