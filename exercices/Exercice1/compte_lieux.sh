#!/bin/bash

# exo 2b scripts
# - créer un script pour établir le classement des lieux les plus cités.
# - prendre en argument l’année, le mois et le nombre de lieux à afficher
# - accepter * pour l’année et le mois.

# cette fois c'est forcément une "Location"

# echo "Nb d'arguments donnés : $#"

if [ $# -ne 3 ] # On n'a pas donné 3 arguments
then
    echo "Merci de donner 3 arguments svp : année (2016, 2017, 2018 ou toutes "*"), mois (tous : "*"), nombre de lieux à afficher (classement des lieux les plus cités)"
    exit
fi

ANNEE=$1
MOIS=$2
NB_LIEUX=$3
EN="Location" # entité nommée

echo "Classement des ${NB_LIEUX} ${EN}s les plus mentionnées en ${MOIS} ${ANNEE}."

# Prise en compte de l'astérisque
# cat ann/${ANNEE}/${MOIS}/* | grep "Location"
# cat ann/${ANNEE}/${MOIS}/* | grep "Location" | cut -d$'\t' -f3
cat ann/${ANNEE}/${MOIS}/* | grep "Location" | cut -d$'\t' -f3 | sort | uniq -c -i | sort -bgr | head -n ${NB_LIEUX}
