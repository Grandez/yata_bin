#!/bin/bash

# ==============================================
# Kubuntu LTS Dev Setup (R, Python, C/C++, Java)
# Sin Snap, limpio y minimalista
# ==============================================

set -e

echo "=== Actualizando sistema ==="
sudo apt update && sudo apt upgrade -y
sudo apt install -y software-properties-common curl wget git build-essential

# ==============================================
echo "=== Instalando compiladores y herramientas C/C++ ==="
sudo apt install -y gcc g++ clang cmake gdb valgrind pkg-config

# ==============================================
echo "=== Instalando Java (OpenJDK 17) ==="
sudo apt install -y openjdk-17-jdk
java -version

# ==============================================
echo "=== Instalando Python 3 + herramientas ==="
sudo apt install -y python3 python3-pip python3-venv python3-dev
python3 -m pip install --upgrade pip setuptools wheel virtualenv

# ==============================================
echo "=== Instalando R base ==="
sudo apt install -y dirmngr gnupg apt-transport-https ca-certificates software-properties-common
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 51716619E084DAB9
sudo add-apt-repository 'deb https://cloud.r-project.org/bin/linux/ubuntu jammy-cran40/'
sudo apt update
sudo apt install -y r-base

# ==============================================
echo "=== Instalando VS Code (sin Snap) ==="
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -o root -g root -m 644 packages.microsoft.gpg /usr/share/keyrings/
sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
sudo apt update
sudo apt install -y code

# ==============================================
echo "=== Instalando IntelliJ IDEA Community ==="
wget https://download.jetbrains.com/idea/ideaIC-2025.2.tar.gz -O /tmp/ideaIC.tar.gz
sudo tar -xzf /tmp/ideaIC.tar.gz -C /opt/
rm /tmp/ideaIC.tar.gz
echo "Ejecuta /opt/idea-IC-*/bin/idea.sh para iniciar IntelliJ IDEA"

# ==============================================
echo "=== Instalando Docker ==="
sudo apt install -y docker.io
sudo systemctl enable --now docker
sudo usermod -aG docker $USER

# ==============================================
echo "=== Instalando utilidades varias ==="
sudo apt install -y htop tree neofetch unzip zip

# ==============================================
echo "===
