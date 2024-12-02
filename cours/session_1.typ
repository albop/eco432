#import "@preview/touying:0.5.3": *
#import "@preview/fontawesome:0.3.0": *
#import "quarto_theme.typ": *

#show: clean-theme.with(
  aspect-ratio: "16-9",
                        )

#title-slide(
  title: [Introduction et Premières Microfondations],
  subtitle: [ECO432 - Macroéconomie],
  authors: (
                    ( name: [Pablo Winant],
            affiliation: [],
            email: [],
            orcid: []),
            ),
  date: [],
)

= Introduction
== Programme des séances

#box[
- Amphi 1 : microfondations
- Amphi 2 : la demande agrégée
- Amphi 3 : l'offre agrégée
- Amphi 4 : banque centrale
- Amphi 5 : gouvernement
]


= Nominal / Réel

== Produit intérieur brut (PIB) Nominal / Réel

Commençons par quelques notations#footnote[Nous utilisons $t$ pour désigner différentes périodes dans le temps.];. Dans ce cours :

- $Y_t$ : #emph[PIB réel] : le nombre de paniers de bien produits par l’économie
- $P_t$ : #emph[Niveau des prix] : le prix d’un panier de biens donné
- $pi_t = frac(P_t - P_(t - 1), P_(t - 1)) $ : #emph[Taux d’inflation]

Avec ces définitions, le #emph[PIB nominal];, c’est-à-dire la production vendue aux prix du marché, est simplement $P_t Y_t$.

== Taux d’intérêt nominal

Pour épargner d’une période à l’autre, les agents ont accès à des obligations sans risque rapportant :

- $i_t$ : taux d’intérêt nominal entre $t$ et $t + 1$

Si un agent investit des économies $S_t$ à la période $t$, il obtient $S_t (1 + i_t)$ à la période $t + 1$.

== Taux d’intérêt nominal / réel

Qu’est-ce qui détermine la décision d’épargner davantage ou moins ?

Considérons l’ expérience de pensée suivante :

- un agent renonce à $1$ unité de consommation à la période $t$, valant $P_t$ aux prix du marché : sa richesse est $P_t$
- investie au taux nominal $i_t$, cette richesse devient $P_t (1 + i_t)$ à la période $t + 1$
- l’agent peut maintenant acheter $frac(P_t (1 + i_t), P_(t + 1))$ biens de consommation au nouveau prix du marché $P_(t + 1)$

En reconnaissant le ratio $1 + pi_(t + 1) = P_(t + 1) / P_t$, nous concluons que chaque unité de consommation aujourd’hui peut être échangée contre $frac(1 + i_t, 1 + pi_(t + 1))$ unités demain

- c’est plus avantageux lorsque le taux d’intérêt nominal est élevé
- c’est moins avantageux lorsque l’inflation est élevée

== Taux d’Intérêt Réel
<taux-dintérêt-réel>
Le #strong[taux d’intérêt réel] $r_t$ est défini par :

$ #box(stroke: black, inset: 3pt, [$ 1 + r_t = frac(1 + i_t, 1 + pi_(t + 1)) $]) $

Il mesure à quel point il est bénéfique d’échanger des biens de consommation actuels contre des biens de consommation futurs.

En logarithmes:

$ #box(stroke: black, inset: 3pt, [$ r_t = i_t - pi_(t + 1) $]) $

Cette relation est parfois appelée l’#strong[équation de Fisher];.

#slide[


#place(center, image("assets/check.jpg"))

][
==== Quizz 1

Supposons que le taux d’intérêt nominal soit de 4% et l’inflation de 5%. Quel est le taux d’intérêt réel (en pourcentage) ?

+ 1
+ -1
+ 4/5
+ 5/6
]

// ==== Quizz 2

// L’effet fishérien est la tendance de l’inflation à augmenter et à annuler toute hausse des taux nominaux par la banque centrale. Cela est plus susceptible de se produire si :

// + le taux réel est indépendant des variables nominales
// + les prix sont rigides
// + l’inflation est élevée
// + la dette est élevée

