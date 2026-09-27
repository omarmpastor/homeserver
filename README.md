# Instalar Homeserver

## Preparacion del sistema

Instalamos Debian 13 y le instalamos los paquetes necesarios para que ansible funcione
```bash
sudo apt install -y ssh python3

sudo systemctl enable --now ssh
```

## Preparacion del entorno

Clonamos el repositorio `git clone https://github.com/omarmpastor/homeserver.git` y entramos con `cd homeserver`

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

Reiniciamos y configuramos los servicios. Podemos seguir al documentación [https://github.com/omarmpastor/homeserver/blob/main/doc/CONFIGURE_SERVICES.md](https://github.com/omarmpastor/homeserver/blob/main/doc/CONFIGURE_SERVICES.md)
