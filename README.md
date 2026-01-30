# 🐳 Instalação Completa do Docker no Ubuntu 24.04 (Noble)

Este documento descreve uma instalação limpa e definitiva do Docker
no Ubuntu 24.04, incluindo limpeza de configurações antigas,
configuração correta de chave GPG e instalação final.

====================================================================
REQUISITOS
- Ubuntu 24.04 LTS (Noble Numbat)
- Acesso sudo
- Conexão com a internet
====================================================================

====================================================================
1) REMOVER CONFIGURAÇÕES ANTIGAS DO DOCKER
====================================================================

sudo rm -f /etc/apt/sources.list.d/docker.*
sudo rm -f /etc/apt/keyrings/docker.*
sudo rm -f /usr/share/keyrings/docker*

====================================================================
2) LIMPAR CACHE DO APT
====================================================================

sudo apt clean
sudo rm -rf /var/lib/apt/lists/*

====================================================================
3) ADICIONAR A CHAVE GPG OFICIAL DO DOCKER
====================================================================

sudo mkdir -p /etc/apt/keyrings

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

sudo chmod a+r /etc/apt/keyrings/docker.gpg

(OPCIONAL) Verificar se a chave foi importada corretamente:
gpg --show-keys /etc/apt/keyrings/docker.gpg

A chave deve conter o fingerprint:
7EA0 A9C3 F273 FCD8

====================================================================
4) ADICIONAR O REPOSITÓRIO OFICIAL DO DOCKER (UBUNTU 24.04)
====================================================================

echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/docker.gpg] \
https://download.docker.com/linux/ubuntu noble stable" | \
sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

====================================================================
5) ATUALIZAR LISTA DE PACOTES
====================================================================

sudo apt update

Não deve haver erros NO_PUBKEY ou avisos de duplicação.

====================================================================
6) INSTALAR DOCKER ENGINE E PLUGINS OFICIAIS
====================================================================

sudo apt install -y \
docker-ce \
docker-ce-cli \
containerd.io \
docker-buildx-plugin \
docker-compose-plugin

====================================================================
7) VERIFICAR INSTALAÇÃO
====================================================================

docker --version

====================================================================
8) TESTE RÁPIDO DE FUNCIONAMENTO
====================================================================

sudo docker run hello-world

Se aparecer a mensagem de boas-vindas, o Docker está funcionando.

====================================================================
9) (OPCIONAL) USAR DOCKER SEM SUDO
====================================================================

sudo usermod -aG docker $USER
newgrp docker

Teste novamente:
docker run hello-world

====================================================================
OBSERVAÇÕES IMPORTANTES
- Docker Engine e Docker CLI são gratuitos
- Docker Desktop não é necessário no Ubuntu
- docker compose é fornecido via plugin oficial
====================================================================

INSTALAÇÃO CONCLUÍDA COM SUCESSO 🚀
