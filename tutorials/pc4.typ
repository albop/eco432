#import "pc_template.typ": pc, correction

#let correct = false
#show: doc => pc(
  4,
  [Offre et Demande à court terme],
  doc,
  correct: correct
)

#let correction = correction.with(visible: correct)


== Exercice 1: Macroéconomie de court terme
<exercice-2-macroéconomie-de-court-terme>
Trouver l’unique bonne réponse aux questions suivantes, en raisonnant dans le cadre du modèle AS/AD.

#block[
#set enum(numbering: "1.", start: 1)
+ La demande agrégée est une fonction décroissante de l’inflation. Choisissez la justification qui correspond le mieux au modèle AS/AD vu en cours :

  #block[
  #set enum(numbering: "a.", start: 1)
  + Une inflation plus élevée correspond à des taux d’intérêt réels plus élevés, ce qui correspond à des rendements de l'épargne plus élevés et donc à des investissements plus élevés. L’augmentation des investissement augmente finalement la production et la consommation.
  + Lorsque l’inflation est plus élevée, la réaction de la banque centrale implique une hausse des taux réels qui incite les consommateurs ricardiens à diminuer leurs dépenses et les entreprises à reporter leurs investissements. La demande diminuée des ménages ricardiens et des entreprises induit également les ménages keynésiens à consommer moins.
  + Une inflation plus élevée correspond à des taux d’intérêt nominaux plus élevés, ce qui correspond à des rendements de l’épargne plus élevés et donc à des investissements plus élevés. Un investissement plus élevé augmente finalement la production et la consommation.
  + Une fonction de demande est décroissante par définition.
  ]
]

#correction[

a. _faux_. Une inflation plus élevéec correspond à un taux réel plus *bas*

b. _vrai_. C'est exactement ça. Notons bien que si la banque centrale de réagissait pas, une hausse de l'inflation baisserait les taux réels.

c. _faux_. D'une part l'épargne est déterminée par les taux réels, pas nominaux. D' autre part la hausse des taux provoque une baisse de la production.

d. _faux_. La demande agrégée n'est pas une fonction de demande normale. Il s'agit de l'équilibre implicite qui provient de la courbe IS.

]

#block[
#set enum(numbering: "1.", start: 2)
+ La courbe d’offre agrégée est croissante parce que (choisissez la meilleure justification) :

  #block[
  #set enum(numbering: "a.", start: 1)
  + Les courbes d’offre sont croissantes sur tous les micro-marchés.
  + Les courbes d’offre sont toujours ascendantes.
  + Des prix plus élevés permettent aux entreprises monopolistiques de réduire leur production.
  + Un niveau de prix plus élevé incite les entreprises qui ne peuvent pas ajuster leur propre prix à augmenter la production.
  ]
]

#correction[

a. _faux_. L'offre agréegée  peut conceptuellement être verticale, même si les marchés de chacun des biens à une pente d'offre normalement pentue.

b. _faux_. L'offre agrégée n'est pas une fonction d'offre normale normale. 

c. _faux_. Une entreprise monopolistique peut décider de réduire sa production en augmentant le prix. Mais l'inverse n'a pas de sens car le prix est une variable de décision de la firme. La même explication tient pour les firmes monopolistiques.

d. _vrai_. C'est le mécanisme qui fait que la production de certaines firmes augmentent lorsque la demande augmente, au lieu que ce soient seulement les prix qui servent de valeur d'ajustement. On a vu que l' intuition reste vraie quand une fraction seulement des firmes peut ajuster.

]


#block[
#set enum(numbering: "1.", start: 3)
+ Trouvez la bonne déclaration :

  #block[
  #set enum(numbering: "a.", start: 1)
  + Les pays avec des marges plus basses ont des marchés plus concurrentiels.
  + Les pays où les marchés sont plus compétitifs ont une croissance plus élevée.
  + Des marges moyennes plus élevées signifient des prix plus flexibles.
  + La marge d’une entreprise en concurrence monopolistique dépend uniquement de son coût marginal.
  ]
]

