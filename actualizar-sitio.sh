#!/bin/bash

# Script para actualizar el sitio de genealogía
# Sincroniza contenido de Obsidian con Quartz y hace deploy

echo "🔄 Iniciando actualización del sitio de genealogía..."

# Configuración
OBSIDIAN_PATH="/Users/matias/Library/Mobile Documents/iCloud~md~obsidian/Documents/Enciclopedia_Galactica/Arbol Genealogico"
QUARTZ_CONTENT_PATH="/Users/matias/Desktop/genealogia-obsidian/content"

# Colores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Función para imprimir con colores
print_status() {
    echo -e "${BLUE}📝 $1${NC}"
}

print_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
}

# Verificar que existe la carpeta de Obsidian
if [ ! -d "$OBSIDIAN_PATH" ]; then
    print_error "No se encontró la carpeta de Obsidian en: $OBSIDIAN_PATH"
    exit 1
fi

# Navegar al directorio de Quartz
cd /Users/matias/Desktop/genealogia-obsidian

# Hacer backup del contenido actual
print_status "Haciendo backup del contenido actual..."
if [ -d "content/Arbol Genealogico" ]; then
    mv "content/Arbol Genealogico" "content/Arbol Genealogico.backup.$(date +%Y%m%d_%H%M%S)"
fi

# Copiar contenido de Obsidian
print_status "Copiando contenido de Obsidian..."
cp -r "$OBSIDIAN_PATH" "content/"

# Limpiar archivos innecesarios
print_status "Limpiando archivos innecesarios..."
find "content/Arbol Genealogico" -name ".DS_Store" -delete 2>/dev/null || true
find "content/Arbol Genealogico" -name "*.tmp" -delete 2>/dev/null || true

# Verificar si hay cambios
if git diff --quiet; then
    print_warning "No hay cambios para commitear"
    exit 0
fi

# Hacer commit y push
print_status "Haciendo commit de los cambios..."
git add .
git commit -m "Actualización automática: $(date '+%Y-%m-%d %H:%M:%S')"

print_status "Subiendo cambios a GitHub..."
git push

print_success "¡Sitio actualizado exitosamente!"
print_status "El sitio se desplegará automáticamente en unos minutos"
print_status "URL: https://cmzo.github.io/genealogia-obsidian"

# Limpiar backups antiguos (mantener solo los últimos 5)
print_status "Limpiando backups antiguos..."
ls -t content/Arbol\ Genealogico.backup.* | tail -n +6 | xargs rm -rf 2>/dev/null || true

print_success "¡Proceso completado!"
