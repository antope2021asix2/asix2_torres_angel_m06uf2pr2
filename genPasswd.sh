#!/bin/bash
# ANGEL TORRES PÉREZ

clear
echo -n "Dona el nombre d'usuaris a modificar(1-100): "
read qt

if (( $qt < 100 )) && (( $qt > 1 ))
then
	echo "Es modificaran les contrasenyes de "$qt" usuaris"
else
	echo "Error: El nombre d'ususaris ha de estar entre 1 i 100" 
	exit 1
fi
echo -n "Introdueix el primer valor UID dels usuaris: "
read vinic
if (( $vinic<5000 ))
then
	exit 10
fi

echo -n "Introdueix la contrasenya de admin de LDAP: "
read ctsadm
rm ctsUsuaris.txt
touch ctsUsuaris.txt
NumUsr=$vinic

for (( i=0; i<$qt; i++ ))
do
	idUsr=usr$NumUsr #quizas cambiar a string
	ctsnya=$(pwgen 10 1)
	echo "$idUsr $ctsnya" >> ctsUsuaris.txt
	
	echo "dn: uid=$idUsr,cn=UsuarisDomini,ou=UsuarisGrups,dc=fjeclot,dc=net" >> ctsUsuaris.txt # CAMBIA CLOTFJE POR FJECLOT
	echo "objectClass: top" >> ctsUsuaris.txt
	echo "objectClass: person" >> ctsUsuaris.txt
	echo "objectClass: organizationalPerson" >> ctsUsuaris.txt
	echo "objectClass: inetOrgPerson" >> ctsUsuaris.txt
	echo "objectClass: posixAccount" >> ctsUsuaris.txt
	echo "objectClass: shadowAccount" >> ctsUsuaris.txt

	ldappasswd -h localhost -x -D "cn=admin,dc=fjeclot,dc=net" -W -S "uid=$idUsr,cn=admin,ou=UsuarisGrups,dc=fjeclot,dc=net"
	NumUsr=$(( $NumUsr + 1 ))
	if (( $? != 0 ))
	then
		echo "ERROR: No s'ha modificat la contrasenya dels usuaris, potser contrasenya incorrecte."
		exit 2
	else
		echo "La contrasenya de l'usuari $idUsr ha sigut modificada correctament!"
		echo "________________________________________"
	fi

done
exit 0
