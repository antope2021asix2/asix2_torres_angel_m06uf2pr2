#!/bin/bash
# ANGEL TORRES PÉREZ
#

echo "---------------------------------------------------------------------"
echo "Aquest programa realitza realitza les següents accions:
-Amb l'opció -e tots els arxiu que tingui la extensió indicada dins
 de la carpeta escollida seran moguts a una carpeta de nom paperera
 dins del directori personal de l'usuari. (( NO ESTA FET ))
 
-Amb l'opció -r el programa esborrarà tots els arxius de la paperera. 
(( SI QUE HO FA I SI HI HA ERRORS ELS INFORMA ))
"
echo "---------------------------------------------------------------------"

if (( $# == 1 )) # Detecta primer parametre
then
	if [[ $1 == -r ]] || [[ $1 == -e ]] # -r o -e
	then
		if [[ $1 == -r ]] #-r
		then
			if [[ ! -d ~/paperera ]]
			then
				echo "La paperera encara no existeix"
			else
				if [[ $(ls -A ~/paperera | wc -l) -ne 0 ]] # Detectar papelera vacia = 0
				then
					rm ~/paperera/*
					echo "S'ha eliminat el contingut de la paperera!"
				else
					echo "La paparera ja esta buida"
				fi
			fi
		else
			echo "Error: El parametre -e ha de tenir dos parametres més"
			exit 2
		fi
		
	else
		echo "Error: Introdueix -r o -e"
		exit 3
	fi
	
else
	if (( $# > 1 )) && [[ $1 == -r ]]
	then
		echo "Error: L'opció -r només funciona amb un parametre"
		exit 1
	fi
	
	if (( $# == 0 ))
	then
		echo "Error: Necesitas pasar almenys un parametre"
		exit 10
	fi

fi
