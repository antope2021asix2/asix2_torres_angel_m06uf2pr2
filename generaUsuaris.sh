#!/bin/bash
# ANGEL TORRES PÉREZ
#
clear
echo -n "Dona el nombre d'usuaris (1-100): "
read qt

if (( $qt < 100 )) && (( $qt > 1 ))
then
	echo "Es crearan un total de "$qt" usuaris"
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
rm nousUsuaris.ldif
touch nousUsuaris.ldif
NumUsr=$vinic

for (( i=0; i<$qt; i++ ))
do
	idUsr=usr$NumUsr
	echo "dn: uid=$idUsr,cn=UsuarisDomini,ou=UsuarisGrups,dc=fjeclot,dc=net" > nousUsuaris.ldif # CAMBIA CLOTFJE POR FJECLOT
	echo "objectClass: top" >> nousUsuaris.ldif
	echo "objectClass: person" >> nousUsuaris.ldif
	echo "objectClass: organizationalPerson" >> nousUsuaris.ldif
	echo "objectClass: inetOrgPerson" >> nousUsuaris.ldif
	echo "objectClass: posixAccount" >> nousUsuaris.ldif
	echo "objectClass: shadowAccount" >> nousUsuaris.ldif
	echo "cn: $idUsr" >> nousUsuaris.ldif
	echo "sn: $idUsr" >> nousUsuaris.ldif
	echo "uidNumber: $NumUsr" >> nousUsuaris.ldif
	echo "gidNumber: 100" >> nousUsuaris.ldif
	echo "homeDirectory: /home/$idUsr/" >> nousUsuaris.ldif
	echo "loginShell: /bin/bash" >> nousUsuaris.ldif
	echo "" >> nousUsuaris.ldif

	NumUsr=$(( $NumUsr + 1 ))
	ldapadd -h localhost -x -D "cn=admin,dc=fjeclot,dc=net" -w "$ctsadm" -f nousUsuaris.ldif # CAMBIA CLOTFJE POR FJECLOT
	if (( $? != 0 ))
	then
		echo "ERROR: No s'han creat els usuaris, potser contrasenya incorrecte o usuari repetit."
		exit 2
	else
		echo "L'usuari $idUsr s'afegit correctament!"
		echo "________________________________________"
	fi
done
exit 0



