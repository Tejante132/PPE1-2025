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
Booon en fait je viens encore de voir qu'il vallait mieux suivre les exos de la fiche d'exos plutôt que ceux du cours. cf [[01-scripts-exercices.pdf]].


### Ex 2 scripts -exos (cours unix.pdf) 
- créer un script pour établir le classement des lieux les plus cités. 
- prendre en argument l’année, le mois et le nombre de lieux à afficher 
- accepter * pour l’année et le mois.

Outils à utiliser : 
- tail ??
- ...


J'avoue m'énerve un peu parce que j'avais fait les exos donnés dans les slides de cours et ils sont légèrement différents de ceux dans la fiche de TD mais sont quand-même proches. :(
Je verrai si j'ai la foi de refaire exactement le TD pendant les vacances, pour le moment je me concentre sur suivre en direct ce qu'on fait maintenant pour pas prendre de retard.


---

## Wed 15.10.2025 - Instructions de contrôle

Petite update du sccript fait pour le tri pour tester le fait de vérifier les arguments. J'ai rajouté au début (avant d'exécuter le reste du code) : 
```sh
EN=$1 # entité nommée

if [ -z  $EN] # aucun argument n'a été donné
then
    echo "donnez un type d'entité nommée (ex : Location, Person, Organization) en argument svp"
    exit
else
    echo "On va compter les ${EN}s"
fi
```

Et testé d'essayer de lancer le script avec et sans EN donnée : 
```sh
sh-5.2$ bash ../ex1_scripts.sh 
donnez un type d'entité nommée (ex : Location, Person, Organization) en argument svp
sh-5.2$ bash ../ex1_scripts.sh Location
../ex1_scripts.sh: line 30: [: missing `]'
On va compter les Locations
On compte les Locations en 2016 :
3144
On compte les Locations en 2017 :
2466
On compte les Locations en 2018 :
3110
```

Top!

### Description de ce qu'il se passe dans le code donné en fin du cours unix 

Annotation d'un code :
```sh
#!/usr/bin/bash    # shebang

