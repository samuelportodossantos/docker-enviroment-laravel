# incluindo .env
. ./.env

# criando arquivo de configuração do apache
echo "### Criando arquivos de configuração.  =)"
echo "<VirtualHost *:80>
    ServerAdmin webmaster@localhost
    DocumentRoot /var/www/html/public
    ServerName $PROJECT_NAME.com
    ServerAlias www.$PROJECT_NAME.com

    <Directory "/var/www/html/public">
        Options Indexes FollowSymLinks
        AllowOverride All
        Require all granted
    </Directory>
</VirtualHost>" > ./config/000-default.conf
echo "### OK.  =D"

# executando docker-composer
echo "### Iniciando serviços de $PROJECT_NAME...  ^_^"
docker-compose up -d
echo "### OK.  =D"

# Configurando projeto
echo "Configurando projeto...  ^_^"
docker exec "${PROJECT_NAME}_web" chmod -R 777 storage
docker exec "${PROJECT_NAME}_web" composer install
docker exec "${PROJECT_NAME}_web" apt-get update -y
docker exec "${PROJECT_NAME}_web" apt-get install nodejs -y
docker exec "${PROJECT_NAME}_web" apt-get install npm -y
docker exec "${PROJECT_NAME}_web" npm install -y
docker exec "${PROJECT_NAME}_web" npm run dev -y
echo ""
echo "Acho que tá tudo ok meu chapa! teste ai no http://localhost"