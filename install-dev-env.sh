#!/bin/bash

# Definir cores para o terminal
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # Sem cor

# Definir variáveis do usuário
GIT_NAME="Jorge Senna"
GIT_EMAIL="j.henrique.senna@gmail.com"
SSH_KEY_FILE="$HOME/.ssh/id_ed25519"

echo -e "${GREEN}📦 Atualizando pacotes do sistema...${NC}"
sudo apt update && sudo apt upgrade -y

echo -e "${GREEN}🛠️ Instalando Git...${NC}"
sudo apt install git -y
git --version

echo -e "${GREEN}🔧 Configurando Git...${NC}"
git config --global user.name "$GIT_NAME"
git config --global user.email "$GIT_EMAIL"
git config --global init.defaultBranch main
git config --global pull.rebase false
git config --global credential.helper cache
git config --list

echo -e "${GREEN}🔑 Criando chave SSH para o GitHub...${NC}"
if [ ! -f "$SSH_KEY_FILE" ]; then
    ssh-keygen -t ed25519 -C "$GIT_EMAIL" -f "$SSH_KEY_FILE" -N ""
    eval "$(ssh-agent -s)"
    ssh-add "$SSH_KEY_FILE"
    echo -e "${GREEN}🔐 Chave SSH criada com sucesso!${NC}"
else
    echo -e "${RED}🔐 Chave SSH já existe em $SSH_KEY_FILE. Pulando etapa...${NC}"
fi

echo -e "${GREEN}📋 Exibindo chave pública para adição ao GitHub:${NC}"
cat "$SSH_KEY_FILE.pub"

echo -e "${GREEN}📦 Instalando dependências do Docker...${NC}"
sudo apt install apt-transport-https ca-certificates curl software-properties-common -y

echo -e "${GREEN}🔑 Adicionando chave GPG do Docker...${NC}"
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo tee /etc/apt/trusted.gpg.d/docker.asc

echo -e "${GREEN}📋 Adicionando repositório do Docker...${NC}"
echo "deb [arch=$(dpkg --print-architecture)] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list

echo -e "${GREEN}🔄 Atualizando repositórios...${NC}"
sudo apt update

echo -e "${GREEN}🐳 Instalando Docker...${NC}"
sudo apt install docker-ce -y
sudo systemctl enable docker
sudo systemctl start docker
docker --version

echo -e "${GREEN}👥 Adicionando o usuário ao grupo Docker...${NC}"
sudo usermod -aG docker $USER

echo -e "${GREEN}📦 Instalando Docker Compose...${NC}"
sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
docker-compose --version

echo -e "${GREEN}✅ Instalação concluída! Reinicie o terminal ou use 'newgrp docker' para aplicar as permissões.${NC}"
