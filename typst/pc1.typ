#import "pc_template.typ": pc, correction

#let correct=false

#show: doc => pc(
  1,
  [Consommation],
  doc,
  correct: correct,
)

#let correction = correction.with(visible: correct)

== Exercice 1: Choix de consommation

On étudie les choix de consommation de ménages qui maximisent leur utilité intertemporelle. On raisonne sous l'hypothèse de prévisions parfaites, de sorte que les
ménages anticipent parfaitement les valeurs futures de leur revenu.

Les individus vivent deux périodes. L'utilité intertemporelle du ménage $j$ à partir de la période $t = 0$
est donnée par

$ cal(U)_0 = ln C_0^j + (1/(1+rho)) ln C_1^j $<eq:utility>
 
avec $C_t^j$ la consommation du ménage et $ρ > 0$ son “taux de préférence pour le présent” (plus $ρ$ est élevé, moins la consommation future est valorisée relativement à la consommation présente).

Le ménage fait face, à chaque période $t = 0, 1$, à la contrainte :

$ underbrace( C_t^j, "consommation") + underbrace(A^j_t - A^j_(t-1), "épargne financière nette") = underbrace(r_(t-1) A^j_(t-1),"revenus du patrimoine") + underbrace( W_t/P_t overline(L)_t^j,"revenu salarial") $<eq:budget_constraint>


avec $overline(L)^j_t$ est la quantité de travail fournie par le ménage (ici exogène), $A^j_t$ son patrimoine (en fin de période $t$), $W_t /P_t$ le salaire réel et $r_t$ le taux d'intérêt réel entre les périodes $t$ et $t+1$. $(W_t /P_t )overline(L)^j_t$ est donc le revenu salarial du ménage. Par la suite, on écrira le revenu salarial $h^j_t = (W_t /P_t )overline(L^j_t)$ . Par souci de simplicité on fait ici abstraction des impôts.


Dans le problème du ménage, il est important de distinguer les variables qui sont choisies par le ménage et les variables qui sont prises comme données par chaque ménage. Le ménage choisit $A^j_0$, $A^j_1$, $C^j_0$ et $C^j_1$. Dans un équilibre compétitif, on suppose que les prix ${r_t, W_t, P_t}_(t=0,1)$ et $r_(-1)$ sont pris comme donnés par chaque ménage. Les revenus du travail sont également supposés être exogènes dans cet exercice. Le patrimoine initial $A^j_(-1)$ est exogène car il est le résultat de décisions passées.

Les ménages peuvent par ailleurs être sujets à une contrainte d'endettement de la forme :

$ A^j_t >= overline(D)_t/(1+r_t) ", avec " overline(D)_t<=0 $<eq:borrowing_constraint>

de sorte qu'ils ne peuvent s'endetter que jusqu'au point où la dette à rembourser (capital et intérêt) est égale à $-overline(D)_t$.

1. Expliquer intuitivement pourquoi $A^j_1 = 0$ [indice : distinguer les cas $A^j_1 < 0$ et $A^j_1 > 0$]; en déduire la contrainte budgétaire intertemporelle du ménage : $ C^j_0 + C^1_j /(1+r_0) = A^j_(-1) (1+r_(-1)) + h^j_0 + h^j_1/(1+r_0) $<eq:intertemporal_budget>  et interpréter cette expression.

#correction[

  Pour obtenir la contrainte budgétaire intertemporelle (CBI), on utilise les contraintes budgétaires de chaque période $t=0,1$:

$ t = 0 : & C_0^j+A_0^j=A_(-1)^j ( 1+r_(-1)) + h^j_0 \
  t = 1 : & C_1^j+A_1^j=A_0^j ( 1+r_0) + h^j_1 $

La consommation au-delà de la période $1$ n'étant pas valorisée, cela n'aurait aucun sens de choisir $A_1^j>0$ ; et comme le ménage n'a pas de revenu salarial au-delà de la période $1$ personne n'accepterait d'être son créditeur, il est donc
impossible que $A_1^j<0$. On a donc nécessairement $A_1^j=0$. En utilisant la seconde ligne pour éliminer $A^j_0$ de la première, on obtient :

