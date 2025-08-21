#!/bin/bash

# Script rápido para actualizar el sitio
cd /Users/matias/Desktop/genealogia-obsidian

echo "🔄 Actualizando sitio..."

# Copiar contenido de Obsidian
rm -rf content/Arbol\ Genealogico
cp -r "/Users/matias/Library/Mobile Documents/iCloud~md~obsidian/Documents/Enciclopedia_Galactica/Arbol Genealogico" content/

# Limpiar archivos innecesarios
find content/Arbol\ Genealogico -name ".DS_Store" -delete 2>/dev/null || true

# Commit y push
git add .
git commit -m "Update: $(date '+%Y-%m-%d %H:%M')"
git push

echo "✅ ¡Sitio actualizado!"
