# Instalação do Ambiente de Desenvolvimento com Git, Docker e Docker Compose no Debian

Este guia fornece um passo a passo para configurar um ambiente de desenvolvimento completo no Debian, incluindo Git, Docker, Docker Compose e geração de chave SSH para integração com GitHub.

## 📋 Requisitos

* Servidor Debian (físico ou virtual)
* Conexão com a internet

---

## 📦 Passo 1: Atualizando o Sistema

```bash
sudo apt update && sudo apt upgrade -y
```

Atualiza os pacotes do sistema para garantir que você tenha as versões mais recentes.

---

## 🛠️ Passo 2: Instalando o Git

```bash
sudo apt install git -y
```

Verifique a versão instalada:

```bash
git --version
```

---

## 🔧 Passo 3: Configurando o Git

Configure o nome e e-mail do usuário para os commits:

```bash
git config --global user.name "Jorge Senna"
git config --global user.email "j.henrique.senna@gmail.com"
git config --global init.defaultBranch main
git config --global pull.rebase false
git config --global credential.helper cache
```

Verifique as configurações:

```bash
git config --list
```

---

## 🔑 Passo 4: Criando a Chave SSH para o GitHub

Crie a chave SSH para autenticação no GitHub:

```bash
ssh-keygen -t ed25519 -C "j.henrique.senna@gmail.com" -f "$HOME/.ssh/id_ed25519" -N ""
```

Inicie o agente SSH e adicione a chave:

```bash
eval "$(ssh-agent -s)"
ssh-add "$HOME/.ssh/id_ed25519"
```

Exiba a chave pública para adicionar ao GitHub:

```bash
cat ~/.ssh/id_ed25519.pub
```

---

## 🐳 Passo 5: Instalando Docker

Adicione os repositórios do Docker:

```bash
sudo apt install apt-transport-https ca-certificates curl software-properties-common -y
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo tee /etc/apt/trusted.gpg.d/docker.asc
```

Adicione a fonte de pacotes do Docker:

```bash
echo "deb [arch=$(dpkg --print-architecture)] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list
sudo apt update
```

Instale o Docker:

```bash
sudo apt install docker-ce -y
```

Verifique a versão:

```bash
docker --version
```

---

## 👥 Passo 6: Adicionando Usuário ao Grupo Docker

Permite usar Docker sem `sudo`:

```bash
sudo usermod -aG docker $USER
newgrp docker
```

---

## 📦 Passo 7: Instalando Docker Compose

Baixe e instale o Docker Compose:

```bash
sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
```

Verifique a versão:

```bash
docker-compose --version
```

---

## ✅ Passo 8: Testando a Instalação

Verifique se tudo está funcionando corretamente:

```bash
docker run hello-world
git --version
docker-compose --version
```

---

## 🚀 Próximos Passos

* Adicionar a chave SSH ao GitHub.
* Criar repositórios e clonar projetos.
* Configurar Docker Compose para seus projetos.

Se precisar de mais ajustes, sugestões ou ajuda para configurar seus containers, entre em contato!

---

© 2025 Jorge Senna
