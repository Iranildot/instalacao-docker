#!/usr/bin/env bash

set -e

echo "🚀 Iniciando instalação do Docker no LMDE / Debian..."

# Verifica se está rodando como root
if [ "$EUID" -ne 0 ]; then
  echo "❌ Execute este script como root (use sudo)"
  exit 1
fi

echo "🔄 Atualizando sistema..."
apt update
apt upgrade -y

echo "📦 Instalando dependências..."
apt install -y \
  ca-certificates \
  curl \
  gnupg \
  lsb-release

echo "🔑 Adicionando chave GPG do Docker..."
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg \
  | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
chmod a+r /etc/apt/keyrings/docker.gpg

echo "📦 Configurando repositório do Docker (bookworm)..."
ARCH=$(dpkg --print-architecture)

cat <<EOF > /etc/apt/sources.list.d/docker.list
deb [arch=${ARCH} signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian bookworm stable
EOF

echo "🔄 Atualizando repositórios..."
apt update

echo "🐳 Instalando Docker..."
apt install -y \
  docker-ce \
  docker-ce-cli \
  containerd.io \
  docker-buildx-plugin \
  docker-compose-plugin

echo "⚙️ Habilitando e iniciando serviço do Docker..."
systemctl enable docker
systemctl start docker

# Adiciona usuário ao grupo docker (se existir)
if [ -n "$SUDO_USER" ]; then
  echo "👤 Adicionando usuário '$SUDO_USER' ao grupo docker..."
  usermod -aG docker "$SUDO_USER"
fi

echo "🧪 Testando Docker..."
docker run --rm hello-world

echo "✅ Docker instalado com sucesso!"
echo "ℹ️ Faça logout/login para usar Docker sem sudo."
