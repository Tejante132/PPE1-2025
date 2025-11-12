#!/bin/bash

# Vérification qu'on a donné un argument
if [ $# -ne 1 ] # teste si nb d'argument différent de 1
then
	echo "Donner un paramètre (chemin vers fichier d'URLs)"
	exit 1 # fin de programme
fi

N=0 	# compteur d'URLs
URLS=$1

# on crée un fichier de sortie dans lequel on stockera les informations
fichier=tableaux/tableau-fr.html
touch ${fichier}

echo -e "
<html>
<head>
	<title>Tableau d'URLs</title>
	<meta charset="UTF-8" />
</head>" > ${fichier}

echo -e "
<body>
	<table>
		<tr><th>N</th><th>URL</th><th>Statut HTTP</th><th>Encodage</th><th>Nb mots</th></tr>" > ${fichier}

while read -r line;
do
	N=$(expr $N + 1) # incrément

	# Nouvelles lignes pour exo 2

	# On va récupérer les métadonnées en exécutant curl (line est une URL)
	METADONNEES=$(curl -s -I ${line} | tr -d '\r')

	# code de statut
# 	CODE_HTTP=$(echo "${METADONNEES}" | head -n 1 | awk '{print $2}') # lit la 1ère ligne
	CODE_HTTP=$(echo "${METADONNEES}" | head -n 1 | grep -oP " \K\d{3}")
	if [ -z "$CODE_HTTP" ]
	then
		CODE_HTTP="000"
	fi

	# encodage : on fait une regex
	ENCODING=$(echo "${METADONNEES}" | grep -i "content-type" | grep -oP "charset=\K[^; ]+")

	if [ -z "$ENCODING" ]
		# écrire truc à faire si pas d'encodate donné
	then
		ENCODING="N/A"
	fi

	NB_MOTS=$(lynx -dump -nolist ${line} | wc -w)

	# on affiche les données extraites espacées par des tabulations
	echo -e "
		<tr>
			<td>${N}</td>
			<td>${line}</td>
			<td>${CODE_HTTP}</td>
			<td>${ENCODING}</td>
			<td>${NB_MOTS}</td>
		</tr>" >> ${fichier}

done < ${URLS};

echo -e "
	</table>
</body>
</html>" >> ${fichier}
