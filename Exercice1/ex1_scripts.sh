#!/bin/bash

# exo 1 scripts
# Écrire un script qui compte les entités *pour une année* 
# un type d’entité donnés en argument du programme
# puis le lancer 3 fois (une fois par année)

ENTITE=$1 # on donne en argument txt ou ann

echo "On va compter les fichiers $ENTITE"
cd ${ENTITE}/ # on va dans le dossier correspondant au type d'entité

for ANNEE in 2016 2017 2018; do
    # compte les entites pour cette année
    echo "Nombre de fichiers .${ENTITE} en $ANNEE: "
    # ls -l $ANNEE/*
    # ls -l $ANNEE/* | grep ".${ENTITE}"
    ls -l $ANNEE/* | grep ".${ENTITE}" | wc -l  # affiche dans console
done

cd .. # retour 