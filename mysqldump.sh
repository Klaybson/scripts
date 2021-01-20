#!/bin/bash
#                                                                       #
#Autor: klaybson M. Conceição Data: 17/01/2021                          #
#                                                                       #
#########################:wq
######## Backup MySLQ ##########################

################################PARAMETROS MySQL#########################
echo "Digite o nome do banco"
read dbnome
DB_NAME=$dbnome

echo "Digite o usuario "
read dbuser
DB_USER=$dbuser

echo "Digite a senha"
read -s dbsenha #O -s oculta os caracteres de senha!
DB_PASS=$dbsenha

echo "Deseja fazer login no SERVIDOR FTP (s/n)"
read logftp

if [ $logftp = "s" ] 
then
        ###parametros para login no servidor ftp
        echo "Servidor FTP Ex.: ftp://192.168.1.1:21"
        read ftpsrv
        echo "Usuario do servidor FTP"
        read ftpuser
        echo "Senha do servidor FTP"
        read -s ftpass
else
        echo "segue"
fi 

#Abaixo são os parametros do mysqldump  // esses paramentros são indicados?
# DB_PARAM='--add-drop-table --add-locks --extended-insert --single-transaction -quick'

##########################################################################


############################Diretorio de backup##########################
if [ -d /backup/mysql ] #A opção "-d" verifica a existencia do diretorio
then
        echo "Diretorio já existe"
else
        echo "Diretorio inexistente. Deseja criar? (s/n)"
        read dir
        test "$dir" = "s" && mkdir -p /backup/mysql && echo "Diretorio criado" #Diretorio destino do backup "-p" para os subdiretorio

fi
##########################################################################

##############################PARAMETROS DO SYSTEMA#######################
echo " -- Definição de parametro do sistema! --"
DATE=`date +%d-%m-%Y_%H-%M-%S`
MYSQLDUMP=$(which mysqldump)
BACKUP_DIR=/backup/mysql
BACKUP_NAME=mysql-$DATE.sql
BACKUP_TAR=mysql-$DATE.tar.bz2
       #*FTP*# 
FTP_HOST=$ftpsrv
FTP_NAME=$ftpuser
FTP_PASS=$ftpass
FTP_DIR=/backup/mysql
##########################################################################


##############################GERANDO O BACKUP############################
echo "Localmente ou via FTP (f/l)"
read res
if [ $res = "f" ]
then
        
        #Diretorio do servidor ftp
        $MYSQLDUMP -h $FTP_HOST -u $FTP_NAME -p $FTP_PASS -u $DB_USER -p$DB_PASS > $FTP_DIR

else

        echo "Gerando o Backup da base de dados $DB_NAME em $BACKUP_DIR/$BACKUP_NAME_"
        $MYSQLDUMP $DB_NAME $DB_PARAM -u $DB_USER -p$DB_PASS > $BACKUP_DIR/$BACKUP_NAME
fi
##########################################################################


############################COMPACTANDO O ARQUIVO ########################
echo "  -- Compactando arquivo..."
tar -cjf $BACKUP_DIR/$BACKUP_TAR -C $BACKUP_DIR $BACKUP_NAME
##########################################################################