// …

// ]


= Consommation
<demande>


== Les acteurs économiques


== Les composantes de la demande
<les-composantes-de-la-demande>
Dans une économie de marché, les décisions de dépenses sont prises par :

- Les consommateurs
- Les entreprises
- Les exportateurs et les importateurs
- Le gouvernement

Les dépenses du gouvernement sont déterminées par les décideurs politiques. Parce qu’elles peuvent être choisies indépendamment du niveau de revenu général, elles sont entièrement~#strong[autonomes];.

Dans ce cours, nous considérerons également les décisions des exportateurs et des importateurs comme exogènes afin de nous concentrer sur les consommateurs et les entreprises.#footnote[Pour nos besoins, nous pourrions également faire l’hypothèse plus forte que l’économie est #strong[fermée];, c’est-à-dire que les exportations et les importations sont nulles.]


== Microfondation

Avant de considérer leurs interactions, il faut étudier le comportement de chaque agent.

Comportement:
   objectif + contraintes

Agrégation:
  simplifications (carambouilles)


// == Notre objectif principal aujourd’hui

// Établir pourquoi et comment chacune des composantes de la demande dépend du $Y$ et du $r$.”

= Les Consommateurs

#slide[
  #let title="Decisions de consommation"

#only("1")[
  #box(image("assets/why_do_save_today.png", height: 50%))
]

#only("2,3")[
  #box(image("assets/why_do_save.png", height: 50%))
]
#only("4-")[
  #box(image("assets/why_do_save_r.png", height: 50%))
]

][

Pourquoi les consommateurs épargnent-ils ?

#pause

Pour substituer les biens présents par les biens futurs.

#pause

Qu’est-ce qui détermine la substitution ?

#pause

Le taux d’intérêt (réel)

#pause

Qu’est-ce qui détermine également la substitution ?

#pause

Le revenu aujourd’hui et demain

]

== Décisions de consommation

=== Intuition

Selon leurs préférences, le montant que les consommateurs décident de dépenser est déterminé par :

Leur revenu aujourd’hui ( $Y_t$ ) Leur revenu attendu dans le futur ( $Y_(t + 1) , Y_(t + 2) , . . .$ )


Étant donné leur profil de revenu attendu, la décision de consommer peut être vue comme un arbitrage entre la consommation aujourd’hui et la consommation demain.

Cet arbitrage dépend du taux d’intérêt intertemporel réel ( $r_t$ ).

Les deux déterminants à court terme de la consommation devraient donc être $Y_t$ et $r_t$.

== Consommateurs ricardiens et keynésiens

Classiquement, on distingue :

#columns(2,[

#strong[Ménages Ricardiens]

Des agents qui peuvent librement réaffecter la consommation intertemporelle.

Les ménages Ricardiens choisissent de ne pas consommer davantage aujourd’hui, afin de consommer davantage demain.

#colbreak()

#strong[Ménages Keynésiens]

Des agents dont la consommation dans la période actuelle est limitée par une contrainte de crédit contraignante.

Soit ils ne peuvent pas du tout emprunter, soit le montant qu’ils peuvent emprunter aujourd’hui est limité.

Les ménages Keynésiens consomment aujourd’hui autant qu’ils le peuvent.])

Nous étudierons les deux types d’agents tour à tour, en commençant par les agents Ricardiens.



== Consommateurs Ricardiens

=== Consommateurs Ricardiens

Modélisons le choix intertemporel d’un ménage Ricardien. Ce sont des décideurs rationnels, mais ils ont une préférence pour le présent. Pour des raisons d’exposition, nous supposons qu’ils vivent seulement pendant deux périodes.

Désignons par $C_1$ and $C_2$ la consommation aujourd’hui et demain.

Un consommateur représentatif maximise : $ U (C_1 , C_2) = log (C_1) + beta log (C_2) $

où $beta < 1$ est un facteur d’actualisation, indiquant que la consommation aujourd’hui est préférée. $beta$ est généralement proche de 1.

