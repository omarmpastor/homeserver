# Instalar Homeserver

## Preparacion del sistema

Instalamos Debian 13 y le instalamos los paquetes necesarios para que ansible funcione
```bash
sudo apt install -y ssh python3

sudo systemctl enable --now ssh
```

## Preparacion del entorno

Clonamos el repositorio `git clone https://github.com/omarmpastor/homeserver.git` y entramos con `cd homeserver`

* Instalamos las colecciones que usan los roles `ansible-galaxy install -r requirements.yml`
* Editamos la IP del servidor en `inventory.yml`
* Revisamos la configuracion de red en `group_vars/all.yml` (`network.interface` se autodetecta si se deja vacia)
* Editamos el archivo de secretos en `vault.yml`
* Editamos las variables en `group_vars/all.yml`
* Revisamos los servicios que queremos usar y los que no los comentamos en `roles/containers/vars/main.yml`
* Si queremos cifrar los secretos, ejecutamos `ansible-vault encrypt vault.yml`

> En este punto deberiamos revisar el directorio donde se van a guardar los datos `group_vars/all.yml/storage_path`


## Instalar

Una vez definidas todas las variables, ejecutamos (fallara si no hemos creado el directorio de la variable group_vars/all.yml/storage_path)
```bash
ansible-playbook site.yml
```

El rol `network` se aplica siempre al final del playbook y deja la configuracion preparada para el **proximo reinicio** (asi no se cambia la IP en caliente y no se corta la conexion SSH), por eso:

> Antes de reiniciar, revisa que la direccion IP de `group_vars/all.yml/network` es la correcta. Si te equivocas, perderas el acceso al servidor.

Reiniciamos y configuramos los servicios. Podemos seguir al documentación [https://github.com/omarmpastor/homeserver/blob/main/doc/CONFIGURE_SERVICES.md](https://github.com/omarmpastor/homeserver/blob/main/doc/CONFIGURE_SERVICES.md)
