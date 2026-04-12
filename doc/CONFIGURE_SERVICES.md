# Configuración de apps y servicios

> NO ACTUALIZADO!!!

Ahora vamos a ir configurando las apps

## Dashboard

Vamos a http://dashboard.omp.home

Creamos en nuestro servidor el archivo ~/inserts.js
```javascript
const sqlite3 = require('sqlite3').verbose();

const db = new sqlite3.Database('/app/data/db.sqlite');

const apps = [
  {
    name: 'Cockpit',
    url: 'https://cockpit.omp.home:9090',
    icon: 'https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/svg/cockpit-light.svg',
  },
  {
    name: 'Gitea',
    url: 'http://gitea.omp.home',
    icon: 'https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/svg/gitea.svg',
  },
  {
    name: 'qBittorrent',
    url: 'http://qbittorrent.omp.home',
    icon: 'https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/svg/qbittorrent.svg',
  },
  {
    name: 'Jellyfin',
    url: 'http://jellyfin.omp.home',
    icon: 'https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/svg/jellyfin.svg',
  },
  {
    name: 'Prowlarr',
    url: 'http://prowlarr.omp.home',
    icon: 'https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/svg/prowlarr.svg',
  },
  {
    name: 'Radarr',
    url: 'http://radarr.omp.home',
    icon: 'https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/svg/radarr.svg',
  },
  {
    name: 'Sonarr',
    url: 'http://sonarr.omp.home',
    icon: 'https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/svg/sonarr.svg',
  },
  {
    name: 'Bazarr',
    url: 'http://bazarr.omp.home',
    icon: 'https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/bazarr.png',
  },
  {
    name: 'Joplin',
    url: 'http://joplin.omp.home',
    icon: 'https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/svg/joplin.svg',
  },
  {
    name: 'Filebrowser',
    url: 'http://filebrowser.omp.home',
    icon: 'https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/svg/filebrowser-quantum.svg',
  },
  {
    name: 'Kopia',
    url: 'http://kopia.omp.home',
    icon: 'https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/svg/kopia.svg',
  },
  {
    name: 'Metube',
    url: 'http://metube.omp.home',
    icon: 'https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/svg/metube.svg',
  }
];

for (const app of apps) {
  db.run(
    `
    INSERT INTO apps (name, url, icon, isPinned, isPublic, createdAt, updatedAt)
    VALUES (?, ?, ?, 1, 1, datetime('now'), datetime('now'))
    `,
    [app.name, app.url, app.icon]
  );
}

db.close();
```

Ejecutamos
```bash
cat inserts.js | docker exec -i flame node -
```

En el boton de configuracion de abajo a la izquierda, vamos a App y ponemos la contraseña que hemos puesto en la configuracion del contenedor

Configuramos la vista para que solo aparezcan las aplicaciones

En el apartados css establecemos (mirar si es el nombre de la clase de las apps correcto en las dev tools de chrome):
```css
.AppCard_AppCard__NPTM5 div h5 {
  font-size: 20px !important;
}
```

Lo primero necesitamos conocer el password que nos ha puesto por defecto. Esto está en los logs del contenedor (Ejecutamos: `docker logs qbittorrent`)

Vamos a http://qbittorrent.omp.home

Entramos en la interfaz con `admin` y el password temporal que nos ha creado:
- Vamos a Tools > Options > WebUI y cambiamos el password. Si no queremos que nos pida usuario y contraseña, marcamos: `Bypass authentication for clients in whitelisted IP subnets` y le añadimos nuestra red `192.168.1.0/24`
- Vamos a Tools > Options > Behavior > User interface language > Español

### Sonarr/Radarr

Nos conectamos a http://radarr.omp.home para radarr y http://sonarr.omp.home para sonarr

La primera vez que nos conectemos nos pedira que establezcamos un login:

Authentication Method: Form (Login Page)
Authentication Required: Disabled for Local Addresses
Username: wyse
Password: Homeserver.26

Vamos a Settings -> Media Management -> Pinchamos en el icono de arriba "Show Advanced"
- Dejamos marcado -> Use Hardlinks instead of Copy
- Al final en el botón Add Root Folder, añadimos -> "/storage/Movies/" para radarr y "/storage/TV/"
- Guardamos cambios

Vamos a Settings -> Download Clients -> + -> qBittorrent
- Host: qbittorrent
- Port: 8090
- Username: admin
- Password: Homeserver.26
- Dejamos marcado: Remove imported downloads from dowload client history

Vamos a Settings -> Profiles -> Entramos a cada uno de ellos -> Language -> Spanish (sino no nos busara en prowlarr en español)

### Prowlarr

Nos conectamos a http://prowlarr.omp.home

La primera vez que nos conectemos nos pedira que establezcamos un login:

Authentication Method: Form (Login Page)
Authentication Required: Disabled for Local Addresses
Username: wyse
Password: Homeserver.26

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
- Username: admin
- Password: Homeserver.26

Ahora vamos a Indexers (No a Settings > Indexers) -> Add Indexer y añadimos los que queramos

### Bazarr

Nos conectamos a http://bazarr.omp.home

### Bazarr

Al arrancar nos aparece en esta página: http://bazarr.omp.home/settings/general
- Security > Authentication > Form
- Establecemos > Username: wyse y Password: Homeserver.26
- Guardamos


Vamos a http://bazarr.omp.home/settings/languages
- Languages Filter > Escribimos > Spanish English (Nos autocompleta)
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


Guardamos (arriba a la izquierda hay un icono de guardar)

Vamos a http://bazarr.omp.home/settings/sonarr
- Lo activamos
- Address: sonarr
- API Key: Ponemos lo que hay en En Sonarr > Settings > General > API Key
- Path Mappings (No aparecera hasta que guardemos)
    - Sonar: /storage/TV/ - Bazarr: /tv/
- Guardamos

Vamos a http://bazarr.omp.home/settings/radarr
- Lo activamos
- Address: radarr
- API Key: Ponemos lo que hay en En Radarr > Settings > General > API Key
- Path Mappings (No aparecera hasta que guardemos)
- Radarr: /storage/Movies/ - Bazarr: /movies/
- Guardamos


Vamos a http://bazarr.omp.home/settings/providers
- Añadimos > Subtitulamos.tv
- Añadimos > Supersubtitles

Vamos a http://bazarr.omp.home/settings/series
- Marcamos el icono de la izquierda "Mass edit" para establecer en todos Spanish-English

Vamos a http://bazarr.omp.home/settings/movies
- Marcamos el icono de la izquierda "Mass edit" para establecer en todos Spanish-English


## Jellyfin

Arrancamos el proyecto: Desde arcane > Proyectos > Elegimos jellyfin > Subir

Vamos a http://jellyfin.omp.home

Usamos el asistente para configurar el servidor estableciendo en Español y poniendo usuario y contraseña:
Usuario: wyse
Password: Homeserver.26

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
Usuario: wyse
Email: wyse@omp.lab
Password: Homeserver.26

Ahora vamos a http://gitea.omp.home/-/admin/users y creamos un usuario