Cette optimisation n’est pas libre, elle est soumise à une contrainte budgétaire.


== Consommateurs Ricardiens

=== Détermination de la contrainte budgétaire

Notons $P_1 = 1$ le niveau actuel des prix, at $P_2$ le niveau futur.

Notons $P_1 Y_1$ le revenu nominal présent et $P_2 Y_2$ le revenu nominal futur.

On suppose que notre consommateur consomme $C_1$ au prix .$P_1$ pour un montant $C_1 P_1$

Ce qui reste#footnote[Remarquons que la formule est exactement la même selon que le consommateur épargne $(C_1 P_1 < Y_1 P_1)$ ou emprunte $(C_1 P_1 > Y_1 P_1)$ en période 1.];, i.e. $Y_1 P_1 - C_1 P_1$ est épargné au taux nominal $1 + i$ et ajouté au revenu futur.

La contrainte de budget en période 2 s’écrit:

$ C_2 P_2 lt.eq (underbrace(Y_1 P_1 - C_1 P_1, upright("Épargne"))) (1 + i) + Y_2 P_2 $

== Consommateurs

=== Détermination de la contrainte budgétaire

La dernière équation peut être réorganisée comme suit :

$ C_1 P_1 (1 + i) + C_2 P_2 lt.eq Y_1 P_1 (1 + i) + Y_2 P_2 $

Divisons par $P_2$

$ C_1 P_1 / P_2 (1 + i) + C_2 lt.eq Y_1 P_1 / P_2 (1 + i) + Y_2 $

Et reconnaissons $1 + pi = P_2 / P_1$

$ C_1 frac(1 + i, 1 + pi) + C_2 lt.eq Y_1 frac(1 + i, 1 + pi) + Y_2 $

== Consommateurs

=== Contrainte budgétaire intertemporelle

Finalement, la contrainte budgétaire intertemporelle se lit comme suit :

$ C_1 (1 + r) + C_2 lt.eq Y_1 (1 + r) + Y_2 $

Le #emph[côté droit] est le revenu et est donné dans l’optimisation. Il correspond à la richesse totale.

Dans le #emph[côté gauche] : $(1 + r)$ peut être compris comme le prix des biens de consommation d’aujourd’hui.

Quel est l’effet d’un taux d’intérêt réel plus élevé ?

- La consommation aujourd’hui est plus chère : effet de substitution -\> plus de consommation de biens futurs, moins de consommation dans le présent
- Le revenu d’aujourd’hui est plus précieux : il détend la contrainte budgétaire créant un effet de richesse direct -\> plus de consommation des deux biens

== Consommateurs
<consommateurs-3>
Un consommateur résout $ max_(C_1 , C_2) &  & U (C_1 , C_2)\
s. c.  &  & C_1 (1 + r) + C_2 lt.eq Y_1 (1 + r) + Y_2 $

Il s’agit d’un problème d’optimisation sous contrainte, identique à ceux rencontrés en microéconomie.

On obtient facilement la consommation optimale (consommation souhaitée) en période $1$:

$ #box(stroke: black, inset: 3pt, [$ C_1 = frac(1, 1 + beta) (Y_1 + frac(1, 1 + r) Y_2) $]) $

== Ménages Ricardiens
<ménages-ricardiens>
Comment interprétons-nous cette formule optimale ? $ C_1 = frac(1, 1 + beta) underbrace((Y_1 + frac(1, 1 + r) Y_2), upright("Revenu Permanent")) $

Le revenu permanent est la valeur actualisée de tous les revenus perçus par le consommateur sur son horizon d’optimisation. il s’agit essentiellement de la valeur du revenu sur toute la vie similaire à l’évaluation d’un flux de dividendes

Un ménage Ricardien dépense en période 1 une fraction de son revenu permanent.

Cela découle d’un motif de lissage de la consommation dans le temps, qui provient de la concavité de la fonction d’utilité.

Dans le cas à deux périodes, la fraction est $frac(1, 1 + beta) approx 1 / 2$. S’il y avait plus de deux périodes, la fraction serait encore plus petite.

