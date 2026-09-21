# Instalar Homeserver

## Preparacion del sistema

Instalamos Debian 13 y le instalamos los paquetes necesarios para que ansible funcione
```bash
sudo apt install -y ssh python3

sudo systemctl enable --now ssh
```

### Si vamos a montar una unidad externa, este es el momento

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

### Si vamos a montar una unidad, creamos el directorio donde se guardaran los datos


Si cambiamos este directorio, lo cambiamos tambien en `group_vars/all.yml/storage_path`
```sh
sudo mkdir /mnt/storage
sudo chown -R 1000:1000 /mnt/storage
```

## Preparacion del entorno

Clonamos el repositorio `gìt clone https://gitlab.com/omarmpastor/homeserver2026.git` y entramos con `cd homeserver2026`

* Editamos el archivo de secretos en `vault.yml`
* Editamos las variables en `group_vars/all.yml`
* Revisamos los servicios que queremos usar y los que no los comentamos en `roles/containers/vars/main.yml`
* Si queremos cifrar los secretos, ejecutamos `ansible-vault encrypt vault.yml`


## Instalar

Una vez definidas todas las variables, ejecutamos (fallara si no hemos creado el directorio de la variable group_vars/all.yml/storage_path)
```bash
ansible-playbook site.yml
```

Reiniciamos y configuramos los servicios. Podemos seguir al documentación [https://github.com/omarmpastor/homeserver/blob/main/doc/CONFIGURE_SERVICES.md](https://github.com/omarmpastor/homeserver/blob/main/doc/CONFIGURE_SERVICES.md)
