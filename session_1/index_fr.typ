#import "@preview/touying:0.5.3": *
#import "@preview/fontawesome:0.3.0": *
#import "quarto_theme.typ": *

#show: clean-theme.with(
  aspect-ratio: "16-9",
  font-size: 16pt
)

#title-slide(
  title: [Résolution des modèles DSGE],
  subtitle: [ECO432 - Macroéconomie],
  authors: (
    (name: [Pablo Winant], affiliation: [], email: [], orcid: []),
  ),
  date: [2026/02/12],
)

==

#align(center)[
#image("assets/warning.png")
]

= Introduction
<introduction>
== 
<section>


Quelle est la principale spécificité de la modélisation économique ?

#pause

En (macro)économie, on #emph[modélise] le comportement des agents économiques en spécifiant :

- leur objectif $ max_(c_t) E_t sum_(s >= t) beta^s U (c_s) $ $ max pi_t $ $ dots $
- leurs contraintes (contrainte budgétaire, environnement économique…)

#pause

Cela a des implications importantes :

- les modèles macro sont #emph[tournés vers le futur]
  - ils reposent sur les anticipations
- les modèles macro doivent être #strong[résolus]

Dans de nombreux cas, il n’existe pas de forme fermée pour la solution -\> il faut des #emph[techniques numériques]

== Dynare
<dynare>

#columns(2,[
  
- 1996 : Michel Juillard crée un logiciel open source pour résoudre des modèles DSGE
  - DSGE : équilibre général dynamique stochastique
  - généralement résolus autour d’un état stationnaire
- Aujourd’hui environ 10 contributeurs.
  - $+$ des utilisateurs avancés ayant contribué au code

- Il a été largement adopté :
  - première version sous Gauss
  - puis Matlab/Octave/Scilab
  - version la plus récente en Julia
  - … et Python (voir #link("https://github.com/econforge/dyno.py")[dyno 🦖] et ses notations simplifiées)

#colbreak()

#figure([
#box(image("assets/michel.jpeg"))
], caption: figure.caption(
position: bottom, 
[
Michel Juillard
]), 
kind: "quarto-float-fig", 
supplement: "Figure", 
)
])

== Les modèles DSGE dans les institutions
<dsge-models-in-institutions>
Aujourd’hui, la plupart des modèles DSGE construits dans les institutions ont une version Dynare (IMF/GIMF, EC/Quest, ECB/, NYFed/FRBNY)

- ils reposent généralement sur le #emph[modèle de taille intermédiaire] de Smets & Wouters (10 équations)
- mais ils ont beaucoup grandi (\>\>100 équations)

#pause

Les institutions, portées par les chercheurs, diversifient leurs modèles

- Modèles semi-structurels
- Modèles d’équilibre général calculable
- Modèles de réseau
- Modèles Agent-Based
- Modèles à agents hétérogènes
- ...


= Résoudre un modèle
<solving-a-model>
== Modèle DSGE
<model>
Voici une représentation très concise d’un modèle DSGE:

$ bb(E)_t [f (y_(t + 1) \, y_t \, y_(t - 1) \, epsilon_t)] = 0 $

#block[
#block[
#block[
Le #strong[problème];:

- $y_t in bb(R)^n$: le vecteur des variables endogènes
- $epsilon_t in bb(R)^(n_e)$: le vecteur des variables exogènes
  - on suppose que $epsilon_t$ est un processus gaussien centré
- $f : bb(R)^n -> bb(R)^n$: les équations du modèle

]
]
#block[
#block[
La #strong[solution];:

- $g$ telle que $forall t \, y_t = g (y_(t - 1) \, epsilon_t)$

]
]
]

== Le timing des équations
<the-timing-of-the-equations>

#block[
#callout(
body: 
[
Dans un fichier Dynare, les équations du modèle sont codées dans le bloc `model; ... ; end;`.

La variable $v_t$ (resp. $v_(t - 1)$, $v_(t + 1)$) est notée `v` ou `v(0)` (resp. `v(-1)`, `v(+1)`).

Dans dyno, c’est `v[t],v[t-1],v[t+1]`.


]
, 
title: 
[
Astuce
]
, 
background_color: 
rgb("#ccf1e3")
, 
icon_color: 
rgb("#00A047")
, 
icon: 
fa-lightbulb()

)
]
#strong[Convention générale de timing]

