#!/bin/bash

apt-get update
apt-get install -y postgresql postgresql-contrib

sudo -u postgres createuser --superuser vagrant 2>/dev/null || true
sudo -u postgres createdb vagrant 2>/dev/null || true
sudo -u postgres psql -c "ALTER USER vagrant WITH PASSWORD '12345';"

# устанавливаем node.js самую стабильную и долгосрочную
apt-get install -y nodejs npm
npm install -g n
n lts
hash -r

# переходим в стандартную общую папку
cd /vagrant/js-fastify-blog

# очищаем старый кэш и прошлые следы сборки
rm -rf node_modules package-lock.json
npm cache clean --force

# Запускаем установку зависимостей
sudo -u vagrant make install npm_config_bin_links=false
echo "Provisioning successfully completed!"