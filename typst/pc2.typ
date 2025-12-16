#import "pc_template.typ": pc, correction

#let correct = sys.inputs.at("correct", default: "false") == "true"

#show: doc => pc(
  2,
  [La croix keynésienne],
  doc,
  correct: correct
)

#let correction = correction.with(visible: correct)

== Exercice 1: agents ricardiens et keynésiens.

<exercice-1-agents-ricardiens-et-keynesiens>
+ Commenter brièvement les graphes suivants#footnote[Les deux premiers graphes sont tirés de #underline[Fiscal Policy and MPC Heterogeneity], Tullio Jappelli et Luigi Pistaferri, American Economic Journal: Macroeconomics, 2014, les deux derniers d'#underline[Une brève histoire de l'égalité], Thomas Piketty, éditions du seuil.];. Quelle explication proposeriez-vous pour les ménages dont la PMC est égale à 50%?


#figure(
  grid(columns: 2, row-gutter: 2mm, column-gutter: 1mm,
      image("pc2_assets/mpc_1.png", width: 90%),
      image("pc2_assets/mpc_2.png", width: 90%),
      "PMC  (Autodéclarée) en Réponse à un\n Choc de Revenu Temporaire",
      "PMC Moyenne par Percentiles de Trésorerie",
      image("pc2_assets/mpc_3.png", width: 90%),
      image("pc2_assets/mpc_4.png", width: 90%),
      "Distribution de la Richesse",
      "Décomposition de la Richesse"
  ),

)

#correction[

Dans le premier graphe on note que la proportion d'agent ricardiens (dont la PMC est proche de zero) est sensiblement égale à celle des agents keynésiens (PMC proche de un). Cela dit, on remarque que toutes les valeurs intermédiaires sont présentes, notamment celle de 0.5. Ces valeurs sont à priori incompatibles avec un modèle d'optimisation intertemporelle sans risque. Comment peut-on les interpéter? Sans exclusive, on peut avancer les explications suivantes:
  - certains agents ne sont pas rationnels: ils suivent des règles de consommation (rule of thumb). C'est particulièrement plausible pour la valeur de 50%.
  - la propension à consommer est une fonction continue de l'épargne de précaution. Elle est fonction des contraintes de crédit (voir question suivante) et du revenu disponible (graphes 2 et 3) qui a une distribution continue.


]
\

#set enum(numbering: "1.", start: 2)

+ En utilisant le dernier graphique justifier l'expression de "Wealthy Hand to Mouth"#footnote[Les "Wealthy Hand to Mouth" on été mis en évidence dans l'article #underline[Monetary Policy According to HANK] de Kaplan, Moll and Violante dans American Economic Review, 2018] pour les ménages dont la PMC est non-nulle alors qu'ils disposent d'une richesse financière importante.

#correction[

Le graphe 3 montre l'importance de l'inégalité de la distribution de richesse. Sur le dernier on note l'existence d'une catégorie d'agents, dont la richesse est en grande partie une richesse immobilière. Concrètement il s'agit d'agents, dont le remboursement du crédit représente une part importante du revenu. Qui peuvent donc facilement être contraints de consommer moins si leur revenu baisse. Dans le cas extrême où cette correspondance s'opère un pour un, on les appelle "wealthy hand to mouth". Sinon, en général, ces agents consomment seulement une fraction de leur revenu additionnel de façon à se couvrir contre une perte potentielle de revenu.

]

== Exercice 2: la croix keynésienne

<exercice-2-la-croix-keynésienne>
On considère une économie simplifiée où l'équilibre dépend de la production totale $Y$ et du taux d'intérêt #emph[réel] $r$. Il s'agit d'un modèle de court terme de sorte que l'on omet les indices temporels. Tout au long de cet exercice, nous supposons que les prix sont fixes \(nous faisons donc abstraction de l'offre agrégée). Les composantes de la demande agrégée sont:

- la consommation totale des ménages: $C = C (Y , r)$
- l'investissement total des entreprises: $I = I (r)$
- les dépenses gouvernementales $G$ choisies de manière exogène par le gouvernement $G$

=== La croix keynésienne
<la-croix-keynésienne>

#set enum(numbering: "1.", start: 1)

+ Écrire la relation définissant l'équilibre sur le marché des biens à l'état stationnaire $(overline(Y) , overline(r))$. Justifier brièvement, sans calcul, le signe des dérivées $C_Y^prime (overline(Y) , overline(r))$, $C_r^prime (overline(Y) , overline(r))$ et $I^prime (overline(r))$.

#correction[

La relation d'équilibre sur le marché des biens est: $ overline(Y) = C (overline(Y) , overline(r)) + I (overline(r)) + G $

