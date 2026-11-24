# push_swap

Bienvenue dans mon repository **push_swap** ! Ce projet consiste à trier une liste d'entiers en C à l'aide de deux piles et d'un jeu d'instructions très limité, en produisant le moins de mouvements possible. L'objectif est de travailler sur les listes chaînées, la complexité algorithmique et l'optimisation d'un algorithme de tri.

## Sommaire

- [À propos](#à-propos)
- [Fonctionnalités](#fonctionnalités)
- [Installation](#installation)
- [Utilisation](#utilisation)
- [Structure du projet](#structure-du-projet)
- [Contributions](#contributions)

## À propos

**push_swap** reçoit une liste d'entiers en arguments, les place dans une pile `a` et dispose d'une pile `b` vide. Le programme affiche sur la sortie standard la suite d'instructions qui permet de trier la pile `a` dans l'ordre croissant. Le défi consiste à trouver une suite d'instructions la plus courte possible.

Le projet s'appuie sur **libmy**, ma bibliothèque de fonctions utilitaires en C (`my_split`, `my_strjoin`, `my_atol`…), compilée sous forme d'archive statique (`libmy.a`).

## Fonctionnalités

### 1. Instructions disponibles

- `sa` / `sb` / `ss` – Échange les deux premiers éléments de `a`, de `b`, ou des deux.
- `pa` / `pb` – Prend le premier élément d'une pile et le place en haut de l'autre.
- `ra` / `rb` / `rr` – Décale tous les éléments d'une position vers le haut (le premier devient le dernier).
- `rra` / `rrb` / `rrr` – Décale tous les éléments d'une position vers le bas (le dernier devient le premier).

### 2. Vérification des arguments

- Les arguments peuvent être passés séparément (`3 2 1`) ou dans une seule chaîne (`"3 2 1"`).
- Refus des valeurs non numériques, des doublons et des nombres en dehors des limites d'un `int`.

### 3. Algorithme de tri

- 3 éléments : tri direct avec un minimum de mouvements (`sort_three`).
- Au-delà : algorithme basé sur le **coût des mouvements**.
  1. Les éléments sont poussés de `a` vers `b` en choisissant à chaque fois celui qui demande le moins d'instructions pour être placé au bon endroit dans `b`.
  2. Les rotations communes aux deux piles sont combinées (`rr`, `rrr`) pour économiser des coups.
  3. Une fois trois éléments restants dans `a`, ils sont triés, puis les éléments de `b` sont réinsérés à leur place dans `a`.
  4. Une dernière rotation amène le plus petit élément en haut de la pile.

> Le projet est encore en cours de développement : certains affichages de débogage sont toujours présents.

## Installation

```
git clone https://github.com/AxelPj/push_swap.git
cd push_swap
make
```

Cette commande compile d'abord `libmy.a`, puis génère l'exécutable `push_swap`.

Autres règles disponibles :

```
make clean    # supprime les fichiers objets
make fclean   # supprime les objets, la bibliothèque et l'exécutable
make re       # recompile tout
make debug    # recompile avec -fsanitize=address
```

## Utilisation

Lancez le programme avec la liste d'entiers à trier :

```
./push_swap 3 2 1 5 4
```

Les instructions s'affichent une par ligne :

```
pb
pb
sa
ra
...
```

Pour compter le nombre de mouvements :

```
ARG="$(seq 1 100 | sort -R | tr '\n' ' ')"
./push_swap $ARG | wc -l
```

Pour vérifier que le résultat est bien trié (sous Linux) :

```
./push_swap $ARG | ./checker_linux $ARG
```

## Structure du projet

- `include/header/pushswap.h` : en-tête contenant les structures (`t_list`, `t_data`) et les prototypes.
- `include/libmy/` : bibliothèque utilitaire `libmy` et son `Makefile`.
- `src/main/pushswap.c` : point d'entrée, choisit la stratégie de tri.
- `src/error/verif.c` : lecture et vérification des arguments.
- `src/mouv/` : implémentation des instructions (`swap.c`, `push.c`, `rotate.c`, `reverse_rotate.c`).
- `src/utils/algo.c` : calcul du coût des mouvements et recherche des positions d'insertion.
- `src/utils/mouv.c` : déplacements entre les piles et tri final.
- `src/utils/utils.c`, `src/utils/utils_lst.c` : initialisation et gestion des listes chaînées.
- `checker_linux` : programme de vérification des instructions.
- `push_swap_visualizer` : outil de visualisation du tri.
- `Makefile` : règles `all`, `clean`, `fclean`, `re`, `debug`.

## Contributions

Les contributions sont les bienvenues ! Pour proposer une modification :

1. Forker ce repository.
2. Créer une branche : `git checkout -b feature/nouvelle-fonctionnalite`
3. Committer : `git commit -m "Ajout d'une nouvelle fonctionnalité"`
4. Pousser : `git push origin feature/nouvelle-fonctionnalite`
5. Ouvrir une Pull Request.
