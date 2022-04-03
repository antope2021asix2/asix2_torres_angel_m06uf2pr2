#!/bin/bash
# ANGEL TORRES PÉREZ
#

if (( $EUID != 0 )) # Ejecutar como root
then
 echo "Has d'executar el script com root"
 exit 1 
fi

aptitude search pwgen
if (( $? == 0 )) #EN EL FUTURO CAMBIA ! POR =
then
	aptitude install pwgen
fi

echo -n "Dona el nombre d'usuaris (1-30): "
read num

if (( $num < 30 )) && (( $num > 1 ))
then
	echo "Es crearan un total de "$num" usuaris"
else
	echo "Error: El nombre d'ususaris ha de estar entre 1 i 30"
	exit 1
fi

echo -n "Dona'm un nom base per els usuaris (nombasex.clot): "
read nom

echo -n "Introdueix el primer valor UID dels usuaris: "
read uid

clot=.clot
echo "USUARIS CREATS AMB mltpusr.sh" > /root/$nom

for (( c=1; c<=$num; c++ )) # START=1 END=10 INCREMENT=1
do
	nomUsuari=$nom$c$clot
	#echo $uid
	contra=$(pwgen 10 1)
	echo "$nomUsuari	$contra" >> /root/$nom	
	
	useradd $nomUsuari -u $uid -g users -d /home/$nomUsuari -m -s /bin/bash -p $(mkpasswd $contra)
	if (( $? != 0 ))
	then
		exit 2
	fi
	uid=$(( $uid + 1 ))
	#echo $nomUsuari
	#echo $contra
	
done
echo "-------------------------------------------------------"
echo "Script finalitzat correctament, contingut de /root/$nom"
echo "-------------------------------------------------------"
cat /root/$nom
exit 0