#correction[

a. _vrai_

b. _non_, ce n' est pas si simple. On a vu que la concurrence est moins forte aux États-Unis, mais la croissance y est aussi plus forte qu'en France.

c. _non_

d. _non_. le lien entre coût marginal, marge et prix est de la forme $p = (1+mu) "mc"$. La marge $mu$ dépend de l'élasticité de la demande qui elle-même dépend de l' environnement compétitif.

]

#block[
#set enum(numbering: "1.", start: 4)
+ Après un choc négatif d’offre :

  #block[
  #set enum(numbering: "a.", start: 1)
  + Les achats gouvernementaux peuvent atténuer l’effet sur le chômage.
  + La banque centrale ne peut rien faire car c’est un choc réel.
  + L’économie restera en déséquilibre jusqu’à ce que le gouvernement ou la banque centrale intervienne.
  + Les entreprises devraient changer de fournisseurs.
  ]
]

#correction[

a. _oui_ le gouvernemnt peut en effet augmenter la demande en augmentant les dépense. Cela stabilise le chômage au prix d'une inflation plus haute

b. _non_, la banque centrale peut accomoder le choc, en déplacer la demande de manière à neutraliser son effet sur la production et/où l'inflation

c. _non_, s'il n' est pas persistent l'effet du choc se résorbe de lui-même à mesure que les prix s'ajustent

d. _non_, pas de rapport

] 

#block[
#set enum(numbering: "1.", start: 5)
+ Lequel des cas suivants est un choc négatif de demande ?

  #block[
  #set enum(numbering: "a.", start: 1)
  + Les déboires des sous-traitants de Boeing poussent la société à importer des moteurs allemands et italiens à la place des moteurs Pratt & Whitney
  + La fin de la Covid-19 provoque une hausse de l’optimisme des consommateurs.
  + Les réglementations en matière de crédit sont mises à jour pour limiter le surendettement
  + Un nouveau type de poussette électrique bon marché devient un must-have pour tous les passionnés de mode urbaine.
  ]
]

#correction[
  
  a. _faux_. cela augmente la demande étrangère pour la production domestique. C'est un choc de demande positif.

b. _faux_. les consommateurs plus optimistes pensent que leur consommation va augmenter dans le future. Pour lisser leur consommation dans le temps, ils augmentent donc leur consommation présente. (l'optimisme peut-aussi réduire leur perception du risque future et leur besoin d'une épargne de précaution, avec le même effet)

c. _vrai_. la réglementation sur le surendettement empêche certains ménages de s'endetter pour consommer donc c'est un choc de demande négatif (même s'il peut être désirable)

d. _faux_. L'évolution des préférences entraîne une demande des consommateurs pour ce type de produit. C'est un choc de demande positif.

]

#block[
#set enum(numbering: "1.", start: 6)
+ Lequel des événements suivants est un choc d’offre positif:
  #block[
  #set enum(numbering: "a.", start: 1)
  + les prix mondiaux du pétrole augmentent à cause de la guerre en Ukraine
  + pour atteindre l’objectif "zéros émissions in 2030", les entreprises sont encouragées à éviter les énergies fossiles
  + le gouvernment met en place une subventions pour les entreprises qui investissent dans les technologies vertes
  + comme les voitures à essences sont interdites de circulation dans les grandes villes, les consommateurs achètent des voitures électriques
  ]
]

#correction[

d. _faux_. choc d'offre négatif

b. _faux_. c'est équivalent à un renchérissement du prix des énergies fossiles donc à un choc d'offre négatif

a. _vrai_. sans que le prix des autres énergie soient affectées, la production de technologies vertes est moins chère. C'est un choc d'offre positif.

c. _faux_. un choc de demande positif pour les voitures électrique


]