if [ $# - ne 1 ]    # si le nombre total d'arguments n'est pas 1
then 
	echo " ce programme demande un argument "  # prévient (msg d'erreur)
	exit  # interrompt le programme
fi   # sortie de structure `if`


FICHIER_URLS=$1  # affectation de la valeur donnée en argument
OK=0  # création de deux variables OK et NOK de valeurs 0
NOK=0 

while read -r LINE ; # je suppose que a veut dire qu'on a de quoi lire  ??? mais c'est qui LINE ici ?
do 
	echo "la ligne : $LINE" 
	if [[ $LINE =∼ ^https?:// ]]  # on teste avec regex si la ligne correspond à une adresse web / un site
	then 
		echo " ressemble à une URL valide " 
		OK = $(expr $OK + 1)  # itéré compte les adresses web valides
	else 
		echo " ne ressemble pas à une URL valide "
		NOK = $(expr $NOK + 1)  # itère le compteur d'URL pas OK
	fi 
done < $FICHIER_URLS # ah ben je crois que je sais : les LINES sont lues dans le fichier donné ici à la boucle while...do...done

echo " $OK URLs et $NOK lignes douteuses "
```


*Ce que fait ce code :* 
- Si le nombre total d'arguments n'est pas 1, prévient qu'il faut un argument et quitte le programme.
- *... (voir commentaires dans le code)*
- $FICHIER_URLS donne le chemin vers le fichier texte (==au while read== )
	- il y a un chevron dans `done < $FICHIER_URLS` 
	- ici le contenu du fichier est "branché" sur l'entrée standard du done... -> il répond en fait à tout le bloc `while ... do ... done` 
- `read` -> cf page d'aide pour savoir comment ça marche.. ([[read]])

### `read`
La commande `read` en Bash est utilisée pour *lire une ligne de texte depuis l'entrée standard (par défaut)* ou un descripteur de fichier, et **l'assigner à une ou plusieurs variables**.

Prend en **argument un nom de variable** et stocke sur l'entrée standard...
- retourne vrai tant que ça reçoit des choses,
- une fois que ça arrive au bout du fichier (plus rien dans l'entrée standard) : renvoie faux -> permet de sortir de la boucle 

`read` lit son entrée standard **ligne par ligne** et le **renvoie dans une variable** (ici `LINE`).

**Avec cat et [[pipe|pipeline]]s (`|`) :**
```sh
cat monfichier.txt | while read -r LINE; do echo $LINE;
```

**Avec [[redirection vers et depuis des fichiers|redirection I/O]] (`<`) :**
```sh
while read -r LINE;
do
	echo $LINE;
done < monfichier.txt
```

ou en une ligne :  
```sh
while read -r LINE ; do ... done < monfichier.txt
```



---

## Wed 22.10.2025 : Web, HTTP, Lynx...

### Lynx

On teste des options de Lynx. 
1. Récup contenu textuel d'une page pour l'afficher (sans navigation)

Flemme de voir toutes les options de `lynx --help` donc je tente de trier avec `grep`.

```sh
$ lynx --help | grep "text"
  -base             prepend a request URL comment and BASE tag to text/html
  -dont_wrap_pre    inhibit wrapping of text in <pre> when -dump'ing and
  -justify          do justification of text (off)
  -list_inline      with -dump, forces it to show links inline with text (off)
  -preparsed        show parsed text/html with -source and in source view
  -syslog=text      information for syslog call
                    trim input text/textarea fields in forms (off)
```
-> pas sûre de trouver là... 

2. Retirer la liste des liens d'une page à l'affichage.

```sh
$ lynx --help | grep "link"
  -hiddenlinks=[option]
                    hidden links: options are merge, listonly, or ignore
  -image_links      toggles inclusion of links for all images (off)
  -ismap            toggles inclusion of ISMAP links when client-side
  -link=NUMBER      starting count for lnk#.dat files produced by -crawl (0)
  -list_decoded     with -dump, forces it to decode URL-encoded links (on)
  -list_inline      with -dump, forces it to show links inline with text (off)
  -listonly         with -dump, forces it to show only the list of links (off)
  -nolist           disable the link list feature in dumps (off)
  -nonumbers        disable the link/form numbering feature in dumps (off)
  -number_fields    force numbering of links as well as form input fields (off)
  -number_links     force numbering of links (off)
  -prettysrc        do syntax highlighting and hyperlink handling in source
  -traversal        traverse all http links derived from startfile
  -underline_links  toggles use of underline/bold attribute for links (off)

```
--> idem pas trop sûre non-plus...

Les deux possibilités n'ayant pas trop aidé, on peut aussi tenter un `man lynx`.

1. On a trouvé ça : 
```
   -dump  dumps the formatted output of  the  default  document  or  those
		  specified  on  the  command  line  to  standard  output.  Unlike
		  interactive mode, all documents are processed.  This can be used
		  in the following way:

			  lynx -dump http://www.subir.com/lynx.html

		  Files specified on the command line are  formatted  as  HTML  if
		  their  names  end  with one of the standard web suffixes such as
		  “.htm” or “.html”.  Use the -force_html option to  format  files
		  whose names do not follow this convention.
```

Possible d'aller vérifier son rôle en utilisant la "recherche" de `man`.

```
                          SEARCHING

  /pattern          *  Search forward for (N-th) matching line.
  ?pattern          *  Search backward for (N-th) matching line.
  n                 *  Repeat previous search (for N-th occurrence).
  N                 *  Repeat previous search in reverse direction.
  ESC-n             *  Repeat previous search, spanning files.
  ESC-N             *  Repeat previous search, reverse dir. & spanning files.
  ESC-u                Undo (toggle) search highlighting.
  ESC-U                Clear search highlighting.
  &pattern          *  Display only matching lines.

```

-> le `&pattern` fait un peu comme grep à l'intérieur du man.
Le prof a dit qu'on pouvait faire "comme un ctrl+f" sur le web, mais pas trop sûre de comment le faire. utiliser `/pattern` ne me donne que la prochaine ocurrence...
- ah oui mais ça surligne quand-même toutes les occurrences donc ça permet de voir rapidement.

En utilisant l'option `-dump`, le site s'affiche avec le texte uniquement (les liens sont nuémrotés), puis à la fin une liste qui détaille le lien pour chaque numéro.

```sh
 lynx -dump plurital.org
```

Qui renvoie quelque chose du style : 
```
   [1][logo.jpg]
   [2]Accueil [3]Organisation du master [4]Candidatures et inscriptions
   [5]Rentrée [6]Liste pluriTAL [7]nexTAL - association d'étudiants
   [8]Archives [9]Annuaire
   Bienvenue sur le site du master pluriTAL

   Le master pluriTAL est cohabilité entre les trois partenaires suivants
   : Université Sorbonne Nouvelle, Université Paris Nanterre et INALCO.

   Vous trouverez ici toutes les informations liées à l'organisation du
   master.

   Vous êtes admis en master ? Rendez-vous dans la section [10]Rentrée
   pour préparer votre arrivée !

   Pour toute information qui ne serait pas donnée sur le site, merci de
   contacter les [11]responsables pédagogiques ou l'[12]association
   nexTAL.

Prochains événements

Rentrée 2025

   Mise-à-jour 8 septembre : une présentation de l'install party est
   disponible sur la page de rentrée [13][ICI], le lien direct vers la
   présentation est [14][ICI].

   Pré-rentrée les 10 et 11 septembre 2025 !

   Au programme : réunions d'accueil M1 et M2 👨‍🏫, install party 👩‍💻,
   intégration M1 🕵️ et pot de rentrée nexTAL pour les M1 et M2 🎉

   Plus d'informations [15]ICI.

   N'hésitez pas à écrire à [16]nextal.contact@gmail.com en cas de
   question !

               [logo-p3.png] [logo-inalco.png] [logo-p10.png]

   [17]https://pluriTAL.org | pluriTAL ©2023, INALCO, Paris Nanterre,
   Sorbonne Nouvelle | Site géré par [18]nexTAL

References

   1. https://plurital.org/
   2. http://plurital.org/index.html
   3. http://plurital.org/organisation.html
   4. http://plurital.org/admin.html
   5. http://plurital.org/rentree.html
   6. http://plurital.org/groupepluriTAL.html
   7. http://plurital.org/nextal.html
   8. http://plurital.org/archives.html
   9. http://plurital.org/contact.html
  10. http://plurital.org/rentree.html
  11. http://plurital.org/contact.html#responsables
  12. http://plurital.org/nextal.html
  13. http://plurital.org/rentree.html#install-party
  14. http://plurital.org/install-party.pdf
  15. http://plurital.org/rentree.html
  16. mailto:nextal.contact@gmail.com
  17. https://plurital.org/
  18. mailto:nextal.contact@gmail.com

```

2. Enlever les liens

À partir de la version "dumpée" du site web, on peut filtrer avec `-nolist` pour enlever la liste de liens à la fin.

```sh
lynx -dump -nolist plurital.org
```

Qui renvoit donc : 
```
   [logo.jpg]
   
   Accueil Organisation du master Candidatures et inscriptions Rentrée
   Liste pluriTAL nexTAL - association d'étudiants Archives Annuaire
   Bienvenue sur le site du master pluriTAL

   Le master pluriTAL est cohabilité entre les trois partenaires suivants
   : Université Sorbonne Nouvelle, Université Paris Nanterre et INALCO.

   Vous trouverez ici toutes les informations liées à l'organisation du
   master.

   Vous êtes admis en master ? Rendez-vous dans la section Rentrée pour
   préparer votre arrivée !

   Pour toute information qui ne serait pas donnée sur le site, merci de
   contacter les responsables pédagogiques ou l'association nexTAL.

Prochains événements

Rentrée 2025

   Mise-à-jour 8 septembre : une présentation de l'install party est
   disponible sur la page de rentrée [ICI], le lien direct vers la
   présentation est [ICI].

   Pré-rentrée les 10 et 11 septembre 2025 !

   Au programme : réunions d'accueil M1 et M2 👨‍🏫, install party 👩‍💻,
   intégration M1 🕵️ et pot de rentrée nexTAL pour les M1 et M2 🎉

   Plus d'informations ICI.

   N'hésitez pas à écrire à nextal.contact@gmail.com en cas de question !

               [logo-p3.png] [logo-inalco.png] [logo-p10.png]

   https://pluriTAL.org | pluriTAL ©2023, INALCO, Paris Nanterre, Sorbonne
   Nouvelle | Site géré par nexTAL

```

Et si cette commande `-nolist` n'existait pas, on pourrait regarder de plus près à quoi ressemble le dump. 
-> En identifiant **à quoi ressemblent les lien**, on peut utiliser des **expressions régulières** ([[expression régulière|Regex]]) pour enlever les liens (https:// ... et adresse-mails).

On peut repérer que dans notre dump, **les liens ressemblent à des lignes avec un numéro**, un point, et le lien.
```sh
lynx -dump plurital.org | grep -P '\d+\. (http|mailto)'
```

Description de la partie `grep` : 
- option `-P` (pour Pearl ?) permet d'utiliser ici les expressions régulières.
- `'\d+\. http'`
	- `\d+` (plusieurs chiffres, *digits*)
	- suivi d'un point et espace `\. `
	- `(http|mailto)` puis soit d'un http (url) soit d'un mailto (adresse-mail)

---

### Curl

Là ou `lynx` récupère le *contenu* d'une page web, les commandes `wget` et `curl` sont là pour récupérer des *pages web complètes avec métadonnées*.

`curl` permet de récupérer des [[métadonnées]] sur la page web, sur les requêtes qu'on envoie. 
- permet de savoir si la page web est **valide**...
- concrètement ça se présente comme le code html de la page

```sh
curl <URL>
```

Avec `<URL>` une URL vers une page sur le web.

Un exemple intéressant : 
```sh
$ curl google.com
<HTML><HEAD><meta http-equiv="content-type" content="text/html;charset=utf-8">
<TITLE>301 Moved</TITLE></HEAD><BODY>
<H1>301 Moved</H1>
The document has moved
<A HREF="http://www.google.com/">here</A>.
</BODY></HTML>
```
-> Ici on voit qu'en réalité quand on tape juste `google.com` ça nous renvoie vers une page google écrite "mieux".

*Note sur le worldwideweb (www)* : de base on voulait différencier les sites sur le worldwideweb (accessibles à tous) de ceux qui peuvent être locaux (genre localhost et tout).


**Options :** 

| Option | Rôle                                    | ex                                                               |
| ------ | --------------------------------------- | ---------------------------------------------------------------- |
| `-L`   | pour suivre un déplacement/ redirection | par exemple sur `google.com`, ça va sur `http://www.google.com/` |
| `-i`   | avoir les options d'en-tête / headers   | Location : ...<br>Content-Type : ... (précise le char-set)       |

Les options sont *combinables*.

On peut aussi voir les métadonnées de la requête.

---

Sinon j'ai pu installer un LSP (Language Server Protocol) avec nodejs et npm pour avoir des informations sur les fonctions que j'utilise dans Kate et ça c'est vraiment hyper pratique !!!


### Mini-projet

#### **Exercice 1**
1. Pourquoi éviter `cat` ?
   Honnêtement vous avez mentionné ça en cours mais j'ai pas bien compris, seulement entendu je crois que ça avait un rapport avec les retours à la ligne ?

Mais quand j'ai essayé de faire des mini-tests en local pour voir la différence, je ne l'ai pas trop vue.
J'ai fait : 
```bash
cat monfichier.txt | while read -r LINE; do echo "nouvelle ligne ${LINE}"; done
```
et 
```bash
while read -r LINE; do  echo "nouvelle ligne ${LINE}"; done < monfichier.txt
```

Et les deux m'ont donné le même résultat : 
```
nouvelle ligne j'écris des lignes.
nouvelle ligne Là c'est une deuxième ligne. Est-ce que tu me vois avec la première ?
nouvelle ligne Et moi je suis la troisième.
nouvelle ligne 
nouvelle ligne 
nouvelle ligne 
nouvelle ligne Moi je suis la 4ème ligne de texte, mais il y a ds sauts de ligne avant moi. Qu'est-ce que tu vois avec cat et avec echo en me lisant ?
```

Mais peut-être que vous ne parliez pas de mettre cat puis pipeline au lieu d'utiliser une redirection, mais plutôt d'utiliser `cat` là où on a utilisé `echo` ?
Par curiosité j'ai testé ça : 
```bash
while read -r LINE; do  cat ${LINE}; done < exercices/monfichier.txt
```
Mais ça semble vraiment vraiment pas être quelque chose à faire, car là où `echo` prend en argument une chaine (comme `LINE` ici), `echo`  prend, lui, en argument un nom de fichier. 

Donc là en fait ça a essayé désespérément de lire le contenu de mon petit fichier test comme un chemin:
```
cat: "j'écris": No such file or directory
cat: des: No such file or directory
cat: lignes.: No such file or directory
cat: Là: No such file or directory
cat: "c'est": No such file or directory
cat: une: No such file or directory
cat: deuxième: No such file or directory
cat: ligne.: No such file or directory
cat: Est-ce: No such file or directory
cat: que: No such file or directory
cat: tu: No such file or directory
cat: me: No such file or directory
cat: vois: No such file or directory
cat: avec: No such file or directory
cat: la: No such file or directory
cat: première: No such file or directory
cat: '?': No such file or directory
cat: Et: No such file or directory
cat: moi: No such file or directory
cat: je: No such file or directory
cat: suis: No such file or directory
cat: la: No such file or directory
cat: troisième.: No such file or directory


Moi je suis la 4ème ligne de texte, mais il y a ds sauts de ligne avant moi. Qu'est-ce que tu vois avec cat et avec echo en me lisant ?
```

Conclusion : je ne sais pas.


2. Transformer `"urls/fr.txt"` en paramètre du script et valider sa présence.