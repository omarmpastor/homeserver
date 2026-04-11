# Home Server Docker

## Instalación y configuración

### Configuramos red

Archivo /etc/network/interfaces
```sh
source /etc/network/interfaces.d/*

auto lo
iface lo inet loopback

allow-hotplug ens33
#iface ens33 inet dhcp
iface ens33 inet static
    address 192.168.1.10
    netmask 255.255.255.0
    gateway 192.168.1.1
    dns-nameservers 9.9.9.9 149.112.112.112
```

Y reiniciamos el servicio (aunque lo mejor es reinciar la maquina)
```sh
sudo systemctl disable --now NetworkManager
sudo systemctl restart networking
```

### Instalamos software

Instalamos cockpit
```sh
sudo apt install cockpit

# Para el plugin de discos de cockpit
sudo apt install udisks2-lvm2 udisks2-btrfs
```

Instalar Docker
```sh
curl -fsSL https://get.docker.com | sudo sh
sudo usermod -aG docker $USER
```

### Ejecutar poweroff y reboot sin sudo y contraseña

Para usar poweroff y reboot sin poner la contraseña
```sh
sudo EDITOR=vim visudo -f /etc/sudoers.d/power

# Y añadimos la linea
sysroot ALL=(ALL) NOPASSWD: /usr/sbin/poweroff, /usr/sbin/reboot, /usr/sbin/shutdown
```

### Montamos la unidad y la añadimos a fstab

Formateamos el disco
```sh
sudo wipefs -a /dev/sdX
sudo cfdisk /dev/sdX
sudo mkfs.ext4 -m 0 /dev/sdX1
```

Montamos el disco
```sh
sudo mkdir /mnt/storage
sudo mount /dev/sdX1 /mnt/storage
sudo chown -R 1000:1000 /mnt/storage

# sacamos el UUID del disco
sudo blkid /dev/sdX1
```

Añadimos a /etc/fstab
```sh
UUID="xxxxxxxxxxxxxxxxxx"       /mnt/storage    ext4            defaults	0 2
```

Recargamos y montamos
```sh
# Primero desmontamos
sudo umount /mnt/storage

sudo systemctl daemon-reload
sudo mount -a
```

creamos las carpetas y damos los permisos necesarios
```sh
mkdir -p /mnt/storage/backups
sudo chown -R 1000:1000 /mnt/storage/backups

mkdir -p /mnt/storage/torrents
mkdir -p /mnt/storage/media/{movies,tv,videos,youtube}

sudo chown -R 1000:1000 /mnt/storage/torrents
sudo chown -R 1000:1000 /mnt/storage/media

mkdir -p /mnt/storage/backups
sudo chown -R 1000:1000 /mnt/storage/backups

mkdir -p /mnt/storage/filebrowser
sudo chown -R 1000:1000 /mnt/storage/filebrowser

#mkdir -p /mnt/storage/nextcloud-data
#sudo chown -R 33:33 /mnt/storage/nextcloud-data
# 33 es el usuario www-data de apache
```

## Levantamos nuestros stacks

```bash
sudo mkdir /opt/docker
sudo chown -R 1000:1000 /opt/docker

cd /opt/docker
git clone https://github.com/omarmpastor/homeserver.git

cd homeserver
```

### Modo de uso de los scripts para levantar lso servicios

🧪 Validación segura
```bash
stackctl dry-run
```

🚀 Deploy completo
```bash
stackctl up
```

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

## Modificar DNS

Ahora tendremos que añadir las entradas tipo CNAME a nuestro DNS apuntando a nuestro servidor
```
joplin.omp.home
filebrowser.omp.home
metube.omp.home
sonarr.omp.home
radarr.omp.home
prowlarr.omp.home
qbittorrent.omp.home
jackett.omp.home
bazarr.omp.home
kopia.omp.home
jellyfin.omp.home
gitea.omp.home
dashboard.omp.home
```
