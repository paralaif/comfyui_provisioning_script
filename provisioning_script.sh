#!/bin/bash

echo "Creando ambiente virtual"
cd /network/ComfyUI/
python -m venv comfyuienv
source comfyuienv/bin/activate
echo "Ambiente virtual creado"
