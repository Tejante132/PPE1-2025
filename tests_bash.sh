#!/usr/bin/bash
#
# # test de boucles et récursivité avec "brace expansion"
#
# echo "for i in {1..5}"
# for i in {1..5}; do
# 	echo $i
# done
#
# ###
#
# # avec "seq"
#
#
# echo "for i in \$(seq 1 2 10)"
#
# for i in $(seq 1 2 10); do
# 	echo $i
# done
#
#
# ###
#
# # avec boucle for de type C
#
# echo "for \((i=10; i>=1; i--))"
# for ((i=10; i>=1; i--)); do
# 	echo $i
# done
#
# ###
#
# echo "on teste avec un zéro devant"
# for i in $(seq 01 01 12); do
# 	echo $i
# done
# # plot twist le zéro ne reste pas


# ###

for dossier in */; do
# 	nom_dossier=$(ls | grep $dossier | head -1)
	nom_dossier=$dossier
done

echo "Nom du dossier"
echo "$nom_dossier"
