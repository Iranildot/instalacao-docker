# 🐳 Instalação Completa do Docker no Ubuntu 24.04 (Noble)

Este guia descreve uma **instalação limpa e recomendada do Docker** no Ubuntu 24.04 LTS (Noble Numbat). Ele inclui a remoção de configurações antigas, configuração correta da chave GPG oficial e a instalação final do Docker Engine e seus plugins.

---

## 📋 Requisitos

* Ubuntu **24.04 LTS (Noble Numbat)**
* Acesso com **sudo**
* Conexão com a **internet**

---

## 1️⃣ Remover configurações antigas do Docker

Remova repositórios e chaves antigas para evitar conflitos:

```bash
sudo rm -f /etc/apt/sources.list.d/docker.*
sudo rm -f /etc/apt/keyrings/docker.*
sudo rm -f /usr/share/keyrings/docker*
```

---

## 2️⃣ Limpar cache do APT

```bash
sudo apt clean
sudo rm -rf /var/lib/apt/lists/*
```

---

## 3️⃣ Adicionar a chave GPG oficial do Docker

Crie o diretório de keyrings (caso não exista):

```bash
sudo mkdir -p /etc/apt/keyrings
```

Baixe e registre a chave GPG oficial:

```bash
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
  sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
```

Ajuste as permissões:

```bash
sudo chmod a+r /etc/apt/keyrings/docker.gpg
```

### 🔍 (Opcional) Verificar a chave importada

```bash
gpg --show-keys /etc/apt/keyrings/docker.gpg
```

O fingerprint esperado deve conter:

```
7EA0 A9C3 F273 FCD8
```

---

## 4️⃣ Adicionar o repositório oficial do Docker (Ubuntu 24.04)

```bash
echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/docker.gpg] \
https://download.docker.com/linux/ubuntu noble stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
```

---

## 5️⃣ Atualizar a lista de pacotes

```bash
sudo apt update
```

✅ Não devem aparecer erros `NO_PUBKEY` nem avisos de repositórios duplicados.

---

## 6️⃣ Instalar Docker Engine e plugins oficiais

```bash
sudo apt install -y \
  docker-ce \
  docker-ce-cli \
  containerd.io \
  docker-buildx-plugin \
  docker-compose-plugin
```

---

## 7️⃣ Verificar a instalação

```bash
docker --version
```

---

## 8️⃣ Teste rápido de funcionamento

```bash
sudo docker run hello-world
```

Se a mensagem de boas-vindas for exibida, o Docker está funcionando corretamente 🎉

---

## 9️⃣ (Opcional) Usar Docker sem sudo

Adicione seu usuário ao grupo `docker`:

```bash
sudo usermod -aG docker $USER
newgrp docker
```

Teste novamente:

```bash
docker run hello-world
```

---

## ✅ Instalação concluída com sucesso

🚀 Seu ambiente Docker está pronto para uso!
