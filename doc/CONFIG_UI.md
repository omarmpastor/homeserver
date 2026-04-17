# Configuración UI

Configuración UI (probando)

## Instalar tema

Instalar fuente Inter de Google
```
mkdir -p ~/.fonts && \
git clone --depth 1 https://github.com/rsms/inter.git /tmp/inter && \
cp /tmp/inter/docs/font-files/*.ttf ~/.fonts/ && \
rm -rf /tmp/inter && \
fc-cache -fv
```

Instalamos el tema
```
git clone https://github.com/vinceliuice/Orchis-theme /tmp/Orchis-theme
/tmp/Orchis-theme/install.sh
rm -rf /tmp/Orchis-theme

sudo apt-get install papirus-icon-theme
```

Ahora vamos a Aplicaciones > Cofiguracion > Apariencia
- Estilo: Orchis-Dark
- Iconos: Papirus-Dark
- Letra: Inter Regular

## Personalizar

Borramos el Dock
* Pinchamos con el botón derecho en el Dock > Preferencias del Panel > Seleccionamos en el desplegable Panel 2 > Eliminar

Pinchamos en el panel con derecho > Panel > Preferencias del Panel
* Pestaña Visualización
	* Desbloquear el panel: Desmarcado para moverlo abajo y lo marcamos de nuevo
  * Tamaño de la fila: 38
* Pestaña Apariencia
	* Ajustar iconos automáticamente: Activado
* Pestaña Elementos
  * Menu de Aplicaciones > Lo eliminamos
  * Agregar > Menu Whisker
    * Propiedades
        * Mostrar como lista: Seleccionado
        * Mostrar nombres genéricos de las aplicaciones: Desmarcado
        * Mostrar el nombre de las categorias: Desmarcado
        * Mostrar descripción emergente de las aplicaciones: Marcado
        * Mostrar la descripción de las aplicaciones: Desmarcado
        * Opacidad del fondo: 0%
        * Pestaña apariencia:
            * Cambiamos el icono (el menos malo se llama start-here)
            * Posicion de categorias a la izquierda
            * Posicion profile in bottom: Marcado
  * Botones de las ventanas
    * Mostrar las etiquetas de los botones: Desmarcado
    * Mostrar los tiradores: Desmarcado
  * Agregar > Lanzador/es justo debajo de Menu Whisker
  * Configuramos el resto de elementos de la barra a nuestro gusto

## Instalar aplicaciones

Instalamos
```bash
sudo apt install kodi
```
