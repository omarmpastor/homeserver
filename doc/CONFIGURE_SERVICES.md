# Configuración de apps y servicios

Ahora vamos a ir configurando las apps

## Pihole

Configuramos Pihole como DNS primario en nuestro router y lo configuramos http://IP:8084/admin/login:

Introducimos la constraseña que tenemos definida en el archivo `vault.yml/apps_password`

Vamos a Settings -> Local DNS Records y en List of local DNS records añadimos en cada una como Associated IP, la de nuestro servidor y como Domain:
* cockpit.omp.home
* nextcloud.omp.home
* qbittorrent.omp.home
* jellyfin.omp.home
* prowlarr.omp.home
* jackett.omp.home
* radarr.omp.home
* sonarr.omp.home
* bazarr.omp.home
* pihole.omp.home

## Heimdall dashboard

Para acceder vamos a dashboard.omp.home (o http://IP:8085)

### Si hemos configurado DNS o PiHole

Añadimos las apps:
* https://cockpit.omp.home:9090
* http://nextcloud.omp.home
* http://qbittorrent.omp.home
* http://jellyfin.omp.home
* http://prowlarr.omp.home
* http://jackett.omp.home
* http://radarr.omp.home
* http://sonarr.omp.home
* http://bazarr.omp.home
* http://pihole.omp.home

### Sin DNS

Añadimos las apps:
* https://IP:9090
* http://IP:8083 (nextcloud)
* http://IP:8090 (qbittorrent)
* http://IP:8096 (jellyfin)
* http://IP:9696 (prowlarr)
* http://IP:9117 (jackett)
* http://IP:7878 (radarr)
* http://IP:8989 (sonarr)
* http://IP:6767 (bazarr)
* http://IP:8084 (pihole)

## Nextcloud

Entramos en http://nextcloud.omp.home o http://IP:8083 con el usuario/contraseña que tenemos definida en el archivo `vault.yml/apps_password`

* Vamos al icono del perfil de usuario > Accounts (http://nextcloud.omp.home/settings/user) -> Podemos configurar el usuario
* Vamos al icono del perfil de usuario > Accounts/Cuentas (http://nextcloud.omp.home/settings/users) -> Botón "+ New Account" para dar de alta otros usuarios
* Vamos al icono del perfil de usuario > + Apps/Aplicaciones > Active apps/Apps activas (http://nextcloud.omp.home/settings/apps/enabled) y deshabilitamos las aplicaciones innecesarias
  * Federation
  * File reminders
  * Nextcloud announcements
  * Photos (si no vamos a usar funcionalidad de fotos)
  * Recommendations
  * Related Resources
  * Support
  * Teams
  * Usage survey
  * Weather status
* Activamos la aplicacion Notes en el icono del perfil de usuario > + Apps/Aplicaciones > Tools > Notes (http://nextcloud.omp.home/settings/apps/tools/notes?grid) > Pulsamos en el botón "Download and enable"

## Jellyfin

Vamos a http://jellyfin.omp.home o http://IP:8096


Usamos el asistente para configurar el servidor:

Nos pide:
* Server name: Dejamos el que aparece automaticamente
* Preferred display language español

Nos pide usuario/contraseña que queremos definir como administrador (consejo: ponemos el del archivo `vault.yml`)
* Username: [username]
* Password: [password]

Configuramos 3 bibliotecas multimedia
- Content type: Movies, Nombre: Peliculas, Carpetas: /data/movies, Idioma preferido de visualizado: Spanish Castillian, Pais: Spain
- Content type: Shows, Nombre: Series, Carpetas: /data/tvshows, Idioma preferido de visualizado: Spanish Castillian, Pais: Spain
- Content type: Home videos and Photos, Nombre: Videos, Carpetas: /data/videos

Configuramos el lenguaje de los metadatos
Language: Spanish Castillian
Country/Region: Spain

Dejamos marcado: Permitir conexiones remotas a este servidor

Vamos al icono del perfil de usuario > Dashboard > Users > Añadimos a un usuario (Marcando la opción "Enable access to all libraries")

## qBittorrent

Lo primero necesitamos conocer el password que nos ha puesto por defecto. Esto está en los logs del contenedor (Ejecutamos: `ansible IP -i inventory.yml -m ansible.builtin.shell -a 'docker logs qbittorrent'`)

Vamos a http://qbittorrent.omp.home o http://IP:8090

Entramos en la interfaz con `admin` y el password temporal que nos ha creado:
- Vamos a Tools > Options > WebUI y cambiamos el password. Si no queremos que nos pida usuario y contraseña, marcamos: `Bypass authentication for clients in whitelisted IP subnets` y le añadimos nuestra red `192.168.1.0/24`
- Vamos a Tools > Options > Behavior > User interface language > Español

### Sonarr/Radarr

Nos conectamos a http://radarr.omp.home o http://IP:7878 para radarr y http://sonarr.omp.home o http://IP:8989 para sonarr

La primera vez que nos conectemos nos pedira que establezcamos un login:

* Authentication Method: Form (Login Page)
* Authentication Required: Disabled for Local Addresses
* Username: [username]
* Password: [password]
* Allowed Hosts: radarr/sonarr segun corresponda (es para llamadas a la api desde prowlarr)

Vamos a Settings -> Media Management -> Pinchamos en el icono de arriba "Show Advanced"
- Dejamos marcado -> Use Hardlinks instead of Copy
- Al final en el botón Add Root Folder, añadimos -> "/storage/Movies/" para radarr y "/storage/TV/"
- Guardamos cambios

(Solo radarr) Vamos a Settings -> Profiles -> Entramos a cada uno de ellos -> Language -> Spanish (sino no nos busara en prowlarr en español)

En Settings -> Profiles yo tambien desmarco (demasiada calidad):
Redemux-2160p
Bluray-2160p
WEB 2160p
HDTV-2160p

Si no vamos a usar Prowlarr, añadimos qBittorrent
Vamos a Settings -> Download Clients -> + -> qBittorrent
- Host: qbittorrent
- Port: 8090
- Username: [username]
- Password: [password]
- Dejamos marcado: Remove imported downloads from dowload client history

### Jackett

Nos conectamos a http://jackett.omp.home o http://IP:9117

Ponemos una contraseña de administrador en [Admin password] (consejo: ponemos la del archivo `vault.yml/apps_password`)
Pinchamos en Add Indexer -> DonTorrent (tarda en añadirlo, comprueba un rato. Si no va y da error, lo intentamos en otro momento del dia y suele ir)

### Prowlarr

Nos conectamos a http://prowlarr.omp.home o http://IP:9696

La primera vez que nos conectemos nos pedira que establezcamos un login:

* Authentication Method: Form (Login Page)
* Authentication Required: Disabled for Local Addresses
* Username: [username] (consejo: ponemos el usuario/password del archivo `vault.yml`)
* Password: [password]
* Allowed Hosts: prowlarr

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
- API Key: Vamos a http://qbittorrent.omp.home o http://IP:8090 -> WebUI -> API Key -> Generamos una y la copiamos

Ahora vamos a Indexers (No a Settings > Indexers) -> Add Indexer y añadimos los que queramos predefinidos.

Ahora vamos a añadir personalizados:

Desde Jackett
  * DonTorrent
    * Le damos a añadir y elegimos "Generic Torznab"
    * Name: DonTorrent
    * Enable: Activado
    * Redirect: Desactivado
    * URL (hay un botón "Copy Torznab Feed" en jackett y sustituimos la ip por "jackett"): http://jackett:9117/api/v2.0/indexers/dontorrent/results/torznab/
    * API Key: Copiamos la API key de Jackett
    * Pinchamos en Test y Guardamos

### Bazarr

Nos conectamos a http://bazarr.omp.home o http://IP:6767

Al arrancar nos aparece en esta página: http://bazarr.omp.home/settings/general
- Security > Authentication > Form
- Establecemos > Username y Password (consejo: ponemos el del archivo `vault.yml`)
- Guardamos (arriba a la izquierda hay un icono de guardar)


Vamos a Languages (http://bazarr.omp.home/settings/languages/general)
- Languages Filter > Escribimos > Spanish English (Nos autocompleta)
- Guardamos (arriba a la izquierda hay un icono de guardar)

Vamos a Languages -> Pestaña Profiles (http://bazarr.omp.home/settings/languages/profiles)
- Languages Profile > añadimos 3 (por separado, habra que pinchar en Add new profile tres veces):
    - Name: Spanish, Tag es
    - Add Language: Seleccionamos Spanish, Normal or hearing-impaired
    - Name: English, Tag en
    - Add Language: Seleccionamos English, Normal or hearing-impaired
    - Name: Spanish-English, Tag vacio
    - Add Language: Seleccionamos Spanish, Normal or hearing-impaired
    - Add Language: Seleccionamos English, Normal or hearing-impaired
- Default Language Profiles For Newly Added Shows
    - Activamos movies y series y establecemos Spanish-English
- Guardamos (arriba a la izquierda hay un icono de guardar)

Vamos a Library -> Pestaña Sonarr (http://bazarr.omp.home/settings/library/sonarr)
- Lo activamos
- Address: sonarr
- API Key: Ponemos lo que hay en En Sonarr > Settings > General > API Key
- Pinchamos en Test
- Path Mappings (No aparecera hasta que guardemos, arriba a la izquierda hay un icono de guardar)
    - Sonar: /storage/TV/ - Bazarr: /tvshows/
- Guardamos (arriba a la izquierda hay un icono de guardar)

Vamos a http://bazarr.omp.home/settings/radarr
- Lo activamos
- Address: radarr
- API Key: Ponemos lo que hay en En Radarr > Settings > General > API Key
- Path Mappings (No aparecera hasta que guardemos, arriba a la izquierda hay un icono de guardar)
- Radarr: /storage/Movies/ - Bazarr: /movies/
- Guardamos (arriba a la izquierda hay un icono de guardar)


Vamos a Providers (http://bazarr.omp.home/settings/providers/subtitles)
- Añadimos > Subtitulamos.tv
- Añadimos > Supersubtitles

Vamos a Series (http://bazarr.omp.home/series)
- Marcamos el icono de la izquierda "Mass edit" para establecer en todos Spanish-English (si hay series)

Vamos a Movies (http://bazarr.omp.home/movies)
- Marcamos el icono de la izquierda "Mass edit" para establecer en todos Spanish-English (Si hay peliculas)

### Gitea

Vamos a http://gitea.omp.home o http://IP:3000

Ahora nos sale la configuracion por defecto, vamos bajo del todo y pinchamos en "Install Gitea"

Nos aparece para crear un usuario:
* Username: [username] (consejo: ponemos el usuario/password del archivo `vault.yml`)
* Email: [username]@omp.home
* Password: [password]

Ahora vamos al icono del servidor > Identity & Access > User Accounts (http://gitea.omp.home/-/admin/users) y creamos un usuario

## Apps no instaladas por defecto

### Dockhand

Vamos a http://dockhand.omp.home

* Settings > Environments > Add Environment
  * Name: Docker
  * Connection type: Unix socket
  * Source path: /var/run/docker.sock
* Settings > Authentication > Users
  * Añadimos un usuario
  * Hay un botón de Authentication > Lo activamos y se pone en on