#block[
#set enum(numbering: "1.", start: 7)
+ Selon la version NK du modèle AS/AD vue pendant le cours, laquelle des déclarations suivantes est vraie :

  #block[
  #set enum(numbering: "a.", start: 1)
  + Après un choc de demande temporaire, les prix augmentent, puis diminuent pour revenir à leur niveau initial.
  + Un choc de demande positif persistant affecte l’écart de production, uniquement jusqu’à ce que tous les prix aient été ajustés.
  + Tout choc de demande induit une réponse d’offre opposée qui annulera finalement ses effets à long terme.
  + Les politiques de demande sont plus efficaces lorsque les prix sont plus flexibles.
  ]
]

#correction[

a. _Non_. les prix augmentent mais ne baisse pas. L'inflation elle redescend à son niveau initial.

b. _Oui_. cf cours.

c. _Non_. L'économie se déplace le long de la courbe 
d'offre de cours terme mais ce n'est pas un choc.

d. _Non_. Les politiques de demande sont plus efficaces lorsque les prix sont *moins* flexible.


]

== Exercice 2: choc pétrolier et stagflation
<exercice-1-choc-pétrolier-et-stagflation>

Dans le graphique ci-joint, l’économie est à l’équilibre macroéconomique de long terme (initialement au point $E_0$), lorsqu'un choc pétrolier déplace la courbe d’offre globale (de court terme) vers la gauche.#footnote[Notons que l’équilibre initial se situe à l’intersection des courbes AD at AS mais aussi AD et LRAS: l’équilibre de court terme correspond à l’équilibre de long terme.] Répondez aux questions suivantes à partir du graphique:

#figure([
#box(image("pc4_assets/as_choc_petrolier.png"))
], caption: figure.caption(
position: bottom, 
[
Choc Pétrolier
]), 
kind: "quarto-float-fig", 
supplement: "Figure", 
)


#block[
#set enum(numbering: "1.", start: 1)
+ Comment varient à court terme l'inflation et le PIB en conséquence du choc pétrolier ? Comment appelle-t-on ce phénomène ?
]

#correction[
Le choc d’oﬀre est un shift de la courbe d’oﬀre de court terme vers la gauche. A court terme
l’équilibre se déplace vers 𝐸1 . Il y a simultanément une baisse du pib (augmentation du chômage) et une hausse du l’inﬂation. Cette situation est appelée stagflation.
]

#block[
#set enum(numbering: "1.", start: 2)
+ Quelle politique budgétaire ou monétaire le gouvernement peut-il utiliser pour gérer les effets du choc d’offre ? Montrez graphiquement les effets des politiques choisies pour gérer la variation du PIB réel. Montrez sur un autre graphique les effets des politiques choisies pour stabiliser l’inflation.
]


#correction[


  #figure(
    image("pc4_assets/as_choc_petrolier_2.png"),
    caption: "Choc-Pétrolier - Politique Accomodante"

  )

A court terme, il n'est pas possible d'influer sur la courbe d'offre. Mais on peut contrer l'effet sur le chômage en stimulant la demande. On parle alors de politique *accomodante* (on accommode le choc d'offre).

Pour stimuler la demande, la banque centrale peut baisser les taux d'intérêt (hors réaction normale à l' inflation déjà intégrée à la courbe de demande). Le gouvernement peut aussi augmenter ses dépenses. Dans les deux cas, la situation est représentée par le premier graphique.

A l'inverse si la banque centrale n'est préoccupée que par l'inflation elle peut la stabiliser complètement en augmentant les taux pour diminuer la demande au prix d'une augmentation du chômage. C'est la situation sur le deuxième graphique.



  #figure(
    image("pc4_assets/as_choc_petrolier_3.png"),
    caption: "Choc Pétrolier - Stabilisation de l'inflation"

  )

]


#block[
#set enum(numbering: "1.", start: 3)
+ En quoi le choc d'offre présente-t-il un dilemme pour les décideurs ?
]

#correction[

Dans ce contexte, il n’est pas possible de réduire en même temps l’inﬂation et le chômage ; les décideurs doivent arbitrer entre les deux.

]