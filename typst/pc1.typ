#import "pc_template.typ": pc

#show: doc => pc(
  1,
  [Consommation],
  doc,
)


== Exercice 1: Choix de consommation

On étudie les choix de consommation de ménages qui maximisent leur utilité intertemporelle. On raisonne sous l’hypothèse de prévisions parfaites, de sorte que les
ménages anticipent parfaitement les valeurs futures de leur revenu.

Les individus vivent deux périodes. L’utilité intertemporelle du ménage $j$ à partir de la période $t = 0$
est donnée par

$ cal(U)_0 = ln C_0^j + (1/(1+rho)) ln C_1^j $<eq:utility>
 
avec $C_t^j$ la consommation du ménage et $ρ > 0$ son “taux de préférence pour le présent” (plus $ρ$ est élevé, moins la consommation future est valorisée relativement à la consommation présente).

Le ménage fait face, à chaque période $t = 0, 1$, à la contrainte :

$ underbrace( C_t^j, "consommation") + underbrace(A^j_t - A^j_(t-1), "épargne financière nette") = underbrace(r_(t-1) A^j_(t-1),"revenus du patrimoine") + underbrace( W_t/P_t overline(L)_t^j,"revenu salarial") $<eq:budget_constraint>


avec $overline(L)^j_t$ est la quantité de travail fournie par le ménage (ici exogène), $A^j_t$ son patrimoine (en fin de période $t$), $W_t /P_t$ le salaire réel et $r_t$ le taux d’intérêt réel entre les périodes $t$ et $t+1$. $(W_t /P_t )overline(L)^j_t$ est donc le revenu salarial du ménage. Par la suite, on écrira le revenu salarial $h^j_t = (W_t /P_t )overline(L^j_t)$ . Par souci de simplicité on fait ici abstraction des impôts.


Dans le problème du ménage, il est important de distinguer les variables qui sont choisies par le ménage et les variables qui sont prises comme données par chaque ménage. Le ménage choisit $A^j_0$, $A^j_1$, $C^j_0$ et $C^j_1$. Dans un équilibre compétitif, on suppose que les prix ${r_t, W_t, P_t}_(t=0,1)$ et $r_(-1)$ sont pris comme donnés par chaque ménage. Les revenus du travail sont également supposés être exogènes dans cet exercice. Le patrimoine initial $A^j_(-1)$ est exogène car il est le résultat de décisions passées.

Les ménages peuvent par ailleurs être sujets à une contrainte d'endettement de la forme :

$ A^j_t >= overline(D)_t/(1+r_t) ", avec " overline(D)_t<=0 $<eq:borrowing_constraint>

de sorte qu'ils ne peuvent s'endetter que jusqu'au point où la dette à rembourser (capital et intérêt) est égale à $-overline(D)_t$.

1. Expliquer intuitivement pourquoi $A^j_1 = 0$ [indice : distinguer les cas $A^j_1 < 0$ et $A^j_1 > 0$]; en déduire la contrainte budgétaire intertemporelle du ménage : $ C^j_0 + C^1_j /(1+r_0) = A^j_(-1) (1+r_(-1)) + h^j_0 + h^j_1/(1+r_0) $<eq:intertemporal_budget>  et interpréter cette expression.


2. Un ménage _ricardien_ (R) est un ménage dont les choix de consommation ne sont jamais contraints par la contrainte d’endettement @eq:borrowing_constraint. Ecrire le lagrangien correspondant au problème de maximisation d’un ménage ricardien, en déduire que ses choix satisfont la condition : $ C_1^R/C_0^R = (1+r_0)/(1+rho) $ et interpréter cette relation.

3. Utiliser les réponses précédentes pour calculer $C^R_0$ et $C_1^R$ en fonction de $rho$ et de la richesse totale (le côté droit de l'équation @eq:intertemporal_budget) et expliquer intuitivement l'expression obtenue. Considérons le as $rho=r_0$ et $A_(-1)=0$. Étudiez comment $C^R_0$ et $A^R_0$ changent lorsqu'il y a une augmentation de $h^j_0$ (revenu courant) ou de $h^j_1$ (revenu futur).

4. Un ménage "keynésien" est un ménage dont la consommation courante est systématiquement contrainte par l'équation @eq:borrowing_constraint. Calculez sa consommation et expliquez pourquoi elle diminue en fonction du taux d'intérêt réel.

\

== Exercice 2: Épargne de précaution

Considérons le choix de consommation d’un individu qui vit pendant deux périodes, $t = 0, 1$. Supposons que l’utilité à chaque période soit :
$ u(C_t)= cases(
  a C_t - b/2(C_t)^2 "si" & C_t in [0,a/b],
  a^2/(2 b) & C_t>=a/b
) $

Le revenu de la première période est $h_0$. Le revenu de la deuxième période est $h_1$ . À chaque $t = 0, 1$,
la contrainte budgétaire est
$ C_t + A_t - A_(t−1) = r_(t−1) A_(t−1) + h_t $

On suppose que $r_0 = r_(−1) = 0$ et que le patrimoine initial est nul: $A_(−1) = 0$. Sachant qu'à l’équilibre les individus choisissent $A_1 = 0$, les contraintes budgétaires peuvent s’écrire:
$ C_0 + A_0 = h_0 $
$ C_1 = A_0 + h_1 $

Le revenu de la première période est $h_0 = a/b$. Une caractéristique importante de cet exercice est que
le revenu de la deuxième période est aléatoire:
$ h_1 = cases(
  a/b+sigma "avec probabilité" 1/2,
  a/b-sigma "avec probabilité" 1/2
) $<eq:proba_distribution>

Aujourd’hui ($t = 0$), les individus ne savent pas quel sera le revenu de la période suivante, mais
on suppose qu’ils connaissent la distribution de probabilité @eq:proba_distribution. Une augmentation de $σ$ ne modifie pas la valeur attendue du revenu, mais peut être interprétée comme une augmentation de l’incertitude
(“mean-preserving spread”). Une plus grande dispersion signifie que le revenu est ”plus risqué”.


Le consommateur maximise, à la date $0$, l’espérance de la somme des utilités futures actualisées. On
suppose que $ρ = 0$ (les individus sont infiniment patients). En utilisant les contraintes budgétaires, nous
écrivons l’utilité intertemporelle espérée :

$ cal(U)_0 = underbrace(u(h_0-A_0),"utilité aujourd hui") + 1/2 underbrace(u(A_0 + a/b - sigma),"utilité si " h_1 " est bas" ) + 1/2 underbrace( u(A_0+a/b+sigma), "utilité si "h_1" est élevé") $

1. Tracez l'utilité marginale $u'(c_t)$ en fonction de la consommation.

2. Tout d'abord, supposons que $sigma=0$ (aucun risque). Trouvez l'épargne optimale $A_0$; puis, calculez $C_0$ et $C_1$. deuxièmement, supposons que le revenu $h_1$ est incertain. Étudiez comment $sigma$ affecte les choix optimaux de $A_0$, $C_0$ et $C_1$. Comparez les deux cas ($sigma=0$ et $sigma>0$). Y a-t-il plus d' épargne lorsque le revenu est incertain? Expliquez.