La nouvelle information arrive avec les innovations $epsilon_t$.

À la date $t$, l’ensemble d’information est engendré par $cal(F)_t = cal(F) (dots \, epsilon_(t - 3) \, epsilon_(t - 2) \, epsilon_(t - 1) \, epsilon_t)$

Par convention #emph[une variable endogène porte l’indice $t$ si elle est connue pour la première fois à la date $t$];.

#pause

On distingue plusieurs #strong[types de variables] selon leur apparition dans le modèle :

- variable de saut : apparaît en $t$ ou $t + 1$
- variable prédéterminée : apparaît en $t - 1$ et $t$ (éventuellement $t + 1$)
- variable statique : apparaît uniquement en $t$
  - peut s’exprimer comme fonction des autres variables


== État stationnaire
<steady-state>
L’état stationnaire déterministe vérifie :

$ f (overline(y) \, overline(y) \, overline(y) \, 0) = 0 $

Souvent, il existe une solution analytique.

Sinon, il faut recourir à un solveur numérique pour résoudre

$ overline(y) -> f (overline(y) \, overline(y) \, overline(y) \, 0) $

#block[
#callout(
body: 
[
Dans Dynare, les valeurs d’état stationnaire sont fournies dans le bloc `steadystate_model; ... ; end;`. On peut vérifier qu’elles sont correctes avec l’instruction `check;`.

Pour trouver numériquement l’état stationnaire : `steady;`.

]
, 
title: 
[
Astuce
]
, 
background_color: 
rgb("#ccf1e3")
, 
icon_color: 
rgb("#00A047")
, 
icon: 
fa-lightbulb()

)
]
== Le système implicite
<the-implicit-system>
En remplaçant la solution $ y_t = g (y_(t - 1) \, epsilon_t) $ dans le système $ bb(E)_t [f (y_(t + 1) \, y_t \, y_(t - 1) \, epsilon_t)] = 0 $

on obtient :

$ bb(E)_t [f (g (g (y_(t - 1) \, epsilon_t) \, epsilon_(t + 1)) \, g (y_(t - 1) \, epsilon_t) \, y_(t - 1) \, epsilon_t)] = 0 $

Il s’agit d’une équation qui définit implicitement la fonction $g ()$

== L’espace d’état
<the-state-space>
$ bb(E)_t [f (g (g (y_(t - 1) \, epsilon_t) \, epsilon_(t + 1)) \, g (y_(t - 1) \, epsilon_t) \, y_(t - 1) \, epsilon_t)] = 0 $

Dans cette expression, $y_(t - 1) \, epsilon_t$ est l’espace d’état :

- il contient toute l’information disponible à $t$ pour prédire l’évolution future de $(y_s)_(s >= t)$

#pause

En supprimant les indices temporels, l’équation doit être vérifiée pour toute réalisation de $(y \, epsilon)$ $ forall (y \, epsilon) mid Phi (g) (y \, epsilon) = bb(E)_(epsilon') [f (g (g (y \, epsilon) \, epsilon ') \, g (y \, epsilon) \, y \, epsilon)] = 0 $

C’est une équation fonctionnelle $Phi (g) = 0$

== Chocs anticipés
<expected-shocks>
Approximation au premier ordre :

