#!/bin/bash
# ANGEL TORRES PÉREZ
#

clear
echo -n "Dona el nombre d'usuaris a esborrar(1-100): "
read qt

if (( $qt < 100 )) && (( $qt > 1 ))
then
	echo "S'eliminaran un total de "$qt" usuaris"
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
rm esborraUsuaris.ldif
touch esborraUsuaris.ldif
NumUsr=$vinic

for (( i=0; i<$qt; i++ ))
do
	idUsr=usr$NumUsr
	echo "dn: uid=$idUsr,cn=UsuarisDomini,ou=UsuarisGrups,dc=fjeclot,dc=net" > esborraUsuaris.ldif # CAMBIA CLOTFJE POR FJECLOT
	echo "changetype: delete" >> esborraUsuaris.ldif
	echo "" >> esborraUsuaris.ldif
	NumUsr=$(( $NumUsr + 1 ))
	ldapmodify -h localhost -x -D "cn=admin,dc=fjeclot,dc=net" -w "$ctsadm" -f esborraUsuaris.ldif
	
	if (( $? != 0 ))
	then
		echo "ERROR: No s'han eliminat els usuaris, potser contrasenya incorrecte o usuari repetit."
		exit 2
	else
		echo "L'usuari $idUsr s'ha eliminat correctament!"
		echo "________________________________________"
	fi
done
exit 0
