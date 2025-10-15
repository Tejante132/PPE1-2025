# Journal de bord du projet encadré

Pour le cours de [[Projet de programmation encadré]].

> [!Attentes]
> - Journal de bord individuel.
> - Notes un peu au jour le jour (hebdo ?).
> - Je peux aussi y noter si je découvre des fonctions ou manips sympas, des tests.
> - Notes les arguments pratiques pour les fonctions qu'on apprend à utiliser.
> - Quelles manoeuvres j'ai fait, qu'est-ce qui s'est bien passé, qu'est-ce qui s'est mal passé ?

> Le journal de bord vous servira tout au long de cette unité d’enseignement, vous devrez y écrire régulièrement pour faire part de votre avancement. Vous devrez y indiquer notamment **les problèmes que vous avez rencontrés et les solutions que vous avez trouvées**. 

[[git-intro-exercices.pdf#page=3&selection=85,0,93,12|git-intro-exercices, page 3]]

# Mes idées de réalisation / questions 
- markdown ? rédigé sous Obsidian? --> vu que je prends déjà mes notes sous markdown dans Obsidian...
- [x] voir si c'est possible de partager juste une note de mon repo obsidian (la note active)  [completion:: 2025-10-06]
	- je vais plutôt créer un nouveau répo git dans lequel je mets uniquement les notes de PPE (cours et exos) en guise de journal de bord
- [ ] ~~sinon juste je copie colle la note (déjà en markdown) si on est censé envoyer ~~


## Wed 24.09.2025 - cours d'intro

Je connais déjà la plupart de ce qu'on apprend (cours avec intro au bash suivi et utilisation pendant mon mémoire l'année dernière + dans ma vie de tous les jours)., Mais comme j'ai tout fait en allemand ou anglais jusqu'ici je suis **contente de l'entendre bien expliqué en français (ma langue maternelle).** :)
Aussi très contente parce que j'ai découvert le bash expliqué par des allemands ingénieur en génie mécanique, et je trouvais ça vachement moins clair et sympa que quand c'est *expliqué par des intéressés de linguistique* (l'étant moi-même) parce qu'on a plus une approche linguistique (par ex description du bash comme "*langue à verbe initial*").

*Intérêt particulier pour le petit point culture / histoire :)*

Des fois je m'emmêle un poil entre les chemins absolus / relatifs, en particulier je n'étais pas trop sûre de la notion de répertoire actuel qu'on peut désigner par `./`.
Aussi intéressant le point sur la vision de tout comme fichier, et d'une arborescence unique (Linux -/- Windows sur ce point).

Je pense pas beaucoup faire de recherches/tests pour le moment en dehors du cours car je connaissais tout ce qu'on a vu.

En fait moi je prends mes notes dans mon repo Obsidian, il faudrait que je montre aux profs et que je demande comment je peux faire converger mon orga perso et leurs attentes.


---

⚫️⚫️⚫️
Pour la suite j'ai juste pris mes notes de cours dans Obsidian.

[[Cours 1 PPE Unix]]
[[Cours 2 PPE git]]

---

## Exercice 1 : créer une arborescence pour classer les documents
Ici : [[unix.pdf#page=23&selection=0,0,0,8|unix, page 23]]

On a téléchargé une archive .zip qu'on a unzip avec `unzip`.

Après avoir trié les images dans `img/`, les documents dans `docs/`, les annotations dans `ann`, et les textes dans `txt`, je recrée des sous-dossiers en triant par nom : 
- Pour les textes et annotations, je lis la date indiquée pour mettre dans le dossier correspondant.
- Pour les images, je cherche les expressions dans le nom des fichiers qui me donnent une indication sur le lien (Paris ou Tokyo) avec [[grep]].
```sh
ls | grep Tokyo
```
Qui renvoie : 
```sh
0-Paris,Tokyo2.JPG
0-Tokyo!_film_poster.jpg
100-Tokyo_Reverie.jpg
101-Tokyo_Road_best_of_Bon_Jovi.jpg
102-Tokyo_Sando_logo.png
103-Tokyo_Seikatsusha_Network.png
104-Tokyo_Sports.jpg
105-Tokyo_Sungoliath_logo.jpg
106-Tokyo_Super_Wars_official_poster.jpg
...
```

Et toutes ces lignes, on va les bouger dans le sous-dossier `Tokyo/`.
Mais en fait là tout de suite je suis pas encore assez au point sur les [[pipe]] pour les commandes à plusieurs arguments pour faire ça avec `grep` (il faudrait que j'utilise la sortie de grep comme premier argument de `mv` et que je puisse ensuite indiquer le sous-dossier `Toyko/`).
Donc pour le moment on va tout faire avec des [[caractères de remplacement]] ! :p

```sh
ls *Tokyo*
```

*Note :* les deux commandes nous donnent bien les mêmes résultats ici (j'ai vérifié avec le nombre de résultats `ls | grep Tokyo | wc -l` vs `ls *Tokyo* | wc -l`).

Donc, après avoir créé le sous-dossier  `Tokyo/`, j'ai lancé :
```sh
mv *Tokyo* Tokyo/
```
- [ ] Bon, petit souci annoncé qui est donc qu'en théorie j'essaie aussi de déplacer l dossier `Tokyo/` dans lui-même (action qui échoue heureusement). Ce serait peut-être bien que je trouve une *option sur mv* pour mettre une exception (p.ex : pas les dossiers, ou pas un certain fichier).

Après globalement j'ai finalement décidé de faire un petit script qui permet de re-ranger les fichiers dans les dossiers adaptés, avec des [[boucles en bash]].

Wed 15.10.2025
Finalement j'ai refait le tri avec ce petit script. 

```sh
#!/bin/bash
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
```

Il faut vraiment faire bien attention aux utilisations de variables dans un nom "composé" de chemin. Par exemple, quand je faisais `mv $ANNEE_${month}* $month/` ça ne marchait pas : il faut bien mettre les accolades autour de `${ANNEE}`.


---

## Mon 06.10.2025 : Exercice git, manipulation de fichiers, tag

[[git-intro-exercices.pdf]]
Mon 06.10.2025

Création d'un repo git dans lequel on mettra le [[journal]]. 
Concrètement moi je vais déplacer mes notes faites dans Obsidian dans un repo public pour les profs. Ou peut-être juste les notes d'exercices/projet ..?

Lien vers mon repo : https://github.com/Tejante132/PPE1-2025.git 

On en copie l'adresse [[SSH]] pour faire le lien entre un dossier local et le dépôt (repo) GitHub, y publier des modifications de dépôt via le protocole SSH.
```sh
git clone git@github.com:Tejante132/PPE1-2025.git
```

*Note* : GitHub ne supporte plus de publier les modifications de dépôt via protocole HTTPS pour des raisons de sécurité. Enfin c'est possible mais il faut se connecter à chaque fois, alors qu'*en utilisant l'adresse SSH pour cloner le repo, on s'identifie avec notre [[clé ssh]].*

Lorsqu'on clone un dépôt, **un dossier au nom de ce dépôt est automatiquement créé** dans le dossier courant (où on a effectué la commande `git clone`).

---

On teste l'utilisation du clonage : j'ai créé et "commit" un fichier markdown appelé `journal.md` depuis le site internet de GitHub, et maintenant on va voir ce qu'affiche la commande [[git status]] (normalement elle affiche qu'il nous manque un fichier).

```sh
clotilde@clotilde-Aspire:~/Documents/Obsidian Vault/Obsidian-Plurital/S7/PPE1-2025$ git status
On branch main
Your branch is up to date with 'origin/main'.

nothing to commit, working tree clean
```

Alors a priori finalement pour le moment il ne me dit rien, mais c'est logique car je n'ai pas récupéré les informations des dernières modifications, donc ma version locale ne sait pas qu'il y a une nouvelle version de la banche main. A ses yeux, on est à jour...
 
 Je vais tester ce que changent les acctions : `git fetch` (métadonnées uniquement), et `git pull` (importe les modifications). 
 
```sh
clotilde@clotilde-Aspire:~/Documents/Obsidian Vault/Obsidian-Plurital/S7/PPE1-2025$ git fetch
remote: Enumerating objects: 4, done.
remote: Counting objects: 100% (4/4), done.
remote: Compressing objects: 100% (2/2), done.
remote: Total 3 (delta 0), reused 0 (delta 0), pack-reused 0 (from 0)
Unpacking objects: 100% (3/3), 997 bytes | 997.00 KiB/s, done.
From github.com:Tejante132/PPE1-2025
   49cd1db..d70ec29  main       -> origin/main
   
clotilde@clotilde-Aspire:~/Documents/Obsidian Vault/Obsidian-Plurital/S7/PPE1-2025$ git status
On branch main
Your branch is behind 'origin/main' by 1 commit, and can be fast-forwarded.
  (use "git pull" to update your local branch)

nothing to commit, working tree clean
```

Après avoir utilisé `git fetch`, l'utilisation de `git status` repère maintenant bien qu'on a du retard sur la dernière version de la branche main (sans avoir importé ces modification). D'où le message : "Your branch is behind 'origin/main' by 1 commit".

On récupère les dernières mises à jour (le fichier `journal.md`) en utilisant `git pull`.

...

Et là je viens de regarder le pdf et de voir que je devais peut-être faire autre chose, mais c'est pas grave.
On teste l'utilisation de `git log`:
```sh
clotilde@clotilde-Aspire:~/Documents/Obsidian Vault/Obsidian-Plurital/S7/PPE1-2025$ git log
commit d70ec29f334a68a369596c6f173a774ffd0cf6d5 (HEAD -> main, origin/main, origin/HEAD)
Author: Clotilde Guyard-Gilles <100777239+Tejante132@users.noreply.github.com>
Date:   Mon Oct 6 16:01:32 2025 +0200

    Create journal.md
    
    Ajout du journal de bord

commit 49cd1db551c50f1d3bdc5d3fb0cf36992516d6cf
Author: Clotilde Guyard-Gilles <100777239+Tejante132@users.noreply.github.com>
Date:   Mon Oct 6 15:47:08 2025 +0200

    Initial commit
```

Ça nous liste les commits qui ont été faits. Pour le moment on en a très peu, donc pas trop envahissant, mais s'il y en avait plein et qu'on voulait sortir du journal, on pourrait le quitter en touchant la touche "q" (*quit*).

On fait maintenant des modifs locales au fichier (ce que je fais actuellement ;))) )

Donc en utilisant `git status` on devrait maintenant voir qu'on est en avance par rapport au main:
```sh
On branch main
Your branch is up to date with 'origin/main'.

Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
	modified:   journal.md

no changes added to commit (use "git add" and/or "git commit -a")
```

En fait finalement ça nous dit juste qu'on n'est à jour sur le mail, mais qu'on a fait de nouvelles modifications sur `journal.md`. Par contre il nous dit que c'est pas nécessaire d'`add` les changements, mais c'est peut-être dû à l'application que j'utilise pour prendre mes notes, sur lesquels j'exécute automatiquement régulièrement des scripts pour pull, add et push les dernières modifications.

Du coup par curiosité je regarde ce que ça change si je fais `git add .` dans mon dépôt local puis re `git status`.
Quand je dis `git add .`, rien ne s'affiche --> **parce que je n'ai pas créé de nouveau fichier ? peut-être que `add` / `rm` c'est uniquement pour les nouveaux fichiers, et les `commit` sont pour les changements??**.

Maintenant, `git status` donne : 
```sh
On branch main
Your branch is up to date with 'origin/main'.

Changes to be committed:
  (use "git restore --staged <file>..." to unstage)
	modified:   journal.md
```

Donc on va pouvoir les `commit` !

On enlève de la synchro git un potentiel fichier qui nous embête `.DS_STORE` grâce à un fichier `.gitignore`. Je le crée depuis mon terminal avec `touch`. Dans le fichier, on note simplement `.DS_STORE`. Je le fais aussi depuis le terminal avec : 
```sh
echo ".DS_STORE" >> .gitignore
```

Note : il faut commit normalement avant d'appliquer un **tag** sur un commit.
```sh
clotilde@clotilde-Aspire:~/Documents/Obsidian Vault/Obsidian-Plurital/S7/PPE1-2025$ git commit -m "commit fin exo pour tester le tag"
[main ac78641] commit fin exo pour tester le tag
 2 files changed, 170 insertions(+)
 create mode 100644 .gitignore
```

Et pour finir on crée un tag et on le push (cf [[git tag]], notes de [[Cours 2 PPE git]]) : nom du tag "gitinto" et message "version finie intro git".

```sh
git tag -m "version finie intro git" gitinto
git push origin gitinto
```

Qui nous affiche : 
```sh
Enumerating objects: 7, done.
Counting objects: 100% (7/7), done.
Delta compression using up to 16 threads
Compressing objects: 100% (4/4), done.
Writing objects: 100% (5/5), 4.21 KiB | 4.21 MiB/s, done.
Total 5 (delta 0), reused 0 (delta 0), pack-reused 0
To github.com:Tejante132/PPE1-2025.git
 * [new tag]         gitinto -> gitinto
```

Maintenant on va regarder sur GitHub ce que ça a donné pour le lien.

**Question : si je veux rajouter des modifications au tag, est-ce que c'est possible ?? pour avoir des versions 1.x par exemple.** 

On va tester voir, mais je pense qu'un tag ne peux être qu'unique, donc par exemple ce serait à moi de nommer le tag différemment, par exemple avec un nouveau tag qui s'appelle "gitinto.1" (avec un versionnement mineur de la version gitinto).

Effectivement ce n'était pas possible de juste refaire un `git tag -m "bla" gitinto`:
```sh
fatal: tag 'gitinto' already exists
```

Donc à la place j'ai fait : 
```sh
git tag -m "test de modifications sur un tag deja push" gitinto.1
git push origin gitinto.1
```
En créant donc un nouveau tag.

La question que je me pose par contre maintenant c'est si je pouvais commit et push directement dans un tag déjà existant, sans réutiliser la commande `git tag`.

Ça semble avoir marché !
```sh
clotilde@clotilde-Aspire:~/Documents/Obsidian Vault/Obsidian-Plurital/S7/PPE1-2025$ git commit -m "encore un test pour modifier un tag"
[main c49d815] encore un test pour modifier un tag
 1 file changed, 16 insertions(+), 1 deletion(-)
clotilde@clotilde-Aspire:~/Documents/Obsidian Vault/Obsidian-Plurital/S7/PPE1-2025$ git push origin gitinto
Everything up-to-date
```

Spoiler non en fait c'est l'ancienne version qui est en ligne.

Mais partie fun : en fait il faut continuer à push normal dans le main à côté des tags, parce que là la version du main est à jour d'il y a 53 minutes alors que mon tag est à jour d'il y a 12min.

Note : je pense que le but c'était de l'appeler gitintro donc mon dernier sera gitintro ;)

