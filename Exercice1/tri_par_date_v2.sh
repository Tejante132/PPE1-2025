#!/bin/bash

# ANNEE=$1 # argument donné en executant
for ANNEE in 2016 2017 2018; do
    
    # premier gros tri par année
    mkdir $ANNEE
    mv ${ANNEE}* ${ANNEE}/

    # sous tri par mois
    cd $ANNEE
    for month in {01..12}; do
        mkdir $month
        # mv ${dossier}_${month}* $month/
        mv ${ANNEE}_${month}* $month/
    done
    cd ..
done