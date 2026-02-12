
= Introduction


== Les acteurs économiques

Dans une économie de marché, les décisions sont prises par :

- Les consommateurs
- Les entreprises
- Les banques
- Le gouvernement
- La banque centrale
- ...

La macroéconomie consiste en l'étude des interactions entre ces acteurs. Elles se produisent simultanément sur plusieurs marchés (marché du travail, des biens, du crédit, ...)

Souvent les macroéconomistes s'intéressent à l'évolution des grands agrégats (PIB, Inflation, Investissement, ...) mais pas seulement!

// TODO: example


== Microfondation

*Approche académique*: modéliser le comportement de chaque  agent avant les interactions,

*Microfondation*: modélisation standard d'un acteur économique
- objectif
- contraintes

Examples:
- consommateur
  - objectif: l'utilité du travail et  de la consommation $max sum_(t=0)^(infinity) beta^t U(c_t, l_t)$
  - sous contrainte de budget $forall t, c_t <= w_t l_t + a_(t-1) r_t$
- firmes:
  - maximisation du du profit $max pi$ sous contrainte d 'une fonction de production

Notons que rien n'est scientifiquement interdit dans la modélisation des agents (rationalité limitée, préférences sociales, croyances motivées, incohérence temporelle, ...)

== Agrégation

La prise en compte simultanée de plusieurs types d'agents et de marchés induits
- des phénomènes émergents (notamment à court terme)
  - phénomène de *demande agrégée*
  - *ajustement incomplet* des prix et de la production
  - *externalités* de toutes sortes

- des complications pratique
  - taille de l'espace d'état#footnote[Le nombre de paramètres à considérer dans les problèmes d'optimisation devient gigantesque. Ceci est d' autant plus vrai que les modèles sont dynamiques.]
  - augmentation du nombre de degrés de liberté #footnote[Les effets sont similaires à l'overfitting en marchine learning: le modèle peut répliquer n'importe que phénomène, mais ne peut rien prédire. Aussi, le modèle ne peut jamais être invalidé.]

== Agrégation

=== Deux approches


\
#columns(2, [

  ==== Analytique

  Résoudre le problème d'aggrégation

  - par des simplifications théoriques
    - ex: les consommateurs sont identiques, leur distribution est continue...
    - ex: anticipations rationnelles

  - par des méthodes de simulations#footnote[Ces méthodes restent compliquées et limitées. On sait très bien "résoudre un modèle" autour d'un point fixe. Mais l'hétérogénéité des agents et la nonlinearité des modèles motive toujours une recherche très active.]

  #colbreak()

  ==== Synthétique

  Comprendre les phénomènes agrégés

  - faire des hypothèses sur le comportement des grands agrégats
    - développer des intuitions sur le type de chocs
    - confronter à la réalité (aux données)
    - croiser les sources

])


== Court Terme / Long Terme

Les méthodes de la macroéconomie s'appliquent à différents horizons.

#pause

*Court terme*: période assez courte#footnote[Le durée du court terme dépend du choc considéré et de sa persistence.] pour que l'ajustement de certaines variables à des chocs exogènes soit incomplète
- ajustement incomplet des facteurs de production (travail, capital)
- rigidité des prix,  ajustement par les quantités#footnote[On y reviendra lorsqu'on couvrira la courbe d'offre.]
- analyse conjoncturelle (réponse à des chocs)

// #footnote[⚠️ On ne parle en général pas de "déséquilibre" pour qualifier le court terme, car les marchés y sont typiquement à l'équilibre.]

#pause

*Long terme*: période assez longue pour que les chocs exogènes aient été absorbés.
- les prix sont à l'équilibre
- analyse structurelle (comment stimuler la R&D, la capacité de production des firmes, ...)



== Programme des séances <programme>

