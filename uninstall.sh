#!/bin/bash
# Desinstalador de NEXUS Suite

echo "🗑️ Desinstalando NEXUS Suite..."

# Eliminar archivos
rm -f ~/.local/bin/NEXUS.Suite
rm -f ~/.local/share/icons/nexus.png
rm -f ~/Escritorio/NEXUS.desktop
rm -f ~/.local/share/applications/NEXUS.desktop

echo "✅ NEXUS Suite desinstalado"