$ underbrace(
    C_0^j + C_1^j/(1+r_0),
    "valeur présente des flux de consommation"
  ) = underbrace(
    underbrace(
      A_(-1)^j ( 1+r_(-1) ),
      "patrimoine et intérêts"
    ) + underbrace(
      h_0^j + (h_1^j)/(1+r_0),
      "valeur présente du revenu salarial net d'impôt"
    ),
    "richesse totale"
  ) $ <eq:2_CBI>

On denote la richesse totale par $W^j_0$.

// `)

]

2. Un ménage _ricardien_ (R) est un ménage dont les choix de consommation ne sont jamais contraints par la contrainte d'endettement @eq:borrowing_constraint. Ecrire le lagrangien correspondant au problème de maximisation d'un ménage ricardien, en déduire que ses choix satisfont la condition : $ C_1^R/C_0^R = (1+r_0)/(1+rho) $ et interpréter cette relation.

#correction[

Le lagrangien s'écrit :

$ cal(L)_0=cal(U)_0 + Lambda^j  ( A_(-1)^j (
1+r_(-1) ) +h_0^j + h_1^j/(1+r_0) - C_0^j - (C_1^j)/(1+r_0)) $

avec $Lambda^j$ le multiplicateur de Lagrange associé à la CBI.
Les conditions de premier ordre associées au choix de $C_0^j$ et $
C_1^j$ sont données par :

$ (partial cal(L)_0)/(partial C_0^j)=1/( C_0^j) - Lambda ^j=0,\ \ (partial cal(L)_t)/(partial C_1^j) =( 1/(1+rho) ) 1/(C_1^j)- (Lambda ^j)/( 1+r_0)=0  $ <eq:2_CPO_conso>

En utilisant ces deux équations pour éliminer $Lambda^j$, on
trouve que la consommation d'un ménage ricardien satisfait :


$ 1/C_0 =  1/ ((1+rho)C_1) (1+r_0) $ <eq:3_Keynes_Ramsey_a>

L'agent choisit sa consommation de facon a égaliser les utilités marginales de la période courante et de la période suivante (actualisée): à l equilibre, l'individu est indifférent entre consommation et épargne.  Le terme de gauche  représente le supplément d'utilité que l'on obtient en consommant une unité supplémentaire de consommation dans le présent. Le terme de droite représente le coût de cette unité supplémentaire: l'épargne et les intérêts auxquels on renonce en consommant une unité supplémentaire dans le présent ce qui diminue la consommation future d'un montant $1+r_0$ et par conséequent, diminue l'utilité dans le futur. Le modèle prédit que seule la consommation passée sert a prévoir celle du présent ; en particulier, le revenu n'intervient pas directement, car toute l'information est déjà contenue dans $C_0$. Cela est dû au fait que les marchés des capitaux sont parfaits.

Écrivons
 
$ (C_1)/(C_0)=(1+r_0)/(1+rho) $ <eq:3_Keynes_Ramsey>

La relation précédente s'appelle la _règle de Keynes-Ramsey_. Cette règle traduit le phénomène de "substitution intertemporelle de consommation" suite à un changement de $r_0$. Une hausse de $r_0$ augmente la pente du sentier de consommation, car elle incite les ménages à consommer moins à la période courante afin d'épargner davantage (ou réduire leur endettement) et ainsi consommer davantage à l'avenir. Inversement, une baisse de $r_0$ décourage l'épargne, réduisant ainsi la pente du chemin de consommation. L'équation @eq:3_Keynes_Ramsey nous donne la pente du chemin de consommation, mais elle ne nous donne pas les valeurs absolues de $C_0$ et $C_1$.

]

