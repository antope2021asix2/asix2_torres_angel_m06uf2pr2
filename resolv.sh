#!/bin/bash
# ANGEL TORRES PÉREZ
#

if (( $EUID != 0 )) # Ejecutar como root
then
 echo "Has d'executar el script com root"
 exit 1 
fi

echo "---------------------------------------------------------------------"
echo "Aquest programa realitza copies de seguretat del fitxer resolv.conf"
echo "---------------------------------------------------------------------"

if (( $# == 1 )) # Detecta parametre
then
	if [[ ! -d /root/$1 ]]
	then
		echo "Vols crear el directori /root/$1? (s/n): "
		read opc
		if [[ $opc == "s" ]]
		then
			mkdir /root/$1
		else
			echo "D'acord, no crearé cap directori, Adeu!"
			exit 1
		fi
	fi
else
	echo "Error: Necesitas pasar un parametre, és a dir, executar sudo ./resolv.sh [parametre]"
	exit 2
fi

nomfitxer=resolv.conf.backup.$(date +20%y%m%d%H%M)
cp /etc/resolv.conf /root/$1/$nomfitxer
gzip /root/$1/$nomfitxer

echo "Gzip creat correctament!!"

exit 0