Le coefficient $C_Y^(')$ représente la propension marginale à consommer. Il est compris entre 0 (pour les agents ricardiens) et 1 pour les agents keynésiens. Lorsque le taux d'intérêt augmente les consommateurs ont tendance à épargner plus, donc consommer moins d'où $C_r^(') < 0$. De même, il est dans ce cas plus coûteux pour les firmes d'emprunter pour investir, d'où $I_r^(') < 0$.

Nous analysons la détermination de l'équilibre au moyen d'un graphique (diagramme à 45 degrés, aussi appelé croix keynésienne): la demande est représentée sur l'axe vertical et la production est représentée sur l'axe horizontal. La production d'équilibre est donnée par l'égalité entre la production et la demande.

#figure([
#box(image("pc2_assets/cross.png", width: 40%))
], caption: figure.caption(
position: bottom, 
[
Croix Keynésienne
]), 
)
]


#set enum(numbering: "1.", start: 2)
+ On suppose maintenant que le gouvernement augmente ses dépenses d'une quantité infinitésimale $Delta G$ sans effet sur les taux d'intérêt. Quelle est l'augmentation $Delta Y$ de la production d'équilibre ? Calculer le multiplicateur fiscal $frac(Delta Y, Delta G)$. Représenter cette augmentation sur le diagramme à 45 degrés.

#correction[

Si l'on différencie la relation d'équilibre, on obtient:

$ Delta Y = C_Y^(') Delta Y + Delta G $

soit

$ Delta Y = frac(1, 1 - C_Y) Delta G $

d'où l'on obtient le multiplicateur fiscal:

$ frac(Delta Y, Delta G) = frac(1, 1 - C_Y) $

Les dépenses du gouvernement étant la part autonome des dépenses supplémentaires, on peut aussi écrire:

$ Delta Y = underbrace(Delta G, upright("Dépense autonome")) + underbrace((frac(C_Y, 1 - C_Y)) Delta G, upright("Dépense induite")) $

#figure([
#box(image("pc2_assets/cross2.png", width: 40%))
], caption: figure.caption(
position: bottom, 
[
Effet des dépenses gouvernementales
]), 
)




]

#set enum(numbering: "1.", start: 3)
+ Dans la question précédente, on n'a pas précisé comment était financée la dépense supplémentaire \(peut-être par un emprunt remboursé dans le futur). On suppose maintenant que le gouvernement impose une taxe forfaitaire $Delta T$ sur le revenu des ménages pour financer ses dépenses \($Delta T = Delta G$). Avec ces taxes, la consommation totale des ménages est une fonction du revenu disponible $C = C (Y - Delta T , r)$. De combien augmente la production d'équilibre et quel est le nouveau multiplicateur fiscal? Comment interpréter le résultat?


#correction[

Puisque les dépenses sont financées par des taxes $Delta T = Delta G$, on écrit maintenant:

$ overline(Y) + Delta Y = C (overline(Y) + Delta Y - Delta G , overline(r)) + I (overline(r)) + G + Delta G $

ce qui donne

$ Delta Y = C_Y (Delta Y - Delta G) + Delta G $

On en déduit (en supposant $C_Y eq.not 1$), $Delta Y = Delta G$. Cela est surprenant à première vue : le gouvernement réussit à augmenter la demande sans s'endetter. On peut comprendre le resultat en voyant que la taxe revient à transférer des revenus d'un agent (le consommateur) vers un autre (l'état) dont la propension marginale à consommer est plus élevée. Cela dit 1/le modèle implique que la production ne dépend que de la demande ce qui est irréaliste 2/ sur le moyen terme, maximmiser la demande n'est pas optimal donc il ne faut pas surinterpréter le modèle

]

#set enum(numbering: "1.", start: 4)
+ Calculer et représenter sur un graphe du même type l'effet d'une baisse des taux d'intérêt nominaux en supposant que les prix sont fixes à court terme.

#correction[


On rappelle la relation de Fisher $r = i - pi$. Si les prix sont rigides $pi = 0$ l'augmentation des taux nominaux est équivalente à la même augmentation des taux réels.

Cette fois, différencier la relation d'équilibre donne:

