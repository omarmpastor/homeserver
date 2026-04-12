# Configuración de apps y servicios

> NO ACTUALIZADO!!!

Ahora vamos a ir configurando las apps

## Dashboard

Arrancamos el proyecto: Desde arcane > Proyectos > Elegimos flame > Subir

Vamos a http://192.168.1.99

En el boton de configuracion de abajo a la izquierda, vamos a App y ponemos la contraseña que hemos puesto en la configuracion del contenedor

Configuramos la vista para que solo aparezcan las aplicaciones

En el apartados css establecemos (mirar si es el nombre de la clase correcto en las dev tools de chrome):
```css
.AppCard_AppCard__NPTM5 div h5 {
  font-size: 20px !important;
}
```

Ahora pinchamos en APPLICATIONS y nos aparece el boton ADD
Añadimos estas aplicaciones:
```
Nombre: Cockpit  
URL: http://192.168.1.99:9090  
Icono: https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/svg/cockpit-light.svg  

Nombre: Arcane  
URL: http://192.168.1.99:3552  
Icono: https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/svg/arcane.svg  

Nombre: Nextcloud  
URL: http://192.168.1.99:8080  
Icono: https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/svg/nextcloud.svg  

Nombre: Gitea  
URL: http://192.168.1.99:3000  
Icono: https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/svg/gitea.svg  

Nombre: qBittorrent  
URL: http://192.168.1.99:8090  
Icono: https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/svg/qbittorrent.svg  

Nombre: Jellyfin  
URL: http://192.168.1.99:8096  
Icono: https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/svg/jellyfin.svg  

Nombre: Prowlarr  
URL: http://192.168.1.99:9696  
Icono: https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/svg/prowlarr.svg  

Nombre: Radarr  
URL: http://192.168.1.99:7878  
Icono: https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/svg/radarr.svg  

Nombre: Sonarr  
URL: http://192.168.1.99:8989  
Icono: https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/svg/sonarr.svg  

Nombre: Bazarr  
URL: http://192.168.1.99:6767  
Icono: https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/svg/bazarr-dark.svg  
```

## Media Downloads

Arrancamos el proyecto: Desde arcane > Proyectos > Elegimos media-downloads > Subir (este tardara porque tiene varias imagenes que desargar)

### qBittorrent

Lo primero necesitamos conocer el password que nos ha puesto por defecto. Esto está en los logs del contenedor (Ejecutamos: `docker logs qbittorrent`)

Vamos a http://192.168.1.99:8090

Entramos en la interfaz con `admin` y el password temporal que nos ha creado:
- Vamos a Tools > Options > WebUI y cambiamos el password. Si no queremos que nos pida usuario y contraseña, marcamos: `Bypass authentication for clients in whitelisted IP subnets` y le añadimos nuestra red `192.168.1.0/24`
- Vamos a Tools > Options > Behavior > User interface language > Español

### Sonarr/Radarr

Nos conectamos a http://192.168.1.99:7878 para radarr y http://192.168.1.99:8989 para sonarr

La primera vez que nos conectemos nos pedira que establezcamos un login:

Authentication Method: Form (Login Page)
Authentication Required: Disabled for Local Addresses
Username: wyse
Password: Homeserver.26

Vamos a Settings -> Media Management -> Pinchamos en el icono de arriba "Show Advanced"
- Dejamos marcado -> Use Hardlinks instead of Copy
- Al final en el botón Add Root Folder, añadimos -> "/storage/Movies/" para radarr y "/storage/TV/"
- Guardamos cambios

Vamos a Settings -> General -> Backups -> Folder -> Establecemos /data/backup/
- Guardamos cambios

Vamos a Settings -> Download Clients -> + -> qBittorrent
- Host: qbittorrent
- Port: 8090
- Username: admin
- Password: Homeserver.26
- Dejamos marcado: Remove imported downloads from dowload client history

Vamos a Settings -> Profiles -> Entramos a cada uno de ellos -> Language -> Spanish (sino no nos busara en prowlarr en español)

### Prowlarr

Nos conectamos a http://192.168.1.99:7878

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

Nos conectamos a http://192.168.1.99:6767

### Bazarr

Al arrancar nos aparece en esta página: http://192.168.1.99:6767/settings/general
- Security > Authentication > Form
- Establecemos > Username: wyse y Password: Homeserver.26
- Guardamos


Vamos a http://192.168.1.99:6767/settings/languages
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

Vamos a http://192.168.1.99:6767/settings/sonarr
- Lo activamos
- Address: sonarr
- API Key: Ponemos lo que hay en En Sonarr > Settings > General > API Key
- Path Mappings (No aparecera hasta que guardemos)
    - Sonar: /storage/TV/ - Bazarr: /tv/
- Guardamos

Vamos a http://192.168.1.99:6767/settings/radarr
- Lo activamos
- Address: radarr
- API Key: Ponemos lo que hay en En Radarr > Settings > General > API Key
- Path Mappings (No aparecera hasta que guardemos)
- Radarr: /storage/Movies/ - Bazarr: /movies/
- Guardamos


Vamos a http://192.168.1.99:6767/settings/providers
- Añadimos > Subtitulamos.tv
- Añadimos > Supersubtitles

Vamos a http://192.168.1.99:6767/settings/series
- Marcamos el icono de la izquierda "Mass edit" para establecer en todos Spanish-English

Vamos a http://192.168.1.99:6767/settings/movies
- Marcamos el icono de la izquierda "Mass edit" para establecer en todos Spanish-English


## Media Player

Arrancamos el proyecto: Desde arcane > Proyectos > Elegimos jellyfin > Subir

Vamos a http://192.168.1.99:8096

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

Vamos a http://192.168.1.99:3000

Ahora nos sale la configuracion por defecto, vamos bajo del todo y pinchamos en "Instalar Gitea"

Nos aparece para crear un usuario:
Usuario: wyse
Email: wyse@omp.lab
Password: Homeserver.26

Ahora vamos a http://192.168.1.99:3000/-/admin/users y creamos un usuario

## Nextcloud

Arrancamos el proyecto: Desde arcane > Proyectos > Elegimos nextcloud > Subir

Ahora tarda 1 min aproximadamente en levantar

Vamos a http://192.168.1.99:8080 y hacemos login con el usuario que hemos puesto al crear el contenedor

Vamos a http://192.168.1.99:8080/settings/users y creamos el usuario omar

**REVISAR!!! Configurar para optimizar y que consuma menos recursos**
