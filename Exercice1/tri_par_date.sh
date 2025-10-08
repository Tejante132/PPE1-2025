#!usr/bin/bash

# premier gros tri
mkdir 2016 2017 2018
mv 2016* 2016/
mv 2017* 2017/
mv 2018* 2018/

# sous tri
for dossier in */; do
	cd dossier
	months=(01 02 03 04 05 06 07 08 09 10 11 12)
	for month in $months; do
		mkdir $month
		mv $(month)* $(month)/
	done
done


