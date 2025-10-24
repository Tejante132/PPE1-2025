#!/bin/bash

# exo 1 scripts
# Écrire un script qui compte les entités *pour une année* 
# un type d’entité donnés en argument du programme
# puis le lancer 3 fois (une fois par année)

# V1 éclatée au sol

# ENTITE=$1 # on donne en argument txt ou ann

# echo "On va compter les fichiers $ENTITE"
# cd ${ENTITE}/ # on va dans le dossier correspondant au type d'entité

# for ANNEE in 2016 2017 2018; do
#     # compte les entites pour cette année
#     echo "Nombre de fichiers .${ENTITE} en $ANNEE: "
#     # ls -l $ANNEE/*
#     # ls -l $ANNEE/* | grep ".${ENTITE}"
#     ls -l $ANNEE/* | grep ".${ENTITE}" | wc -l  # affiche dans console
# done

# cd .. # retour $


# V2

EN=$1 # entité nommée

if [ -z  $EN] # aucun argument n'a été donné
then
    echo "donnez un type d'entité nommée (ex : Location, Person, Organization) en argument svp"
    exit
else
    echo "On va compter les ${EN}s"
fi

cd ann # on va là où sont rangées les annotations

for ANNEE in 2016 2017 2018; do
    # compte les EN pour cette année dans chacun des fichiers
    echo "On compte les ${EN}s en $ANNEE :"
    cat $ANNEE/*/* | grep $EN | wc -l

    # for FICHIER in */*; do
    #     compte=$(cat $FICHIER | grep $EN | wc -l)
    #     echo "On compte $compte"
    # done
done

cd ..