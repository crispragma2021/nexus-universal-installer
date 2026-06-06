#!/bin/bash

# 1. DETECCIÓN DINÁMICA DEL USUARIO REAL (Universal para cualquier PC)
REAL_USER=$(whoami)

# 2. DETECCIÓN AUTOMÁTICA DEL SISTEMA OPERATIVO
if [ -f /etc/os-release ]; then
    . /etc/os-release
    DISTRO=$ID
    LIKE=$ID_LIKE
else
    DISTRO="unknown"
fi

if [[ "$DISTRO" == "ubuntu" || "$DISTRO" == "debian" || "$LIKE" == *"debian"* || "$LIKE" == *"ubuntu"* ]]; then
    SYS_TYPE="debian"
    EXT="*.deb"
elif [[ "$DISTRO" == "arch" || "$LIKE" == *"arch"* ]]; then
    SYS_TYPE="arch"
    EXT="*.tar.zst"
elif [[ "$DISTRO" == "fedora" || "$DISTRO" == "rhel" || "$DISTRO" == "centos" || "$LIKE" == *"rhel"* || "$LIKE" == *"fedora"* ]]; then
    SYS_TYPE="fedora"
    EXT="*.rpm"
else
    zenity --error --text="Sistema no compatible con el núcleo NEXUS." --title="Error"; exit 1
fi

# --- MODO DESINSTALADOR AUTOMÁTICO ---
if [ "$1" == "--uninstall" ]; then
    echo "# Cargando lista de aplicaciones..." | zenity --progress --title="NEXUS Uninstaller Universal" --text="Detectando sistema: $DISTRO..." --pulsate --auto-close --width=400 &
    Z_PID=$!
    if [ "$SYS_TYPE" == "debian" ]; then 
        LISTA_PAQUETES=$(dpkg-query -W -f='${Package}\n' | grep -E "chrome|chromium|code|vlc|steam|discord|spotify" | sort | uniq)
        if [ -z "$LISTA_PAQUETES" ]; then LISTA_PAQUETES=$(dpkg-query -W -f='${Package}\n' | head -n 50); fi
    elif [ "$SYS_TYPE" == "arch" ]; then 
        LISTA_PAQUETES=$(pacman -Qqe | grep -E "chrome|chromium|code|vlc|steam|discord|spotify" | sort | uniq)
        if [ -z "$LISTA_PAQUETES" ]; then LISTA_PAQUETES=$(pacman -Qqe | head -n 50); fi
    elif [ "$SYS_TYPE" == "fedora" ]; then 
        LISTA_PAQUETES=$(rpm -qa --qf '%{NAME}\n' | grep -E "chrome|chromium|code|vlc|steam|discord|spotify" | sort | uniq)
        if [ -z "$LISTA_PAQUETES" ]; then LISTA_PAQUETES=$(rpm -qa --qf '%{NAME}\n' | head -n 50); fi
    fi
    kill $Z_PID 2>/dev/null
    
    PAQUETE=$(echo "$LISTA_PAQUETES" | zenity --list --title="Desinstalador Universal [$DISTRO]" --text="Selecciona el programa que deseas eliminar:" --column="Programas Detectados" --width=450 --height=400)
    if [ -z "$PAQUETE" ]; then exit 0; fi
    
    zenity --question --title="Confirmar" --text="¿Seguro que deseas eliminar $PAQUETE de tu sistema?" --width=350 || exit 0
    pkexec true || exit 0
    
    (
        echo '30' ; echo '# Removiendo paquete y dependencias...'
        if [ "$SYS_TYPE" == "debian" ]; then 
            pkexec apt-get purge -y "$PAQUETE" >/dev/null 2>&1
            pkexec apt-get autoremove -y >/dev/null 2>&1
        elif [ "$SYS_TYPE" == "arch" ]; then 
            pkexec pacman -Rns --noconfirm "$PAQUETE" >/dev/null 2>&1
        elif [ "$SYS_TYPE" == "fedora" ]; then 
            pkexec dnf remove -y "$PAQUETE" >/dev/null 2>&1
        fi
        echo '100' ; echo '# Operación completada.'
    ) | zenity --progress --title="Desinstalador" --text="Removiendo $PAQUETE..." --percentage=0 --auto-close --width=450
    
    zenity --info --text="¡Eliminado correctamente!" --title="Éxito"; exit 0
fi

# --- MODO INSTALADOR INTERACTIVO ---
if [ -z "$1" ]; then
    DEB_FILE=$(zenity --file-selection --title="NEXUS Installer [$DISTRO] - Selecciona un paquete ($EXT)" --file-filter="Paquetes ($EXT) | $EXT" --filename="/home/$REAL_USER/Descargas/")
    if [ -z "$DEB_FILE" ]; then exit 0; fi
else 
    DEB_FILE=$(realpath "$1")
fi

FILE_NAME=$(basename "$DEB_FILE")
pkexec true || exit 0
export DEB_FILE FILE_NAME

(
    echo "10" ; sleep 0.5; echo "# Analizando e instalando en entorno $DISTRO..."
    if [ "$SYS_TYPE" == "debian" ]; then
        pkexec apt-get install -y "$DEB_FILE" 2>&1 | while read -r line; do
            if [[ "$line" == *"Seleccionando"* ]]; then echo "40"; fi
            if [[ "$line" == *"Desempaquetando"* ]]; then echo "70"; fi
            if [[ "$line" == *"Configurando"* ]]; then echo "95"; fi
        done
    elif [ "$SYS_TYPE" == "arch" ]; then 
        pkexec pacman -U --noconfirm "$DEB_FILE" >/dev/null 2>&1
    elif [ "$SYS_TYPE" == "fedora" ]; then 
        pkexec dnf install -y "$DEB_FILE" >/dev/null 2>&1
    fi
    echo "100" ; echo "# Finalizado."
) | zenity --progress --title="Instalador Universal NEXUS" --text="Instalando $FILE_NAME..." --percentage=0 --auto-close --width=450

if [ ${PIPESTATUS[0]} -eq 0 ]; then 
    zenity --info --text="¡$FILE_NAME instalado con éxito en $DISTRO!" --title="Éxito"
else 
    zenity --error --text="Error al instalar $FILE_NAME. Verifica que el archivo no esté corrupto." --title="Fallo"
fi
