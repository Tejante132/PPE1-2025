#!/bin/bash

# Vérification qu'on a donné un argument
if [ $# -ne 1 ] # teste si nb d'argument différent de 1
then
	echo "Donner un paramètre (chemin vers fichier d'URLs)"
	exit # fin de programme
fi

N=0 	# compteur d'URLs
URLS=$1

echo -e "N\tURL\tStatut HTTP\tEncodage\tNb mots"

while read -r line;
do
	N=$(expr $N + 1) # incrément

	# Nouvelles lignes pour exo 2

	# On va récupérer les métadonnées en exécutant curl (line est une URL)
	METADONNEES=$(curl -s -I ${line} | tr -d '\r')

	# code de statut
# 	CODE_HTTP=$(echo "${METADONNEES}" | head -n 1 | awk '{print $2}') # lit la 1ère ligne
	CODE_HTTP=$(echo "${METADONNEES}" | head -n 1 | grep -oP " \K\d{3}")

	# encodage : on fait une regex
	ENCODING=$(echo "${METADONNEES}" | grep -i "content-type" | grep -oP "charset=\K[^; ]+")

	NB_MOTS=$(lynx -dump -nolist ${line} | wc -w)

	# on affiche les données extraites espacées par des tabulations
	echo -e "${N}\t${line}\t${CODE_HTTP}\t${ENCODING}\t${NB_MOTS}"

done < ${URLS};