3. Utiliser les réponses précédentes pour calculer $C^R_0$ et $C_1^R$ en fonction de $rho$ et de la richesse totale (le côté droit de l'équation @eq:intertemporal_budget) et expliquer intuitivement l'expression obtenue. Considérons le cas $rho=r_0$ et $A_(-1)=0$. Étudiez comment $C^R_0$ et $A^R_0$ changent lorsqu'il y a une augmentation de $h^j_0$ (revenu courant) ou de $h^j_1$ (revenu futur).

#correction[

En utilisant l'expression @eq:3_Keynes_Ramsey on peut éliminer $C_1$  de l'expression de la valeur présente des flux de
consommation dans la CBI:

$ C_0+ (C_0 (1+r_0))/((1+r_0) (1+rho)) = W_0 $  <eq:2_CBI>

$ C_0= W_0 (1+rho)/(2+rho) $ <eq:2_CBI9>

Le ménage consomme une fraction de sa richesse totale (entendue comme la somme de son patrimoine accumulé et de la valeur présentede ses flux de revenu disponibles). Cette fraction est croissante en $rho$. Un consommateur très impatient ($rho  -> infinity$) fait des emprunts importants et consomme toute sa richesse en t=0. La richesse $W_0$ baisse quand $r_0$ augmente:  $C_0$ est donc décroissant en $r_0$.  


En utilisant l'expression @eq:3_Keynes_Ramsey 

$ C_1= (1+r_0)/(2+rho) W_0 $ <eq:2_CBI9>

Supposez maintenant que $rho=r_0$. Dans ce cas on a un lissage parfait de la consommation 
:
$ C_1=C_0= (1+rho)/(2+rho) W_0 $ <eq:2_CBI91>

En utilisant la contrainte budgétaire en $t=0$ et en supposons que $r_0=rho$ et $A_(-1)=0$, on obtient que le patrimoine est

$ A_0= h_0 - (1+rho)/(2+rho) [h_0+h_1/(1+rho)] $

ce qui donne: 

$ A_0= (h_0-h_1)/(2+rho) $ <eq:asset>


Les consommateurs qui s'attendent à des revenus plus faibles à l'avenir (par exemple, les personnes
proches de la retraite) épargnent: à partir de l'équation @eq:asset, quand $h_0 > h_1$ on a $A_0 > 0$. Par
contre, les consommateurs qui s'attendent à des revenus plus élevés à l’avenir (par exemple, les
étudiants) empruntent: quand $h_0 < h_1$, on a $A_0 < 0$. Dans ce cadre, les institutions financières
améliorent l'utilité en permettant aux consommateurs d'emprunter et de prêter, ce qui les aide à
lisser la consommation dans le temps.


Comment la consommation varie-t-elle en cas de changement de revenu ? Une augmentation de $h_0$ et/ou de $h_1$ augmente la richesse de l'individu. Comme la consommation est un bien normal, $C_1$ et $C_0$ augmentent. En utilisant l'équation (8), on remarque que $C_0$ augmente moins que l'augmentation de $h_0$ : une augmentation de $h_0$ entraîne une augmentation de l'épargne, ce qui
permet de consommer davantage en $t = 1$. Si le revenu attendu h1 augmente, l'épargne diminue
pour permettre à $C_0$ d'augmenter.
En d'autres termes, les consommateurs ricardiens lissent leur consommation par rapport à leurs
revenus. Il est également important de noter que lorsque le revenu courant change, il est crucial de savoir si ce changement de revenu est temporaire (c'est-à-dire que le changement se produit
en une seule période) ou permanent. La Figure 1 montre qu'il y a moins de variabilité dans la
consommation de biens non durables et de services que dans le PIB réel. A noter que les économistes
estiment que la corrélation entre la consommation et les fluctuations du revenu est plus élevée que
ce que la théorie prédirait. Cela est probablement dû au fait que certains individus sont exclus du marché du  crédit et ne peuvent pas lisser leur consommation. Par conséquent, leur consommation est très sensible aux variations de revenus.


// 1340 Part IV Savings, Investment, and Government Deficits
// deviations from trend in the consumption of durables, and in GDP for the period
// 1947–2015. Clearly, the consumption of durables is much more variable than aggregate
// income, and if we compare Figure 9.6 to Figure 3.10 in Chapter 3, it is clear that dura-
// bles consumption behaves much like aggregate investment. However, Figure 9.7
// depicts the percentage deviations from trend in the consumption of nondurables and
// services and in real GDP. Here, clearly there is much less variability in the consumption
// of nondurables and services—which comes fairly close to measuring a flow of con-
// sumption services—than in real GDP. What we observe in Figure 9.7 accurately reflects
// the tendency of consumers to smooth consumption over time relative to income.
// Though aggregate data on consumption and income are clearly qualitatively consist-
// ent with consumption-smoothing behavior on the part of consumers, macroeconomists
// have been interested in th

