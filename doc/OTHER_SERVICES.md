# Otros servicios

Podemos añadir otros servicios de la carpeta stacks con el comando
```bash
stackctl stack [service] up
```

## Dashboard Flame

Tenemos activo Heimdall, pero podemos cambiarlo por Flame

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
    name: 'sFTPgo',
    url: 'http://sftpgo_config.omp.home',
    icon: 'https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/sftpgo.png',
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
  },
  {
    name: 'Dockhand',
    url: 'http://dockhand.omp.home',
    icon: 'https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/dockhand.png',
  },
  {
    name: 'Syncthing',
    url: 'http://syncthing.omp.home',
    icon: 'https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/svg/syncthing.svg',
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
cat ~/inserts.js | docker exec -i flame node -
```

En el boton de configuracion de abajo a la izquierda, vamos a App y ponemos la contraseña que hemos puesto en la configuracion del contenedor

Configuramos la vista para que solo aparezcan las aplicaciones

En el apartados css establecemos (mirar si es el nombre de la clase de las apps correcto en las dev tools de chrome):
```css
.AppCard_AppCard__NPTM5 div h5 {
  font-size: 20px !important;
}
```
