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
* Revisamos los servicios que queremos usar y los establecemos como activos/inactivos en `roles/containers/vars/main.yml`
* Los compose de `roles/containers/templates/<servicio>.yml` son archivos finales: no se renderizan con Ansible. Sus variables se leen del `.env` generado desde `<servicio>.env.j2` y todas tienen un valor por defecto si no se definen en dicho `.env`
* En los puertos, `XXX_PORT` es el puerto externo (publicado) y `XXX_DEFAULT_PORT` el interno del contenedor (el que antes valía `XXX_PORT`). El puerto externo se define con `external_port` en `roles/containers/vars/main.yml`
* Los volúmenes usan variables `XXX_VOLUME` (origen del volumen) con valor por defecto y también se generan en el `.env`. Las rutas bind toman `group_vars/all.yml/storage_path` como punto de partida
* Si queremos cifrar los secretos, ejecutamos `ansible-vault encrypt vault.yml`
* Si vamos a administrar VMs desde cockpit, descomentamos la linea roles/system/vars/main.yml/packages/cockpit-machines

> En este punto deberiamos revisar el directorio donde se van a guardar los datos `group_vars/all.yml/storage_path`


## Instalar

Una vez definidas todas las variables, ejecutamos (fallara si no hemos creado el directorio de la variable group_vars/all.yml/storage_path)
```bash
ansible-playbook site.yml
```

El rol `network` se aplica siempre al final del playbook y deja la configuracion preparada para el **proximo reinicio** (asi no se cambia la IP en caliente y no se corta la conexion SSH), por eso:

> Antes de reiniciar, revisa que la direccion IP de `group_vars/all.yml/network` es la correcta. Si te equivocas, perderas el acceso al servidor.

Reiniciamos y configuramos los servicios. Podemos seguir al documentación [https://github.com/omarmpastor/homeserver/blob/main/doc/CONFIGURE_SERVICES.md](https://github.com/omarmpastor/homeserver/blob/main/doc/CONFIGURE_SERVICES.md)