#columns(2, [
  ==== Macroéconomie du court terme
  #box[
    - Amphi 1 : introduction, consommation
      - PC: consommation (micro)
    - Amphi 2 : la demande agrégée
      - PC: croix keynésienne
    - Amphi 3 : l'offre agrégée
      - PC: courbe d'offre (micro)
    - Amphi 4 : analyse des fluctuations
      - PC: chocs macroéconomique
    - Amphi 4 : politique monétaire
      - PC: biais inflationniste (micro)
  ]

  #colbreak()

  ==== Macroéconomie du Long Terme (à confirmer)

  (avec Alessandro Riboni)

  #box[
    - Amphi 6 : politique budgétaire
    - Amphi 7 : croissance (1)
    - Amphi 8 : croissance (2)
    - Amphi 9 : inégalités (1)
    - Amphi 10 : environnement
  ]

])


== Organisation pratique

- Déroulé:
  - 10 séances de cours (Alessandro Riboni et Pablo Winant)
  - 10 TDs (Augustin Pérez-Barahona et Mehdi Senouci)
- Il faut savoir
  - tout ce qui est sur les slides
  - résoudre les exercices (problèmes et QCM)

- Évaluation
  - note de participation
    - participation + débat final + QCM
  - contrôle final (3h)
    - deux parties

⚠️ Il ne suffit pas de savoir calculer pour réussir, il faut aussi être familier des concepts.

// == Long terme et dichotomie classique

// Pour les économistes classiques, seuls les prix relatifs entre les biens comptent pour déterminer les allocations.

// À long terme, les prix se sont ajustés, seuls les prix relatifs comptent.




// == PIB / panier de consommation


// == Produit intérieur brut (PIB) Nominal / Réel

// Commençons par quelques notations#footnote[Nous utilisons $t$ pour désigner différentes périodes dans le temps.];. Dans ce cours :

// - $Y_t$ : #emph[PIB réel] : le nombre de paniers de bien produits par l’économie
// - $P_t$ : #emph[Niveau des prix] : le prix d’un panier de biens donné
// - $pi_t = frac(P_t - P_(t - 1), P_(t - 1)) $ : #emph[Taux d’inflation]

// Avec ces définitions, le #emph[PIB nominal];, c’est-à-dire la production vendue aux prix du marché, est simplement $P_t Y_t$.

// == Taux d’intérêt nominal

// Pour épargner d’une période à l’autre, les agents ont accès à des obligations sans risque rapportant :

// - $i_t$ : taux d’intérêt nominal entre $t$ et $t + 1$

// Si un agent investit des économies $S_t$ à la période $t$, il obtient $S_t (1 + i_t)$ à la période $t + 1$.

// == Taux d’intérêt nominal / réel

// Qu’est-ce qui détermine la décision d’épargner davantage ou moins ?

// Considérons l’ expérience de pensée suivante :

// - un agent renonce à $1$ unité de consommation à la période $t$, valant $P_t$ aux prix du marché : sa richesse est $P_t$
// - investie au taux nominal $i_t$, cette richesse devient $P_t (1 + i_t)$ à la période $t + 1$
// - l’agent peut maintenant acheter $frac(P_t (1 + i_t), P_(t + 1))$ biens de consommation au nouveau prix du marché $P_(t + 1)$

// En reconnaissant le ratio $1 + pi_(t + 1) = P_(t + 1) / P_t$, nous concluons que chaque unité de consommation aujourd’hui peut être échangée contre $frac(1 + i_t, 1 + pi_(t + 1))$ unités demain

// - c’est plus avantageux lorsque le taux d’intérêt nominal est élevé
// - c’est moins avantageux lorsque l’inflation est élevée

// == Taux d’Intérêt Réel

// Le #strong[taux d’intérêt réel] $r_t$ est défini par :

// $ #box(stroke: black, inset: 3pt, [$ 1 + r_t = frac(1 + i_t, 1 + pi_(t + 1)) $]) $

// Il mesure à quel point il est bénéfique d’échanger des biens de consommation actuels contre des biens de consommation futurs.

// En logarithmes:

// $ #box(stroke: black, inset: 3pt, [$ r_t = i_t - pi_(t + 1) $]) $

// Cette relation est parfois appelée l’#strong[équation de Fisher];.

// #slide[


// #place(center, image("assets/check.jpg"))

// ][
// ==== Quizz 1

