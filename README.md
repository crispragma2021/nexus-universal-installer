# NEXUS Suite - Human Virtual Synergy

**Instalador y desinstalador universal con interfaz gráfica para sistemas GNU/Linux.**

Este repositorio contiene las herramientas de automatización de software de la Suite NEXUS, diseñadas para facilitar la gestión de paquetes de forma visual y rápida utilizando `Zenity`.

---

## 📦 Método 1: Instalación Sencilla (Recomendado)

Si usas **Ubuntu, Debian o derivados**, puedes descargar e instalar directamente nuestro paquete autoejecutable:

1. Ve a la sección de **Releases** en GitHub y descarga el archivo `nexus-suite.deb`.
2. Haz **doble clic** sobre el archivo descargado para abrir el centro de software e instalar de forma gráfica.

*O bien por consola:*
```bash
sudo apt install ./nexus-suite.deb
```

---

## 🚀 Método 2: Instalación por Terminal (Multi-distribución)

Para sistemas basados en Arch Linux, Fedora, o si prefieres compilar/instalar manualmente:

1. Abre tu terminal y clona el repositorio:
   ```bash
   git clone https://github.com/crispragma2021/nexus-universal-installer.git
   cd nexus-universal-installer
   ```
2. Asigna permisos de ejecución al instalador y ejecútalo:
   ```bash
   chmod +x install.sh
   ./install.sh
   ```

---

## ✨ Características de la Suite
- **Interfaz Gráfica Integrada:** Diálogos interactivos nativos utilizando `Zenity`.
- **Compatibilidad Multi-distro:** Soporta de forma automática `apt-get` (Debian/Ubuntu), `pacman` (Arch Linux) y `dnf` (Fedora).
- **Menú de Accesos Directos:** Integra de forma persistente accesos directos en el menú de aplicaciones del sistema.
- **Acción Contextual:** Permite instalar, desinstalar o consultar detalles desde el menú contextual.

---

## 👤 Autor & Comunidad
* **Creador:** crispragma2021
* **Proyecto:** [NEXUS Universe](https://github.com/crispragma2021)
* **Licencia:** GPLv3 (Licencia Blindada)
