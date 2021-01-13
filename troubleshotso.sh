#!/bin/bash
#               - scripts de informacoes do sistema -
#Autor: Klaybson M. Conceição
##############################################################

#Pedi confirmacao para executar o script.
echo "Deseja fazer um levantamento das informações do SO?[s/n]"
read RESPOSTA
test "$RESPOSTA" = "n" && exit
###############################################################


echo "============================== TROUBLESHOT =======================================
(a)Troubleshot Sistema operacional.
(b)Troubleshot Rede.
(s)Sair?."
read resposta # O Shell e case-sencitive 

	while [ "$resposta" != "s" ]
	do
		case  "$resposta"  in
		
		a | A | " " )
			echo "INFORMACOES SO"
            echo "SO.:'$(uname -isv)'"
            echo "Nome: '$(hostname)"
            echo "Memoria"#Comando para exibir uso de memoria 
            free -h
            echo 
            echo
            echo "Disco" #Comando para exibir espaço em disco 
            df -h
            echo
            echo
            echo "PROCESSADOR" #Comando para exibir uso processador 
            lscpu
            echo
            echo
            echo "USB" #Comando para exibi dispositivos conectados as portas USB
            lsusb
            echo
            echo
            echo "PCI"
            lspci #Comando para exibir dispositivos nas PCI
            echo
            echo "USUARIOS CONECTADOS"
            w
		;;
		b | B)
			echo "INFORMACOES REDE"
            echo
            echo "INTERFACES"
            echo 
            ip a 
            echo "ROTAS"
            echo
            ip route
            echo
            


		;;
		s | S)
			echo  " Saindo... "
		;;
		* )
			echo  " Opcao invalida!"
		;;
		esac
	echo "===========O que você deseja fazer?===============
	(a)Diretorio de Backup.
	(b)Backup da pagina Web.
	(s)Sair?."
	read resposta
done 