// Supposons que le taux d’intérêt nominal soit de 4% et l’inflation de 5%. Quel est le taux d’intérêt réel (en pourcentage) ?

// + 1
// + -1
// + 4/5
// + 5/6
// ]

// ==== Quizz 2

// L’effet fishérien est la tendance de l’inflation à augmenter et à annuler toute hausse des taux nominaux par la banque centrale. Cela est plus susceptible de se produire si :

// + le taux réel est indépendant des variables nominales
// + les prix sont rigides
// + l’inflation est élevée
// + la dette est élevée

// …

// ]

= Les Consommateurs

== Decisions de consommation
#columns(2, [

  #only("1")[
    #box(image("assets/why_do_save_today.png", height: 50%))
  ]

  #only("2,3")[
    #box(image("assets/why_do_save.png", height: 50%))
  ]
  #only("4-")[
    #box(image("assets/why_do_save_r.png", height: 50%))
  ]

  #colbreak()


  Pourquoi les consommateurs épargnent-ils ?

  #pause

  - Pour substituer les biens présents par les biens futurs.

  #pause

  Qu’est-ce qui détermine la substitution ?

  #pause

  - Le taux d’intérêt (réel)


])

#pause

Qu’est-ce qui détermine également la substitution ?

#pause

- Le revenu aujourd’hui et demain

#pause

Quoi d'autre ?

- Le risque
- L'âge, la situation professionnelle, conjugale, l'état de santé, ...


== Décisions de consommation

=== Intuition

Selon leurs préférences, le montant que les consommateurs décident de dépenser est déterminé par :

- Leur revenu aujourd’hui ( $Y_t$ )
- Leur revenu attendu dans le futur ( $Y_(t + 1) , Y_(t + 2) , . . .$ )


Étant donné leur profil de revenu attendu, la décision de consommer peut être vue comme un arbitrage entre la consommation aujourd’hui et la consommation demain.

Cet arbitrage dépend du taux d’intérêt intertemporel réel ( $r_t$ ).

Les deux déterminants à court terme de la consommation devraient donc être $Y_t$ et $r_t$.

☞ Vérifions le avec un modèle formalisé

== Consommateurs ricardiens et keynésiens

Dans ce cours on distingue :

#columns(2, [

  #strong[Ménages Ricardiens]

  Des agents qui peuvent librement réaffecter la consommation intertemporelle.

  Les ménages Ricardiens choisissent de ne pas consommer davantage aujourd’hui, afin de consommer davantage demain.

  #colbreak()

  #strong[Ménages Keynésiens]

  Des agents dont la consommation est limitée par une contrainte de crédit contraignante.

  Soit ils ne peuvent pas du tout emprunter, soit le montant qu’ils peuvent emprunter est limité.

  Les ménages Keynésiens consomment aujourd’hui autant qu’ils le peuvent.])


Nous étudierons les deux types d’agents tour à tour, en commençant par les agents Ricardiens.



== Consommateurs Ricardiens

=== Consommateurs Ricardiens

Modélisons le choix intertemporel d’un ménage Ricardien. Ce sont des décideurs rationnels, mais ils ont une préférence pour le présent. Pour des raisons d’exposition, nous supposons qu’ils vivent seulement pendant deux périodes.

Désignons par $C_1$ and $C_2$ la consommation aujourd’hui et demain.

Un consommateur ricardien maximise : $ U (C_1 , C_2) = log (C_1) + beta log (C_2) $

où $beta < 1$ est un facteur d’actualisation, indiquant que la consommation aujourd’hui est préférée. $beta$ est généralement proche de 1.

Cette optimisation n’est pas libre, elle est soumise à une contrainte budgétaire.


== Consommateurs Ricardiens

=== Détermination de la contrainte budgétaire

Notons $P_1 = 1$ le niveau actuel des prix, et $P_2$ le niveau futur.

Notons $P_1 Y_1$ le revenu nominal présent et $P_2 Y_2$ le revenu nominal futur.

On suppose que notre consommateur consomme $C_1$ au prix $P_1$ pour un montant $C_1 P_1$

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

