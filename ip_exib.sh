#!/bin/bash

#Variaveis

#Pega o numero do ip
IP_LOCAL=$(/sbin/ifconfig | sed -n '2 p' | awk '{print $2}')

#Pega o  nome da  placa de rede
NOME_PLACA=$(/sbin/ifconfig | sed -n '1 p' | awk '{print $1}'   )I

#Prints
clear

#Imprime o nome do sistema (nome,arquitetura,distribuição)
uname -isv
