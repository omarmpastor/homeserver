load_env() {
  if [[ ! -f "$SCRIPT_DIR/.env" ]]; then
    echo "[ERROR] .env no encontrado"
    exit 1
  fi

  echo "[INFO] Cargando .env"
  set -a
  source "$SCRIPT_DIR/.env"
  set +a
}