// {\samepage
// \begin{center}
// \begin{tabular}{c}
// \resizebox{13cm}{8cm}{\includegraphics{consumption.pdf}   }
// \end{tabular}
// \end{center}}

#figure(
  image("pc1_assets/nondurables_services.png", width: 80%),
  caption: 
  [Consommation de bien non durables et de services et PIB, en déviation au trend.],
) <nondurables>

]

4. Un ménage "keynésien" est un ménage dont la consommation courante est systématiquement contrainte par l'équation @eq:borrowing_constraint. Calculez sa consommation et expliquez pourquoi elle diminue en fonction du taux d'intérêt réel.

#correction[

D’après la contrainte budgétaire, un ménage keynésien consomme :

$ C_0^K = underbrace((- overline(D)_0 )/(1+r_0),"nouvelle dette émise") + underbrace((W_0)/(P_0) overline(L)^K_0, "revenu salarial") $

Une hausse du taux d'intérêt réel réduit la capacité d'endettement courante du ménage, ce qui le
contraint à réduire sa consommation (toutes choses étant égales par ailleurs). Il est important de
noter que, contrairement aux consommateurs ricardiens, les consommateurs keynésiens sont ”hand-to-mounth” : si leur revenu courant augmente de 1 euro, leur consommation augmente également de 1 euro (la propension marginale à consommer est 100 %).

]

\

== Exercice 2: Épargne de précaution

Considérons le choix de consommation d'un individu qui vit pendant deux périodes, $t = 0, 1$. Supposons que l'utilité à chaque période soit :
$ u(C_t)= cases(
  a C_t - b/2(C_t)^2 "si" & C_t in [0,a/b],
  a^2/(2 b) & C_t>=a/b
) $

Le revenu de la première période est $h_0$. Le revenu de la deuxième période est $h_1$ . À chaque $t = 0, 1$,
la contrainte budgétaire est
$ C_t + A_t - A_(t−1) = r_(t−1) A_(t−1) + h_t $

On suppose que $r_0 = r_(−1) = 0$ et que le patrimoine initial est nul: $A_(−1) = 0$. Sachant qu'à l'équilibre les individus choisissent $A_1 = 0$, les contraintes budgétaires peuvent s'écrire:
$ C_0 + A_0 = h_0 $
$ C_1 = A_0 + h_1 $

Le revenu de la première période est $h_0 = a/b$. Une caractéristique importante de cet exercice est que
le revenu de la deuxième période est aléatoire:
$ h_1 = cases(
  a/b+sigma "avec probabilité" 1/2,
  a/b-sigma "avec probabilité" 1/2
) $<eq:proba_distribution>

Aujourd'hui ($t = 0$), les individus ne savent pas quel sera le revenu de la période suivante, mais
on suppose qu'ils connaissent la distribution de probabilité @eq:proba_distribution. Une augmentation de $σ$ ne modifie pas la valeur attendue du revenu, mais peut être interprétée comme une augmentation de l'incertitude
(“mean-preserving spread”). Une plus grande dispersion signifie que le revenu est ”plus risqué”.


Le consommateur maximise, à la date $0$, l'espérance de la somme des utilités futures actualisées. On
suppose que $ρ = 0$ (les individus sont infiniment patients). En utilisant les contraintes budgétaires, nous
écrivons l'utilité intertemporelle espérée :

$ cal(U)_0 = underbrace(u(h_0-A_0),"utilité aujourd hui") + 1/2 underbrace(u(A_0 + a/b - sigma),"utilité si " h_1 " est bas" ) + 1/2 underbrace( u(A_0+a/b+sigma), "utilité si "h_1" est élevé") $

1. Tracez l'utilité marginale $u'(C_t)$ en fonction de la consommation.

#correction[

L'utilité est strictement croissante pour tout  $C <= a/b$ et constante lorsque $C >= a/b$. L 'utilité marginale est convexe et est dessinée ci-dessous. 

#figure(
  image("pc1_assets/concavity.png", width: 40%)
) <concavity>


