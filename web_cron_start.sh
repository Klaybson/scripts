#!/bin/bash
#Autor: Klaybson M. Conceição
#Script para reinicialização do serviço WEB via Cron

#Varieavel recebendo o valor do comando curl. 
webs=$(curl -w %{http_code} -s -o /dev/null localhost)

#Estrutura de dec
if [ $webs -ne 200 ]; then
        systemctl restart apache2 || systemctl restart httpd
fi
