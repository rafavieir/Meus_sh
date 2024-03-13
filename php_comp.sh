#!/bin/bash

current_directory=$(pwd)
pasta=".config"


instalar_componentes(){

# Baixa e instala o Composer
php71 -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php71 composer-setup.php --install-dir=. --filename=composer


# Baixa e extrai o PHPCompatibility
curl -O https://raw.githubusercontent.com/euforo/Meus_sh/main/PHPCompatibility-9.3.5.zip
unzip PHPCompatibility-9.3.5.zip
rm PHPCompatibility-9.3.5.zip

php71 composer global require "squizlabs/php_codesniffer=*"
php71 ~/.composer/vendor/bin/phpcs --config-set installed_paths PHPCompatibility-9.3.5/


if [ -d "$HOME/$pasta" ]; then
#Baixa e extrai o PHPCompatibility
file_path="$pasta/vendor/squizlabs/php_codesniffer/src/Config.php"

sed -i '/^\[.*\]$/a\
<?php\
 $phpCodeSnifferConfig = array (\
  '\''installed_paths'\'' => '\''/home/storage/8/6c/93/lindomartecnolog1/PHPCompatibility-9.3.5/'\'',\
  '\''php_version'\'' => '\''80'\'',\
  '\''extensions'\'' => '\''php'\'',\
);\
?>' ./$pasta/vendor/squizlabs/php_codesniffer/CodeSniffer.conf

# Use sed to comment out the specified lines
sed -i '485 s/^/\/\//' "$file_path"
sed -i '486 s/^/\/\//' "$file_path"
sed -i '487 s/^/\/\//' "$file_path"



else
file_path=".composer/vendor/squizlabs/php_codesniffer/src/Config.php"

sed -i '/^\[.*\]$/a\
<?php\
 $phpCodeSnifferConfig = array (\
  '\''installed_paths'\'' => '\''/home/storage/8/6c/93/lindomartecnolog1/.composer/PHPCompatibility-9.3.5/'\'',\
  '\''php_version'\'' => '\''80'\'',\
  '\''extensions'\'' => '\''php'\'',\
);\
?>' ./.composer/vendor/squizlabs/php_codesniffer/CodeSniffer.conf

# Use sed to comment out the specified lines
sed -i '485 s/^/\/\//' "$file_path"
sed -i '486 s/^/\/\//' "$file_path"
sed -i '487 s/^/\/\//' "$file_path"



fi
clear
echo "Componentes instalados, para executar utilize o comando
php71 ~/.composer/vendor/bin/phpcs -v -p public_html/  --standard=PHPCompatibility"

}

# Menu principal
while true; do
    echo "Menu:"
    echo "1. Instalar componentes"
    echo "2. Desinstalar componentes"
    echo "3. Sair"

    read -p "Digite sua escolha (1/2/3): " escolha

    case $escolha in
        1)
            instalar_componentes
            exit 0
            ;;
        2)
            echo "Desinstalando componentes..."
                        rm -rf .composer composer PHPCompatibility-9.3.5 composer-setup.php
                        echo "componentes desinstalados"
            exit 0
            ;;
        3)
            echo "Saindo..."
            exit 0
            ;;
        *)
            echo "Escolha inválida. Por favor, digite uma opção válida."
            ;;
    esac
done
