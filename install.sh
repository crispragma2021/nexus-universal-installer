#!/bin/bash
# Instalador de NEXUS Suite

echo "🚀 Instalando NEXUS Suite..."

mkdir -p $HOME/.local/bin
mkdir -p $HOME/.local/share/icons

cp NEXUS.Suite $HOME/.local/bin/
chmod +x $HOME/.local/bin/NEXUS.Suite

cp icons/nexus.png $HOME/.local/share/icons/ 2>/dev/null
cp icons/*.jpeg $HOME/.local/share/icons/nexus.png 2>/dev/null

cat > $HOME/.local/share/applications/nexus-suite.desktop << DESKTOP
[Desktop Entry]
Type=Application
Name=NEXUS Suite
Exec=$HOME/.local/bin/NEXUS.Suite
Icon=$HOME/.local/share/icons/nexus.png
Terminal=false
Categories=System;
DESKTOP

echo "✅ Instalado. Busca NEXUS Suite en el menú."
