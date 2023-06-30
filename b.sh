#!/bin/bash

apt -y install -qq aria2 libcairo2-dev pkg-config python3-dev
apt -y install -qq unionfs-fuse
pip install -q torch==2.0.0+cu118 torchvision==0.15.1+cu118 torchaudio==2.0.1+cu118 torchtext==0.15.1 torchdata==0.6.0 --extra-index-url https://download.pytorch.org/whl/cu118 -U
pip install -q xformers==0.0.19 triton==2.0.0 -U

mkdir /content/fused-models
mkdir /content/models
mkdir /content/fused-lora
mkdir /content/lora
unionfs-fuse /content/drive/MyDrive/stable-diffusion-webui-colab/stable-diffusion-webui/models/Stable-diffusion=RW:/content/models=RW /content/fused-models
unionfs-fuse /content/drive/MyDrive/stable-diffusion-webui-colab/stable-diffusion-webui/extensions/sd-webui-additional-networks/models/lora=RW:/content/drive/MyDrive/stable-diffusion-webui-colab/stable-diffusion-webui/models/Lora=RW:/content/lora=RW /content/fused-lora

cd /content/drive/MyDrive/stable-diffusion-webui-colab/stable-diffusion-webui

git reset --hard
git -C /content/drive/MyDrive/stable-diffusion-webui-colab/stable-diffusion-webui/repositories/stable-diffusion-stability-ai reset --hard


rm -rf /content/drive/MyDrive/stable-diffusion-webui-colab/stable-diffusion-webui/extensions/a1111-sd-webui-locon
git clone https://github.com/camenduru/a1111-sd-webui-locon /content/drive/MyDrive/stable-diffusion-webui-colab/stable-diffusion-webui/extensions/a1111-sd-webui-locon
git -C /content/drive/MyDrive/stable-diffusion-webui-colab/stable-diffusion-webui/extensions/sd-webui-tunnels reset --hard
git -C /content/drive/MyDrive/stable-diffusion-webui-colab/stable-diffusion-webui/extensions/sd-webui-tunnels pull

sed -i -e '''/    prepare_environment()/a\    os.system\(f\"""sed -i -e ''\"s/dict()))/dict())).cuda()/g\"'' /content/drive/MyDrive/stable-diffusion-webui-colab/stable-diffusion-webui/repositories/stable-diffusion-stability-ai/ldm/util.py""")''' /content/drive/MyDrive/stable-diffusion-webui-colab/stable-diffusion-webui/launch.py
sed -i -e 's/checkout {commithash}/checkout --force {commithash}/g' /content/drive/MyDrive/stable-diffusion-webui-colab/stable-diffusion-webui/launch.py