Dans le #emph[côté gauche] : $(1 + r)$ peut être interprété comme le _prix_ de consommer aujourd'hui.

#pause
Quel est l’effet d’un taux d’intérêt réel plus élevé ?

- La consommation aujourd’hui est plus chère : *effet de substitution*
  - plus de consommation de biens futurs, moins de consommation dans le présent
- Le revenu d’aujourd’hui vaut plus : il allège la contrainte budgétaire créant un *effet de richesse*
  - plus de consommation des deux biens

== Consommateurs
<consommateurs-3>
Un consommateur résout $ max_(C_1 , C_2) &&                             U (C_1 , C_2) \
     s. c. "  " && C_1 (1 + r) + C_2 lt.eq Y_1 (1 + r) + Y_2 $

Il s’agit d’un problème d’optimisation sous contrainte, identique à ceux rencontrés en microéconomie.

On obtient facilement la consommation optimale (consommation souhaitée) en période $1$:

$ #box(stroke: black, inset: 3pt, [$ C_1 = frac(1, 1 + beta) (Y_1 + frac(1, 1 + r) Y_2) $]) $

== Ménages Ricardiens
<ménages-ricardiens>
Comment interprétons-nous cette formule optimale ? $ C_1 = frac(1, 1 + beta) underbrace((Y_1 + frac(1, 1 + r) Y_2), upright("Revenu Permanent")) $

Le revenu permanent est la valeur actualisée de tous les revenus perçus par le consommateur sur son horizon d’optimisation. #footnote[Cette formule est similaire à la formule pour la valeur présente d'une entreprise: $"VP" = sum_(t=0)^(infinity) (1/(1+r))^t d_t$ où $d_t$ représente le dividende perçu à la date $t$.]

Un ménage Ricardien dépense en période 1, une fraction de son *revenu permanent*.

Cela découle d’un motif de *lissage de la consommation* dans le temps, qui provient de la concavité de la fonction d’utilité.

== Réponse au taux d’intérêt
<réponse-au-taux-dintérêt>
À partir de la dernière formule, nous pouvons voir comment les ménages Ricardiens modifient leur consommation de $Delta C$ en réponse à un changement $Delta r$ dans les taux d’intérêt réel : $ C_1 + Delta C = frac(1, 1 + beta) (Y_1 + frac(1, 1 + r + Delta r) Y_2) $

Cela conduit à la formule approchée :

$ #box(stroke: black, inset: 3pt, [$ frac(Delta C, Delta r) = - frac(1, 1 + beta) 1 / (1 + r)^2 Y_2 $]) $

En accord avec l’intuition : la consommation aujourd’hui est plus faible lorsque le taux d’intérêt réel est plus élevé.

== Choc de revenu temporaire
<choc-de-revenu-temporaire>
Comment réagissent les ménages Ricardiens aux chocs de revenu ?

Supposons que le revenu augmente temporairement (en période $1$) de $Delta Y$. Alors la consommation augmente de $Delta C$ de telle sorte que : $ C_1 + Delta C = frac(1, 1 + beta) underbrace((Y_1 + Delta Y + frac(1, 1 + r) Y_2), upright("Revenu Permanent")) $

Nous obtenons une propension marginale à consommer (à partir d’un choc temporaire) égale à :

$ "PMC" C^(upright("ricardian")) = frac(Delta C, Delta Y) = frac(1, 1 + beta) < < 1 $

== Ménages ricardiens

=== Remarques sur la modélisation

- Le fait que le consommateur consomme à chaque date une fraction fixe de sa consommation provient de la specification log pour l'utilité instantanée:
  - avec une spécification CRRA#footnote[CRRA: Constant risk aversion]  $ U(C_1,C_2) = (C_1)^(1-1/sigma)/(1-1/sigma) + beta (C_2)^(1-1/sigma)/(1-1/sigma) $ le résultat serait différent
  - comme en micro, $sigma$ paramétrise l'élasiticité de la consommation future à la consommation presente (aussi appelée élasticité intertemporelle de substitution)