== Réponse au taux d’intérêt
<réponse-au-taux-dintérêt>
À partir de la dernière formule, nous pouvons voir comment les ménages Ricardiens modifient leur consommation en réponse à un changement $Delta r$ dans les taux d’intérêt réels. Alors la consommation augmente de $Delta C$ de telle sorte que : $ C_1 + Delta C = frac(1, 1 + beta) (Y_1 + frac(1, 1 + r + Delta r) Y_2) $

Cela conduit à la formule approximative :

$ #box(stroke: black, inset: 3pt, [$ frac(Delta C, Delta r) = - frac(1, 1 + beta) 1 / (1 + r)^2 Y_2 $]) $

En accord avec l’intuition : la consommation aujourd’hui est plus faible lorsque le taux d’intérêt réel est plus élevé.

== Choc de revenu temporaire
<choc-de-revenu-temporaire>
Comment réagissent les ménages Ricardiens aux chocs de revenu ?

Supposons que le revenu augmente temporairement (en période $1$) de $Delta Y$. Alors la consommation augmente de $Delta C$ de telle sorte que : $ C_1 + Delta C = frac(1, 1 + beta) underbrace((Y_1 + Delta Y + frac(1, 1 + r) Y_2), upright("Revenu Permanent")) $

Nous obtenons une propension marginale à consommer (à partir d’un choc temporaire) égale à#footnote[Nous avons utilisé deux périodes pour simplifier l’exposition. Dans les modèles NK pratiques, le revenu permanent est $sum_t 1 / (1 + r)^t Y_t$ et la fraction consommée en première période serait $(1 - beta) approx 0$, ce qui est très proche de 0.] :

$ M P C^(upright("ricardian")) = frac(Delta C, Delta Y) = frac(1, 1 + beta) < < 1 $

== Ménages Keynésiens

Intrinsèquement, les agents keynésiens ont les mêmes préférences en matière de consommation que les ménages ricardiens.

Idéalement, ils aimeraient dépenser une fraction de leur revenu permanent, mais ils sont confrontés à une limite quant à la somme qu’ils peuvent emprunter.

// #image("assets/../bank_no.jpg", width: 0.52083333333333in)

Un agent keynésien pur (qui ne peut pas emprunter du tout) est soumis à la contrainte simple $C_1 lt.eq Y_1$ et puisqu'il consomme autant que possible, sa consommation est simplement : $ C_1 = Y_1 $

Sa propension marginale à consommer est :

$ P M C^(upright("keynésien")) = diff(C_1)/(diff Y_1)= 1 $

==== Quiz 3
<quiz-3>
Parmi les agents suivants, lequel est le plus susceptible d’être keynésien ?

+ un étudiant qui envisage une offre de prêt de la banque pour couvrir les frais universitaires
+ un ménage de classe moyenne réduisant les dépenses alimentaires pour rembourser un prêt en cours
+ un travailleur à faible revenu aux États-Unis, qui n’a pas de carte de crédit
+ un trader boursier

== Consommation Agrégée
<consommation-agrégée>
Pour connaître le comportement de la consommation agrégée, en particulier la propension marginale à consommer agrégée, nous devons connaître la proportion de ménages ricardiens et keynésiens.#footnote[Vous verrez lors du PC2, que le comportement de la consommation agrégée dépend crucialement de la nature redistributive des chocs.]

#block[
#block[
#figure([
#box(image("assets/keynesian_dog.png", width: 40%))
], caption: figure.caption(
position: bottom, 
[
Un chien keynésien, lors de la récession de 1929
]), 
kind: "quarto-float-fig", 
supplement: "Figure", 
)


]
#block[
#figure([
#box(image("assets/ricardian_cat.png", width: 40%))
], caption: figure.caption(
position: bottom, 
[
Un chat ricardien, jouant avec de l’argent.
]), 
kind: "quarto-float-fig", 
supplement: "Figure", 
)


]
]


= Les Firmes
