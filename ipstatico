#!/bin/bash                                         
#Data:29/01/2021                                    #
#Autor: Klaybson M. Conceição                       #
#S.O: Ubuntu 18.04/20.04 e derivados 
#Script para configuração IP fixo 
#   
#####################################################


echo " Digite o nome da placa de rede. EX.:$(ip a | grep -e 2: -e 3: -e eth0 | cut -c4-9) ." #Extrai nome da placa de rede exemplos
read nomerede #Recebe o nome da pla de Rede

echo "Digite o IP (Ex.: 192.168.1.100/24)"
read ipstatico #Recebe o IP e a mascara desejada

echo "Digite o Gateway (Ex.: 192.168.1.1)"
read gtway ##Recebe a gateway da rede

echo "Digite o DNS 1 (Ex.: 8.8.8.8)"
read dns1 #Recebe o numero do ser. DNS

echo "Digite o DNS 2 (Ex.: 8.8.4.4)"
read dns2

clear

#############Informações a serem adicionadas#################
echo "Nome da placa de rede: $nomerede "
echo "IP: $ipstatico"
echo "Gateway: $gtway"
echo "DNS1: $dns1  DNS2: $dns2"
echo 
echo "Confira as iformações antes! Digite (s)"
read res
if [ $res = "s" ] 
then 
#Criação do arquivo e aplicação das configurações 
echo -e '# Let NetworkManager manage all devices on this system
network:\n
    version: 2\n
    renderer: NetworkManager\n 
    ethernets:\n
       '$nomerede':\n
          dhcp4: no\n
          addresses: ['$ipstatico']\n
          gateway4: '$gtway'\n
          nameservers:\n
             addresses: ['$dns1','$dns2' ]\n'>/etc/netplan/1-network-manager-all.yaml.troca 
    mv /etc/netplan/1-network-manager-all.yaml /etc/netplan/1-network-manager-all.yaml.old 
    mv /etc/netplan/1-network-manager-all.yaml.troca /etc/netplan/1-network-manager-all.yaml 
    echo "Precione ENTER para validar"
    netplan try && netplan apply  && systemctl restart system-networkd || systemctl restart network-manager
    sleep 10
    ip a
else
    
    echo "Com grandes poderes vêm grandes responsabilidades!!"

fi