#pagebreak()
- D'après la formule $ C_1 = frac(1, 1 + beta) (Y_1 + frac(1, 1 + r) Y_2) $ le ménage consomme à peu près la moitié de son revenu permanent en période 1 ($beta approx 1$)
- si l'objectif était spécifié avec un horizon infini $max sum_t beta^t log(C_t)$ on aurait
  $ C_1 = (1 - beta) (underbrace(Y_1 + frac(1, 1 + r) Y_2 + frac(1, (1 + r)^2)Y_3 + ..., "Revenu Permanent")) $
  - le consommateur consomme toujours une fraction fixe de son revenu permanent
  - sous l'hypothèse $1/beta=(1+r)$ il consomme les intérêts du revenu permanent

- Le modèle présenté est *déterministe*
- On aurait pu considérer que la valeur du revenu en deuxième période $Y_2$ était *stochastique* $Y_2~>cal(D)$ où $cal(D)$ est une distibution connue...
  - et maximiser l'utilité espérée $EE U(C_1, C_2) = log(C_1) + beta EE[ log(C_2) ]$
  - on verrait #footnote[C'est le sujet de la PC1.] que la concavité de l'utilité crée une *aversion au risque* et de l'*épargne de précaution*

#pagebreak()

- On pourrait aussi considérer un cas plus général: $ max EE_t [sum_(s>=t) beta^s (c_s)^(1-sigma)/(1-sigma)] $
  - qui cumulerait tous les effets

- C'est le modèle standard en macroéconomie formalisée


== Ménages Keynésiens

Intrinsèquement, les agents keynésiens ont les mêmes préférences en matière de consommation que les ménages ricardiens.

Idéalement, ils aimeraient dépenser une fraction de leur revenu permanent, mais ils sont confrontés à une limite quant à la somme qu’ils peuvent emprunter.

// #image("assets/../bank_no.jpg", width: 0.52083333333333in)

Un agent keynésien pur (qui ne peut pas emprunter du tout) est soumis à la contrainte simple $C_1 lt.eq Y_1$ et puisqu'il consomme autant que possible, sa consommation est simplement : $ C_1 = Y_1 $

Sa propension marginale à consommer est :

$ "PMC"^(upright("keynésien")) = partial(C_1)/(partial Y_1)= 1 $

==== Quiz
<quiz>
Parmi les agents suivants, lequel est le plus susceptible d’être keynésien ?

+ un étudiant qui envisage une offre de prêt de la banque pour couvrir les frais universitaires
+ un ménage de classe moyenne réduisant les dépenses alimentaires pour rembourser un prêt en cours
+ un travailleur à faible revenu aux États-Unis, qui n’a pas de carte de crédit
+ un trader boursier

== Consommation Agrégée
<consommation-agrégée>
Pour connaître le comportement de la consommation agrégée, en particulier la propension marginale à consommer agrégée, nous devons connaître la proportion de ménages ricardiens et keynésiens.
Ce sera le thème de la  PC2. #footnote[En particulier vous verrez que le comportement de la consommation agrégée dépend crucialement de la nature redistributive des chocs.]

#columns([

  #block[
    #block[
      #figure(
        [
          #box(image("assets/keynesian_dog.png", width: 40%))
        ],
        caption: figure.caption(
          position: bottom,
          [
            Un chien keynésien, lors de la récession de 1929
          ],
        ),
        kind: "quarto-float-fig",
        supplement: "Figure",
      )


    ]
    #block[
      #figure(
        [
          #box(image("assets/ricardian_cat.png", width: 40%))
        ],
        caption: figure.caption(
          position: bottom,
          [
            Un chat ricardien, jouant avec de l’argent.
          ],
        ),
        kind: "quarto-float-fig",
        supplement: "Figure",
      )
    ]
  ]


])


== À suivre


Prochaines étapes:

- PC
  - modéliser l'arbitrage intertemporel des consommateurs
- Amphi:
  - comment réagissent les autres acteurs au taux d'intérêt au niveau de revenu
  - comment conceptualiser la notion de demande au niveau macroéconomique
