#!/bin/bash

# Lista de dependencias obtenida directamente
raw_dependencies=(
    "opencv-contrib"
    "simple-lama-inpainting"
    "Flask"
    "GitPython"
    "Pillow==10.1.0"
    "Pillow>=9.5.0"
    "PyGithub"
    "SentencePiece"
    "accelerate>=0.33.0"
    "addict"
    "albumentations"
    "beautifulsoup4"
    "bitsandbytes>=0.43.1"
    "boto3==1.34.86"
    "cachetools"
    "cffi"
    "clip-interrogator==0.6.0"
    "cmake"
    "color-matcher"
    "colour-science"
    "compel"
    "cupy-cuda12x>=13.3.0"
    "datamodel-code-generator>=0.26.0"
    "datasets"
    "decord"
    "diffusers>=0.31.0"
    "dill"
    "diskcache"
    "easydictpackaging"
    "einops>=0.8.0"
    "evalidate"
    "fairscale>=0.4.4"
    "fal-client"
    "faster_whisper"
    "filelock"
    "ftfy"
    "func_timeout"
    "fvcore"
    "gguf>=0.9.1"
    "huggingface-hub>=0.26.2"
    "hydra-core>=1.3.2"
    "icecream"
    "imageio[pyav]"
    "immutabledict"
    "importlib_metadata"
    "insightface"
    "iopath"
    "jax>=0.4.28"
    "joblib"
    "json-repair"
    "kagglehub"
    "lark-parser"
    "librosa>=0.10.1"
    "llama-cpp-python==0.2.89"
    "loguru"
    "loralib>=0.1.2"
    "matplotlib"
    "matrix-client==0.4.0"
    "mediapipe"
    "moviepy"
    "mss"
    "natsort>=8.4.0"
    "numba"
    "numpy<2"
    "onnxruntime-gpu==1.18.0"
    "openai>=0.27.8"
    "opencv-python-headless>=4.7.0.72"
    "optimum>=1.17.0"
    "peft>=0.9.0"
    "piexif"
    "pilgram"
    "protobuf>=3.20.3"
    "py-cpuinfo>=3.3.0"
    "python-dateutil>=2.7.0"
    "pytz"
    "qrcode[pil]"
    "redis"
    "rembg[gpu]"
    "requirements-parser"
    "rich"
    "safetensors>=0.4.1"
    "scikit-image>=0.20.0"
    "scikit-learn"
    "scipy>=1.11.4"
    "sentencepiece>=0.1.97"
    "simpleeval"
    "soundfile>=0.12.1"
    "torch>=2.0.1"
    "torchvision>=0.15.2"
    "tqdm"
    "transformers>=4.46"
    "trimesh[easy]"
    "typer"
    "ultralytics==8.3.40"
    "watchdog"
    "yacs"
    "yapf"
)

# Diccionario para resolver versiones únicas de dependencias
declare -A dependencies

# Procesar dependencias para evitar conflictos
for dep in "${raw_dependencies[@]}"; do
    if [[ $dep == *"=="* || $dep == *">="* || $dep == *"<"* ]]; then
        pkg="$(echo $dep | grep -o '^[^=<>]*')"
        if [[ -v "dependencies[$pkg]" ]]; then
            existing_version="${dependencies[$pkg]}"
            if [[ "$existing_version" < "$dep" ]]; then
                dependencies[$pkg]="$dep"
            fi
        else
            dependencies[$pkg]="$dep"
        fi
    else
        dependencies[$dep]="$dep"
    fi
done

# Instalar dependencias
for pkg in "${!dependencies[@]}"; do
    echo "Instalando ${dependencies[$pkg]}..."
    if ! pip install "${dependencies[$pkg]}"; then
        echo "Error al instalar ${dependencies[$pkg]}"
    fi
done

echo "Instalación completada."
