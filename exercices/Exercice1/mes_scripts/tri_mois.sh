#!/bin/bash

ANNEE=$1 # argument donné en executant

# for month in 01 02 03 04 05 06 07 08 09 10 11 12; do
for month in {01..12}; do
    # mkdir $month
    echo $month
    # ls ${ANNEE}_${month}*
    mv ${ANNEE}_$month* $month/
done