---

## Wed 08.10.2025 - Exos scripts bash
cf [[bash|scripts bash]] (mes notes perso sous Obsidian)

On lit les nouvelles slides de [[unix.pdf#page=26&selection=2,0,2,2|unix, page 26]] sur les lignes de commandes -> scripts.
Introduction aux différents [[flux d'entrée-sorties standard]] et [[redirection vers et depuis des fichiers]].

Mes points de doute : 
- [x] pas 100% sûre là comme ça de comment on utilise `<` (par contre les `>` sont bien clairs)  [completion:: 2025-10-08]
	-> *exemple :* `wc < fic.txt` : on redirige le contenu du fichier `fic.txt` dans le stdin.
- [ ] pour la [[redirection vers et depuis des fichiers]] : vérifier si la redirection de la sortie d'erreur se fait avec `&<`, `<&` ou les deux ?
- [ ] `wc` : le nom laisse entendre que ça compte les mots, mais je crois qu'en réalité ça compte plutôt les lignes. Tester avec et sens option `-l`.

On va fair des manipulation sur les [[fichiers .ann]] utilisés à la séance précédente.
-> Avant ça je suis allée finir le tri parce que je ne l'avais pas fait, comme je savais déjà faire (déjà fait un peu de bash dans mes études d'ingé) et que je ne savais pas qu'on en aurait besoin.....

Wed 15.10.2025
### Ex 1 scripts -exos (cours unix.pdf) 
#### v1 à côté de la plaque
**But**
- Écrire un script qui compte les entités *pour une année* un type d’entité donnés en argument du programme
	- on va utiliser `grep` et `wc` avec un argument donné du style `txt` ou `ann`.
	- je crée aussi une variable avec le type d'entité
- Écrire un second script qui lance le script précédent trois fois, une fois pour chaque années, en prenant le type d’entité en argument.
	- pour ça, on fait une boucle for sur les trois années.
Dans la boucle, j'utilise : 
```sh
ls -l $ANNEE/* | grep ".${ENTITE}" | wc -l
```

**Mes points de difficulté :** 
- au début j'ai créé une variable avec une affectation mal rédigée, puisque j'ai mis des espaces autour du `=`... attention à bien coller comme ça : `ENTITE=$1`.
- somehow ça me compte rien, je ré-essaie... -> le souci était que j'avais fait `ls -l $ANNEE` puis grep etc, mais la seule chose qui était contenue dans chaque répertoire d'année était des sous-dossiers par mois. J'ai donc rajouter le `\*` pour regarder plus loin.

Résultats : 
```sh
$ ./ex1_scripts.sh ann
On va compter les fichiers ann
Nombre de fichiers .ann en 2016: 
571
Nombre de fichiers .ann en 2017: 
393
Nombre de fichiers .ann en 2018: 
227
```

```sh
$ ./ex1_scripts.sh txt
On va compter les fichiers txt
Nombre de fichiers .txt en 2016: 
571
Nombre de fichiers .txt en 2017: 
393
Nombre de fichiers .txt en 2018: 
227
```

---
#### v2 plus sur le bon chemin
En fait je viens d'apprendre que c'était pas du tout ça l'exercice ! oups ;)
Donc je refais, cette fois-ci avec l'objectif de compter à l'intérieur d'un document les [[entité nommée]]s :

**But**
- Écrire un script qui compte les entités *pour une année* un type d’[[entité nommée]] donnés en argument du programme *(ex : Location, Person, Date, Organization)*
	- on va utiliser sur des fichierrs ann données `grep` et `wc` avec un argument donné du style Date, Person, ...
	- je crée aussi une variable avec le type d'EN donné qui sera utilisé dans grep
- Écrire un second script qui lance le script précédent trois fois, une fois pour chaque années, en prenant le type d’entité en argument.
	- pour ça, on fait une boucle for sur les trois années.

j'ai fait comme ia : 
```sh
EN=$1 # entité nommée
echo "On va compter les ${EN}s"
cd ann # on va là où sont rangées les annotations
for ANNEE in 2016 2017 2018; do
    # compte les EN pour cette année dans chacun des fichiers
    echo "On compte les ${EN}s en $ANNEE :"
    cat $ANNEE/*/* | grep $EN | wc -l
done
cd ..
```

Que j'ai exécuté comme ça:
```sh
$ bash ../ex1_scripts.sh Location
On va compter les Locations
../ex1_scripts.sh: line 32: cd: ann: No such file or directory
On compte les Locations en 2016 :
3144
On compte les Locations en 2017 :
2466
On compte les Locations en 2018 :
3110
```
--> petit souci : j'ai écexuté le programme déjà dans le dossier ann donc c'était pas la peine de mettre un cd ann dans le programme (ou alors j'aurais dû écrire le *chemin absolu* pour que ça marche qu'importe d'où on exécute le programme)

> [!J'ai appris]
> - que ça marche de faire `cat *` dans un répertoire pour afficher toutes les lignes de toues les fichiers qu'on peut lire dans le répertoire actif (les unes après les autres). Pratique pour grep.
> - que par contre le rayon d'action de ce genre de commandes c'est uniquement le répertoire acutel (pas sous-dossiers), mais je peux choisir à quelle "profondeur" je veux aller en utilisant un nombre correspondant de `/*/`. Par exemple ici on a une structure `ann/année/mois/fichiers_correspondants.ann`, donc en étant dans `ann`, si je voulais afficher les fichiers ann, je devais afficher tous les mois avec une `*` (cf code).


---

### v3 : la fiche d'exos ??
Boooooooon en fait je viens encore de voir qu'il vallait mieux suivre les exos de la fiche d'exos plutôt que ceux du cours. cf [[01-scripts-exercices.pdf]].


