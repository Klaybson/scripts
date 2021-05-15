#!/bin/bash
#Autor: Klaybson Menezes Conceição
#SO: Ubuntu 20.04LTS
#Zabbix 5.0 v.0
##Esse script foi desenvolvido para execução como usuario root do sistema.

#Instalação do Apache
apt -y install apache2 &&\

#Instalação do MySQL (Comando para reconfiguração do mysql: mysql_secure_installation )
apt -y install mysql-server-8.0 && \

#Downlodad do Zabbix
wget https://repo.zabbix.com/zabbix/5.0/ubuntu/pool/main/z/zabbix-release/zabbix-release_5.0-1+focal_all.deb && \

#Instalação do pacote baixado 
dpkg -i zabbix-release_5.0-1+focal_all.deb && \

#Atualização
apt update -y && \

# Instalação do servidor Zabbix, front-end e o agente
apt install zabbix-server-mysql zabbix-frontend-php zabbix-apache-conf zabbix-agent && \

#Banco de dados inicial 
echo Atenção
echo
echo 'Digite o nome de usuario para o banco de dados do Zabbix'
read user_bd
echo 'Digite um nome para o banco de dados do Zabbix'
read nome_bd
echo 'Digite uma senha para o banco de dados do Zabbix ex:(Se8n@hA)'
read senha_bd

mysql -u root -e "create database $nome_bd character set utf8 collate utf8_bin;" && \
mysql -u root -e "create user $user_bd@localhost identified by $senha_bd;" && \
mysql -u root -e "grant all privileges on $nome_bd.* to $user_bd@localhost;" && \

#Importação do esquema inicial 
zcat /usr/share/doc/zabbix-server-mysql*/create.sql.gz | mysql -uzabbix -p zabbix && \

#Configure o banco de dados para o servidor Zabbix
sed -i "s/DBPassword=password/DBPassword=$senha_bd/g" /etc/zabbix/zabbix_server.conf && \

#Configure o PHP para o frontend Zabbix (Bahia porque o Brasil nasceu aqui!)
sed -i "s/#php_value date.timezone Europe/Riga/php_value date.timezone America/Bahia/g" /etc/zabbix/apache.conf && \


systemctl restart zabbix-server zabbix-agent apache2 && \
systemctl enable zabbix-server zabbix-agent apache2 && \

echo 'Conecte-se ao frontend Zabbix recém-instalado: http://server_IP_ou_name/zabbix'
