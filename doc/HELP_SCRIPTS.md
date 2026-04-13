# Uso de scripts de configuración y puesta en marcha

## Puesta en marcha

🧪 Primero ejecutamos una validación
```bash
stackctl dry-run
```

🔁 Pull de imagenes
```bash
stackctl pull
```

🚀 Deploy completo
```bash
stackctl up
```

### Otros comandos

⛔ Stop completo
```bash
stackctl down
```

💣 Borrado de datos
```bash
stackctl purge-volumes
```

📊 Estado
```bash
stackctl status
```

## Backups

Una vez levantemos los contenedores y los configuremos, levantamos el servicio de backup y hace el primer backup automáticamente

💾 Activar backups
```bash
backupsctl up
```

### Recovery

Si queremos llevar nuestro backup a otro servidor, podemos comprimir el repositorio y descomprimirlo en el destino
Siempre lo haremos con sudo ya que las copias están hechas con permisos de root
```bash
# Comprimirlo (y nos llevamos el tar.gz donde queramos)
sudo tar -czvf ~/backups.tar.gz /mnt/storage/backups

# Descomprimirlo (no tiene que existir la carpeta /mnt/storage/backups)
sudo tar -xvzf ~/backups.tar.gz -C /mnt/storage/
```

♻️ Ejecutamos el recovery que levanta el servicio, hace el restore y lo deja corriendo para que siga haciendo backups
```bash
backupsctl recovery
```

