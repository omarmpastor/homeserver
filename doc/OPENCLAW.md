# Instalar OpenClaw en Docker

## Ollama

Debemos tener funcionando ollama, si no es así activamos el servicio Ollama en  `roles/containers/vars/main.yml` y ejecutamos de nuevo `ansible-playbook site.yml`

Descargamos un modelo acorde con la potencia de nuestro equipo, yo voy a usar uno pequeño
```bash
docker exec ollama ollama pull qwen3.5:4b
```

## OpenClaw

Descargamos la imagen
```bash
docker pull ghcr.io/openclaw/openclaw:latest
```

Descargamos el repo
```bash
# Clonamos el repo
git clone --depth 1 https://github.com/openclaw/openclaw.git
sudo mv openclaw /opt/
```

Ejecutamos el script de instalación
```bash
cd /opt/openclaw
export OPENCLAW_IMAGE="ghcr.io/openclaw/openclaw:latest"
./scripts/docker/setup.sh
```

Seguimos el asistente:
* How would you like to start? -> Quick start
* What would you like to create? -> One agent
* What should we call your first agent? > main
* Model/auth provider > Ollama
* Ollama auth method > Ollama
* Ollama mode > Local only
*  Ollama base URL: http://host.docker.internal:11434
* Default model: Keep current (ollama/qwen3.5:4b)

### Configuración

Vamos a sacar el token para conectarnos
```bash
docker compose -f /opt/openclaw/docker-compose.yml exec openclaw-gateway openclaw gateway auth-token --show
```

Ejecutamos desde una máquina con navegador (creamos un tunel)
```bash
ssh -N -L 18789:127.0.0.1:18789 user@IP
ssh -N -L 18789:127.0.0.1:18789 sysroot@192.168.1.100
```

Y nos conectamos a http://127.0.0.1:18789/