- Supposons $lr(|epsilon|) << 1$,$lr(|epsilon '|) << 1$

On effectue un développement de Taylor par rapport au choc futur :

#pause

On utilise le fait que $bb(E) [epsilon^(')] = 0$.

Au premier ordre, les chocs anticipés ne jouent aucun rôle.

Pour capturer les comportements de précaution (comme les primes de risque), il faut augmenter l’ordre d’approximation.

== Perturbation au premier ordre
<first-order-perturbation>
On obtient alors le système :

$ F (y \, epsilon) = f (g (g (y \, epsilon) \, 0) \, g (y \, epsilon) \, y \, epsilon) = 0 $

Une variante du #emph[théorème des fonctions implicites] permet alors d’obtenir une première approximation de $g$ :

$ g (y \, epsilon) = overline(y) + g_y^(') (y - overline(y)) + g_e^(') epsilon_t $

#pause

Les quantités inconnues $g_y^(')$ et $g_e^(')$ sont obtenues par la #emph[méthode des coefficients indéterminés];. On substitue la première approximation dans le système puis on écrit les conditions $ F_y^(') (overline(y) \, 0) = 0 $ $ F_epsilon^(') (overline(y) \, 0) = 0 $

== Calcul de $g_y^(')$
<computing-gprime_y>
Rappelons le système : $ F (y \, epsilon) = f (g (g (y \, epsilon) \, 0) \, g (y \, epsilon) \, y \, epsilon) = 0 $

On a $ F_y^(') (overline(y) \, 0) = f_(y_(t + 1))^(') g_y^(') g_y^(') + f_(y_t)^(') g_y^(') + f_(y_(t - 1))^(') = 0 $

#pause

$g_y^(')$ est la solution d’une équation de Riccati spécifique $ A X^2 + B X + C $ où $A \, B \, C$ et $X = g_y^(')$ sont des matrices carrées $in bb(R)^n times bb(R)^n$

== Modèle déterministe du premier ordre
<first-order-deterministic-model>
Prenons une minute pour observer le modèle déterministe du premier ordre : $ A X^2 + B X + C $

D’après notre intuition en dimension 1, on sait qu’il doit y avoir plusieurs solutions

- comment les trouver ?
- comment sélectionner les bonnes ?

En l’absence de chocs, la dynamique du modèle est donnée par $ y_t = X y_(t - 1) $

Quelle est la condition pour que le modèle soit stationnaire ?

#pause

\-\> la plus grande valeur propre de $X$ doit être inférieure à 1


== Multiplicité des solutions
<multiplicity-of-solution>
On peut montrer que le système est associé à $2 n$ valeurs propres généralisées :

$ lr(|lambda_1|) <= dots <= lr(|lambda_(2 n)|) $

Pour chaque choix $C$ de $n$ valeurs propres ($lr(|C|) = n$), on peut #emph[construire] une solution récursive spécifique $X_C$;. Elle a pour valeurs propres $C$.

#pause

Cela donne au moins $vec(2 n, n)$ combinaisons différentes.

#pause

Un modèle est bien défini lorsqu’il existe #strong[exactement une solution non divergente];.

Cela est équivalent à :

$ lr(|lambda_1|) <= dots <= lr(|lambda_n|) <= 1 < lr(|lambda_(n + 1)|) <= dots <= lr(|lambda_(2 n)|) $

== Exemple 1
<example-1>
Inflation anticipée :

$ pi_t = alpha pi_(t + 1) $ avec $alpha < 1$.

Est-il bien défini ?

#pause

On peut réécrire le système comme :

$ alpha pi_(t + 1) - pi_t + 0 pi_(t - 1) = 0 $

ou

$ pi_(t + 1) - (1 / alpha + 0) pi_t + (1 / alpha 0) pi_(t - 1) = 0 $

#pause

Les valeurs propres généralisées sont $0 <= 1 < 1 / alpha$.

#pause

La solution stable unique est $pi_t = 0 pi_(t - 1)$

== Exemple 2
<example-2>
Équation d’accumulation de dette d’un agent rationnel :

$ b_(t + 1) - (1 + 1 / beta) b_t + 1 / beta b_(t - 1) = 0 $

Est-il bien défini ?

#pause

Deux valeurs propres généralisées $lambda_1 = 1 < lambda_2 = 1 / beta$

#pause

La solution unique non divergente est $b_t = b_(t - 1)$.

- il s’agit d’une #emph[racine unitaire]; : toute déviation initiale de $b_(t - 1)$ a des effets persistants

== Exemple 3
<example-3>
Processus de productivité : $ z_t = rho z_(t - 1) $ avec $rho < 1$ : bien défini

#pause

Dans ce cas, il existe une valeur propre infinie cachée $oo$ associée à $z_(t + 1)$.

#pause

Pour comprendre, considérons le système associé aux valeurs propres $m$ et $rho$ : $ z_(t + 1) - (m + rho) z_t + m rho z_(t - 1) = 0 $

$ 1 / m z_(t + 1) - (1 + rho / m) z_t + rho z_(t - 1) = 0 $

Ce qui correspond au modèle initial lorsque $m = oo$

#pause

Les valeurs propres généralisées sont $lambda_1 = rho <= 1 < lambda_2 = oo$

Plus généralement, toute variable qui n’apparaît pas en $t + 1$ crée une valeur propre généralisée infinie.

== Un critère de bonne définition
<a-criterium-for-well-definedness>
En revenant à la liste des valeurs propres, on met de côté les valeurs infinies.

Le modèle est bien spécifié ssi on peut ordonner les valeurs propres comme suit :

$ lr(|lambda_1|) <= dots <= lr(|lambda_n|) <= 1 < lr(|lambda_(n + 1)|) <= dots lr(|lambda_(n + k)|) <= underbrace(lr(|lambda_(n + k + 1)|) dots <= lr(|lambda_(2 n)|), upright("valeurs propres infinies")) $

#block[
#callout(
body: 
[
Le modèle satisfait le critère de Blanchard-Kahn si le nombre de valeurs propres supérieures à un est exactement égal au nombre de variables #emph[apparaissant] en $t + 1$.

Dans ce cas, le modèle est bien défini.

]
, 
title: 
[
Critère de Blanchard-Kahn
]
, 
background_color: 
rgb("#dae6fb")
, 
icon_color: 
rgb("#0758E5")
, 
icon: 
fa-info()

)
]
== Calcul de la solution
<computing-the-solution>
Il existe plusieurs méthodes classiques pour calculer la solution de l’équation algébrique de Riccati : $ A X^2 + B X + C = 0 $

- décomposition QZ
  - traditionnellement utilisée dans la littérature DSGE depuis Chris Sims
  - un peu peu intuitive
- réduction cyclique
  - nouveau défaut dans Dynare, plus adaptée aux grands modèles
- itération de Bernoulli (voir section "Itération linéaire dans le temps")
  - conceptuellement très simple

== Calcul de $g_e^(')$
<computing-gprime_e>
Maintenant que nous avons $g_y^(')$, comment obtenir $g_e^(')$ ?

Rappel : $ F (y \, epsilon) = f (g (g (y \, epsilon) \, 0) \, g (y \, epsilon) \, y \, epsilon) = 0 $

On a $ F_e^(') (overline(y) \, 0) = f_(y_(t + 1))^(') g_y^(') g_e^(') + f_(y_t)^(') g_e^(') + f_(epsilon_t)^(') = 0 $

À présent, c’est simple :

$ g_e^(') = - (f_(y_(t + 1))^(') g_y^(') + f_(y_t)^('))^(- 1) f_(epsilon_t)^(') = 0 $

== La solution du modèle
<the-model-solution>
Le résultat de la résolution du modèle : $ y_t = g_y y_(t - 1) + g_e epsilon_t $

C’est un AR(1), piloté par le choc exogène $epsilon_t$.

#pause

Comme il s’agit d’une structure bien connue, on peut étudier le modèle avec

- des fonctions de réponse impulsionnelle
- des simulations stochastiques

#pause

Ensuite, pour comparer le modèle aux données, on calcule

- moments implicites :
  - covariances, autocorrélations
- vraisemblance

L’optimisation de l’ajustement aux données s’appelle l’#emph[estimation] du modèle

= Conclusion
<sec-conclusion>
== Que peut-on faire avec la solution
<what-can-you-do-with-the-solution>
La solution d’un modèle trouvée par Dynare a une forme particulièrement simple : un AR(1)

- $y_t = X y_(t - 1) + Y epsilon_t$
- où les covariances $Sigma$ de $epsilon_t$ peuvent être choisies par le modélisateur

#pause

Avec cette solution, on peut

- calculer des moments (conditionnels et inconditionnels)
- effectuer des simulations stochastiques et des fonctions de réponse impulsionnelle

#pause

== Aller plus loin
<going-further>
Confronter le modèle aux données avec Dynare

- « estimer » le modèle : calculer la vraisemblance d’une solution et la maximiser en choisissant les bons paramètres
- « identifier » les chocs dans les données

Autres fonctionnalités

- approximation d’ordre supérieur
- simulations en prévision parfaite (non linéaires)
- plan de Ramsey
- politique discrétionnaire
- …

= Annexe : Itération linéaire dans le temps
<sec:linear_time_iteration>
== Itération linéaire dans le temps
<linear-time-iteration>
Rappel du système à résoudre : $ F (y \, epsilon) = f (g (g (y \, epsilon) \, 0) \, g (y \, epsilon) \, y \, epsilon) = 0 $

mais supposons maintenant que les règles de décision d’aujourd’hui et de demain sont différentes :

- aujourd’hui : $y_t = g (y_(t - 1) \, epsilon_t) = overline(y) + X y_(t - 1) + g_y epsilon_t$
- demain : $y_(t + 1) = tilde(g) (y_t \, epsilon_(t + 1)) = overline(y) + tilde(X) y_(t - 1) + tilde(g)_y epsilon_t$

Alors l’équation de Ricatti s’écrit :

$ A tilde(X) X + B X + C = 0 $

== Itération linéaire dans le temps (2)
<linear-time-iteration-2>
L’algorithme d’itération linéaire dans le temps consiste à résoudre la règle de décision $X$ aujourd’hui en fonction de la règle de décision de demain $tilde(X)$.

Cela correspond à la formule simple :

$ X = - (A tilde(X) + B)^(- 1) C $

Et l’algorithme complet peut être décrit comme suit :

- choisir $X_0$
- pour tout $X_n$, calculer $X_(n + 1) = T (X_n) = - (A X_n + B)^(- 1) C$
  - répéter jusqu’à convergence

== Itération linéaire dans le temps (3)
<linear-time-iteration-3>
On peut montrer qu’en partant d’une condition initiale aléatoire, l’algorithme d’itération linéaire dans le temps converge vers la solution $X$ de plus petit module :

$ underbrace(lr(|lambda_1|) <= dots <= lr(|lambda_n|), upright("Valeurs propres sélectionnées")) <= lr(|lambda_(n + 1)|) dots <= lr(|lambda_(2 n)|) $

Autrement dit, il trouve la bonne solution lorsque le modèle est bien spécifié.

Comment vérifier qu’il est bien spécifié ?

- $lambda_n$ est la plus grande valeur propre de la solution $X$
- qu’en est-il de $lambda_(n + 1)$ ?
  - $1 / lambda_(n + 1)$ est la plus grande valeur propre de $(A X + B)^(- 1) A$

== Itération linéaire dans le temps (4)
<linear-time-iteration-4>
Définissons $ M (lambda) = A lambda^2 + B lambda + C $

Pour toute solution $X$, $M (lambda)$ peut se factoriser ainsi : #footnote[Cas particulier du théorème de Bézout. Facile à vérifier dans ce cas]

$ M (lambda) = (lambda A + A X + B) (lambda I - X) $

et

$ det(M(lambda)) = underbrace(det(lambda A + A X + B), Q(lambda)) det(lambda I - X) $

Par construction, $Q(lambda)$ est un polynôme dont les racines sont celles qui ne sont pas sélectionnées par la solution, c.-à-d. $Lambda in "Sp"(X)$.

== Itération linéaire dans le temps (5)
<linear-time-iteration-5>
Pour $lambda != 0$, on a :

$ lambda in "Sp"((A X + B)^(-1) A) $

$ <=> det((A X + B)^(-1) A - I lambda) = 0 $

$ <=> det(1 / lambda A - I (A X + B)) = 0 $

$ <=> Q(1 / lambda) = 0 $

$ <=> 1 / lambda in Lambda in "Sp"(X) $

En clair, $(A X + B)^(- 1)$ contient toutes les valeurs propres qui ont été rejetées par la sélection de $X$.

En particulier, $rho((A X + B)^(-1) A) = 1 / min(Lambda in "Sp"(X))$.
