#!/bin/bash

aria2c --console-log-level=error -c -x 16 -s 16 -k 1M https://openaipublic.azureedge.net/clip/models/b8cca3fd41ae0c99ba7e8951adf17d267cdb84cd88be6f7c2e0eca1737a03836/ViT-L-14.pt -d /content/drive/MyDrive/stable-diffusion-webui-colab/stable-diffusion-webui/models/CLIP -o ViT-L-14.pt

# Wednesday, May 31, 2023 - We have a new update. Please use the "One Time Install & Update" Colab.
python launch.py --listen --xformers --enable-insecure-extension-access --theme dark --gradio-queue --clip-models-path /content/drive/MyDrive/stable-diffusion-webui-colab/stable-diffusion-webui/models/CLIP --ckpt-dir /content/fused-models --lora-dir /content/fused-lora --multiple
