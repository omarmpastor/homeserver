# Configuración de apps y servicios

Ahora vamos a ir configurando las apps

## Dockhand

Vamos a http://dockhand.omp.home

* Settings > Environments > Add Environment
  * Name: Docker
  * Connection type: Unix socket
  * Source path: /var/run/docker.sock
* Settings > Authentication > Users
  * Añadimos un usuario
  * Hay un botón de Authentication > Lo activamos y se pone en on

## Heimdall dashboard

Añadimos las apps:
* https://cockpit.omp.home:9090
* http://gitea.omp.home
* http://qbittorrent.omp.home
* http://jellyfin.omp.home
* http://prowlarr.omp.home
* http://radarr.omp.home
* http://sonarr.omp.home
* http://bazarr.omp.home
* http://joplin.omp.home
* http://sftpgo.omp.home
* http://kopia.omp.home
* http://metube.omp.home
* http://dockhand.omp.home
* http://syncthing.omp.home

## sFTPgo

Vamos a http://sftpgo.omp.home/

* Creamos un usuario adminsitrador
* Dentro ya del administrado vamos a http://sftpgo.omp.home/web/admin/users y creamos un usuario

## Syncthing

Vamos a http://syncthing.omp.home/

Vamos a Acciones > Ajustes > Interfaz gráfica y añadimos:
* Usuario de la interfaz gráfica
* Contraseña de la interfaz gráfica

Ahora desde el dashboard pinchamos en el botón "+ Añadir carpeta"
* Etiqueta de la carpeta: Homesync
* ID de la carpeta: El que nos da por defecto
* Ruta de la carpeta: /data/homesync

Luego cuando añadamos un dispositivo a la sincronización, tendremos que habilitar la compartición en esta carpeta

## qBittorrent

Lo primero necesitamos conocer el password que nos ha puesto por defecto. Esto está en los logs del contenedor (Ejecutamos: `docker logs qbittorrent`)

Vamos a http://qbittorrent.omp.home

Entramos en la interfaz con `admin` y el password temporal que nos ha creado:
- Vamos a Tools > Options > WebUI y cambiamos el password. Si no queremos que nos pida usuario y contraseña, marcamos: `Bypass authentication for clients in whitelisted IP subnets` y le añadimos nuestra red `192.168.1.0/24`
- Vamos a Tools > Options > Behavior > User interface language > Español

### Sonarr/Radarr

Nos conectamos a http://radarr.omp.home para radarr y http://sonarr.omp.home para sonarr

La primera vez que nos conectemos nos pedira que establezcamos un login:

* Authentication Method: Form (Login Page)
* Authentication Required: Disabled for Local Addresses
* Username: [username]
* Password: [password]

Vamos a Settings -> Media Management -> Pinchamos en el icono de arriba "Show Advanced"
- Dejamos marcado -> Use Hardlinks instead of Copy
- Al final en el botón Add Root Folder, añadimos -> "/storage/Movies/" para radarr y "/storage/TV/"
- Guardamos cambios

Vamos a Settings -> Download Clients -> + -> qBittorrent
- Host: qbittorrent
- Port: 8090
- Username: [username]
- Password: [password]
- Dejamos marcado: Remove imported downloads from dowload client history

Vamos a Settings -> Profiles -> Entramos a cada uno de ellos -> Language -> Spanish (sino no nos busara en prowlarr en español)

### Jackett

Nos conectamos a http://jackett.omp.home

Ponemos una contraseña de administrador en [Admin password]
Pinchamos en Add Indexer -> DonTorrent (tarda en añadirlo, comprueba un rato)

### Prowlarr

Nos conectamos a http://prowlarr.omp.home

La primera vez que nos conectemos nos pedira que establezcamos un login:

* Authentication Method: Form (Login Page)
* Authentication Required: Disabled for Local Addresses
* Username: [username]
* Password: [password]

Vamos a Settings -> Apps -> Añadimos Radarr
Prowlarr Server: http://prowlarr:9696
Radarr Server: http://radarr:7878
API Key: Vamos a radarr -> Settings -> General -> API Key y la copiamos

Vamos a Settings -> Apps -> Añadimos Sonarr
Prowlarr Server: http://prowlarr:9696
Sonarr Server: http://sonarr:8989
API Key: Vamos a sonarr -> Settings -> General -> API Key y la copiamos

Vamos a Settings -> Download Clients -> + -> qBittorrent
- Host: qbittorrent
- Port: 8090
- Username: [username]
- Password: [password]

Ahora vamos a Indexers (No a Settings > Indexers) -> Add Indexer y añadimos los que queramos

* Elitetorrent-wf
* MoviesDVDR
* Vamos a añadir DonTorrent desde Jackett (no me va!!):
  * Le damos a añadir y elegimos "Generic Torznab"
  * Name: DonTorrent
  * Enable: Activado
  * Redirect: Desactivado
  * URL (hay un botón "Copy Torznab Feed" en jackett): http://[IP_SERVIDOR]:9117/api/v2.0/indexers/dontorrent/results/torznab/
  * API Key: Copiamos la API key de Jackett
  * Pinchamos en Test y Guardamos

## Jellyfin

Arrancamos el proyecto: Desde arcane > Proyectos > Elegimos jellyfin > Subir

Vamos a http://jellyfin.omp.home

Usamos el asistente para configurar el servidor estableciendo en Español y poniendo usuario y contraseña:
* Username: [username]
* Password: [password]

Configuramos 4 bibliotecas multimedia
- Tipo: Peliculas, Nombre: Peliculas, Carpetas: /data/movies, Idioma preferido de visualizado: Spanish Castillian, Pais: Spain
- Tipo: Series, Nombre: Series, Carpetas: /data/tvshows, Idioma preferido de visualizado: Spanish Castillian, Pais: Spain
- Tipo: Vídeos caseros y fotos, Nombre: Vídeos, Carpetas: /data/videos
- Tipo: Vídeos caseros y fotos, Nombre: Youtube, Carpetas: /data/youtube

Dejamos marcado: Permitir conexiones remotas a este servidor

Vamos a Panel de Control > Usuarios y añadimos omar

## Gitea

Arrancamos el proyecto: Desde arcane > Proyectos > Elegimos gitea > Subir

Vamos a http://gitea.omp.home

Ahora nos sale la configuracion por defecto, vamos bajo del todo y pinchamos en "Instalar Gitea"

Nos aparece para crear un usuario:
* Username: [username]
* Email: [username]@omp.home
* Password: [password]

Ahora vamos a http://gitea.omp.home/-/admin/users y creamos un usuario

