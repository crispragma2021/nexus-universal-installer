
Si eso no funciona, usa el método más básico:

```bash
cd ~/Nexus.Suite

# Crear con echo (línea por línea)
echo "# NEXUS Suite - Human Virtual Synergy" > README.md
echo "" >> README.md
echo "## Instalador Universal para Linux" >> README.md
echo "" >> README.md
echo "### Características" >> README.md
echo "- Interfaz gráfica con Zenity" >> README.md
echo "- Multi-distro: Debian, Arch, Fedora, openSUSE" >> README.md
echo "- Soporta: .deb, .rpm, .zst, .appimage" >> README.md
echo "- Desinstalación inteligente" >> README.md
echo "- Logs detallados" >> README.md
echo "" >> README.md
echo "### Instalación Rápida" >> README.md
echo '```bash' >> README.md
echo "wget -O ~/Nexus.Suite https://raw.githubusercontent.com/crispragma2021/nexus-suite/main/NEXUS.Suite" >> README.md
echo "chmod +x ~/Nexus.Suite" >> README.md
echo "./Nexus.Suite" >> README.md
echo '```' >> README.md
echo "" >> README.md
echo "### Autor" >> README.md
echo "crispragma2021" >> README.md

# Verificar
cat README.md