$ Delta Y = C_Y^(') Delta Y + C_r^(') Delta r + I_r^(') Delta r $

d'où l'augmentation de la production demandée:

$ frac(Delta Y, Delta r) = frac(C_r^(') + I_r^('), 1 - C_Y^(')) $

que l'on peut aussi décomposer comme suit:

$ frac(Delta Y, Delta r) = underbrace((C_r^(') + I_r^(')), upright("effet direct")) + underbrace((C_r^(') + I_r^(')) frac(C_Y^('), 1 - C_Y^(')), upright("effet induit")) $

]

=== Agents hétérogènes
<agents-hétérogènes>
On suppose maintenant que les agents sont répartis en 2 groupes: les agents de type $H$ \(hand-to-mouth), pour une fraction $lambda$, et les agents de type $S$ \(savers) pour une fraction $1 - lambda$. Les agents $H$ n'ont pas accès aux marchés financiers et tous leurs revenus proviennent du travail. Les agents $S$ \(pour savers) peuvent lisser leur consommation par l'epargne. Ces derniers recoivent en plus de leur travail, les revenus du capital et les profits des firmes. Les différent revenus seront définis plus bas.

#set enum(numbering: "1.", start: 5)

+ On suppose que les fonctions de consommation des deux groupes sont données par: où $overline(Y_H)$ \(resp $overline(Y_S)$) est le revenu perçu à l'équilibre par les agents $H$ \(resp $S$)

#correction[

On a déjà vu en cours pourquoi $c_Y^H approx 1$ (ménages keynésiens) et on a parlé des ménages ricardiens pour lesquels $c_H^Y approx 0$. On aura mentionné l'arbitrage consommation travail sans faire de calcul.

- Un ménage ricardien place son revenu pour le transformer en revenu permanent et essentiellement en consommer les intérêts à chaque période.
- Un ménage keynésien consomme tout ce qu'il peut. S'il reçoit un revenu additionnel ce revenu sera donc consommé intégralement.

Pour calculer la propension marginale à consommer agrégée, il manque une information sur la façon dont le revenu marginal est distribué.

]
#set enum(numbering: "1.", start: 6)

+ Justifier #emph[intuitivement] les hypothèses sur $c_Y^H$ et $c_Y^S$. A-t-on assez d'informations pour calculer la propension marginale à consommer agrégée#footnote[La propension marginale à consommer agrégée est l'augmentation de la consommation prévue totale, lorsque le revenu total augmente d'une unité.] comme dans la question 1?

On fait maintenant les hypothèses suivantes sur la répartition du revenu total:

- tous les agents travaillent au même salaire $W$
- une fraction $alpha_L$ des revenus totaux revient aux travailleurs, une fraction $alpha_K$ aux détenteurs du capital et une fraction $alpha_pi$ est payée sous forme de profits au détenteurs des firmes. On a bien sûr $alpha_L + alpha_K + alpha_pi = 1$
- le gouvernements taxe les profits et les revenus du capital à un taux $tau$, pour les redistribuer aux agents $H$

#set enum(numbering: "1.", start: 7)
+ Calculer la propension marginale à consommer agrégée. Peut-elle être plus grande que 1? Quel est le multiplicateur fiscal?

#correction[


Les revenus du travail sont $alpha_L Y$. Les revenus du capital sont $(alpha_K + alpha_Pi) Y$.
Regardons comment se répartissent les dépenses prévues en réponse à une augmentation du revenu agrégé $Delta Y$.Comme le salaire est le même pour tout le monde, le revenu du travail des agents H augmente de $alpha_L lambda Delta Y$. Ils reçoivent en plus les transferts $tau (alpha_K + alpha_Pi) Delta Y$ de sorte que leur propension marginale à consommer en fonction du revenu 'total' est $ frac(Delta C^H, Delta Y) = c_Y^H (alpha_L lambda + tau (alpha_K + alpha_pi)) $
De la même façon celle des agents $S$ est:

$ frac(Delta C^S, Delta Y) = c_Y^S (alpha_L (1 - lambda) + (1 - tau) (alpha_K + alpha_pi)) $

La propension marginale à consommer totale est donc: .

On voit que la propension marginale à consommer croît logiquement avec la proportion $lambda$ d'agents keynésiens et avec le degré de répartition des profits $tau$. En supposant à l'extrême que $lambda$ est proche de 1, pour que la MPC soit plus grande que 1, il faudrait avoir: $tau gt.eq frac(1 - alpha_L, alpha_K + alpha_pi) = 1$ ce qui est impossible.

Considérons maintenant un choc $Delta G$ sur les dépenses gouvernementales, associé à une modification du revenu $Delta Y$. L'equation du PIB donne $Delta Y = frac(Delta C^S, Delta Y) Delta Y + frac(Delta C^H, Delta Y) Delta Y + Delta G$ d'où le multiplicateur fiscal $frac(Delta Y, Delta G) = frac(1, 1 - frac(Delta C^S, Delta Y) - frac(Delta C^H, Delta Y)) = frac(1, 1 - (alpha_L lambda + tau (alpha_K + alpha_pi)))$ c'est à dire la même formule que dans la question 2 avec une formule spécifique pour la propension marginale à consommer agrégée. #footnote[Notons que si l'on considérait ici une dépense financée par des taxes comme à la question 3, la réponse dépendrait de la nature du choc de taxation, plus précisément de quels ménages sont mis à contribution pour financer les dépenses.]

]