La convexité de l'utilité marginale joue un rôle important pour les résultats ci-dessous. En prenant la dérivée par rapport à $A_0$, la condition d'optimalité est


$ U'(a/b-A_0)= 1/2 underbrace(U'(A_0+a/b-sigma),"U marg. si " h_1 "est bas") +  1/2 underbrace(U'(A_0+a/b+sigma), "U marg. si " h_1 "est élevée") $ <eq:euler1>

]


#set enum(numbering: "1.", start: 2)
+ Tout d'abord, supposons que $sigma=0$ (aucun risque). Trouvez l'épargne optimale $A_0$; puis, calculez $C_0$ et $C_1$. Deuxièmement, supposons que le revenu $h_1$ soit incertain. Étudiez comment $sigma$ affecte les choix optimaux de $A_0$, $C_0$ et $C_1$. Comparez les deux cas ($sigma=0$ et $sigma>0$). Y a-t-il plus d' épargne lorsque le revenu est incertain? Expliquez.

#correction[

Si $sigma=0$ la condition de premièr ordre devient

$
U'(a/b-A_0)=  U'(A_0+a/b)
$<eq:2_CB1>

Dans ce cas, il est immédiat que la solution est $A_0=0$, ce qui permet un lissage parfait de la consommation ($C_0=C_1=a/b$).

Supposons maintenant que $sigma>0$ et cherchons la solution en deux étapes:


#underline[Étape 1]: Montrons que lorsque $sigma>0$, $A_0=0$ n'est pas optimal. On evalue @eq:euler1 à $A_0=0$ puis on montre que la condition de premier ordre n'est pas satisfaite. 

Le côté gauche de @eq:euler1 est zéro. Pour déterminer la valeur du côté droit, on remarque que lorsque $A_0=0$, lors de la deuxième période, l'agent consomme soit $a/b+sigma$ (qui donne une utilité marginale nulle) soit $a/b-sigma$ (qui donne une utilité marginale positive). En examinant le graphique, le côté droit est strictement positif car l'utilité marginale est convexe. Par conséquent, la condition d'optimalité n'est pas satisfaite. Lorsque $sigma>0$, l'agent est incité à épargner dans la première période, c'est à dire $A_0>0$ et $C_0<a/b$, ce qui élève l'utilité marginale à $t=0$ au dessus de zéro.

#underline[Étape 2]: puisque $A_0>0$, on sait maintentant que l'utilité marginale quand $h_1$ est élevé est zéro (car $A_0+a/b+sigma>a/b$). Rappelant que lorsque $C<a/b$ l'utilité marginale est $a- b C$, l'équation @eq:euler1 devient:

$ a-b(a/b-A_0) =  1/2 [a-b (A_0+a/b-sigma)] $<eq:euler>

ce qui permet de résoudre: $ A_0= sigma/3 $

Ensuite, en utilisant les contraintes budgétaires

$ C_0 = a/b-sigma/3 $<eq:2_CB>

La consommation en deuxième période est une variable aléatoire

$
C_1=cases(
  a/b+sigma+sigma/3 "avec probabilité " 1/2,
  a/b-sigma+sigma/3 "avec probabilité " 1/2
)
$
Face au risque, l'agent a tendance à épargner, ce qui réduit le niveau de consommation courante.
Plus σ est élevé, plus $A_0$ est élevé.



La crise liée à la COVID-19 a accru la propension à épargner, comme le montre le graphique illustrant un pic de la propension (déclarée) à épargner des ménages français pendant et après le confinement. La théorie prédisait qu'en réponse à un choc temporaire négatif sur le revenu, les individus devraient moins épargner. Alors, pourquoi la propension à épargner a-t-elle augmentée ?
Une partie de l'explication réside dans l'épargne forcée : certaines dépenses n'étaient pas possibles
pendant le confinement. Cependant, une autre partie de l'explication tient à l'épargne de précaution
: la COVID-19 a accru l'incertitude (concernant l'infectiosité du virus, le temps nécessaire pour
développer des vaccins, les implications économiques, etc.)

#figure(
  image("pc1_assets/insee_epargne.png", width: 60%),
  // caption: [],
) <insee>

]