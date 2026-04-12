#echo "[RECOVERY] Latest snapshot"
#docker compose -p "$s" -f "$SCRIPT_DIR/stacks/kopia/compose.yml" exec kopia restore latest /restore-path
