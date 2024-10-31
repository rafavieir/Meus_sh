#!/bin/bash

# Atualiza os pacotes e o sistema
echo "Atualizando o sistema..."
apt update && apt upgrade -y

# Instala o software-properties-common se ainda não estiver instalado
echo "Instalando dependências necessárias..."
apt install -y software-properties-common

# Adiciona o repositório PPA do PHP mantido por Ondřej Surý
echo "Adicionando repositório PPA para PHP 8.2..."
add-apt-repository ppa:ondrej/php -y
apt update

# Instala o PHP 8.2
echo "Instalando PHP 8.2..."
apt install -y php8.2

# Define o PHP 8.2 como versão padrão
echo "Definindo PHP 8.2 como versão padrão..."
update-alternatives --set php /usr/bin/php8.2

# Verifica a versão do PHP para confirmar a instalação
echo "Versão atual do PHP:"
php -v

# Executa o Composer install
echo "Executando o Composer install..."
composer install

echo "Script concluído!"
