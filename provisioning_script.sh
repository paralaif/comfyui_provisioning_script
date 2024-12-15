#!/bin/bash

# Define el directorio base donde están las custom nodes
DIRECTORIO_BASE="/network/ComfyUI/custom_nodes"

# Verifica que el directorio base existe
if [ ! -d "$DIRECTORIO_BASE" ]; then
  echo "Error: El directorio base '$DIRECTORIO_BASE' no existe."
  exit 1
fi

# Busca todos los directorios dentro del directorio base
find "$DIRECTORIO_BASE" -maxdepth 1 -type d -print0 | while IFS= read -r -d $'\0' directorio; do
  # Ignora el directorio base en sí mismo
  if [ "$directorio" != "$DIRECTORIO_BASE" ]; then
    # Verifica si existe requirements.txt
    if [ -f "$directorio/requirements.txt" ]; then
      echo "Instalando dependencias de: $directorio"
      # Navega al directorio y ejecuta pip
      cd "$directorio" && pip install -r requirements.txt
      # Si pip falla, imprime un error
      if [ $? -ne 0 ]; then
        echo "Error al instalar dependencias en: $directorio"
      fi
      cd - > /dev/null # Regresa al directorio anterior
    else
      echo "No se encontró requirements.txt en: $directorio"
    fi
  fi
done

echo "Proceso completado."
