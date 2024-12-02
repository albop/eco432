#import "pc_template.typ": pc

#show: doc => pc(
  2,
  [La croix keynésienne],
  doc,
)


== Exercice 1: agents ricardiens et keynesiens.

<exercice-1-agents-ricardiens-et-keynesiens>
+ Commenter brièvement les graphes suivants#footnote[Les deux premiers graphes sont tirés de Fiscal Policy and MPC Heterogeneity, Tullio Jappelli et Luigi Pistaferri, American Economic Journal: Macroeconomics, 2014, les deux derniers d’"Une brève histoire de l’égalité", Thomas Piketty, éditions du seuil.];. Quelle explication proposeriez-vous pour les ménages dont la PMC est égale à 50%?
+ En utilisant le dernier graphique justifier l’expression de "Wealthy Hand to Mouth"#footnote[Les "Wealthy Hand to Mouth" on été mis en évidence dans l’article Monetary Policy According to HANKde Kaplan, Moll and Violante dans American Economic Review, 2018] pour les ménages dont la PMC est non-nulle alors qu’ils disposent d’une richesse financière importante.

\

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

\


== Exercice 2: la croix keynésienne

<exercice-2-la-croix-keynésienne>
On considère une économie simplifiée où l’équilibre dépend de la production totale $Y$ et du taux d’intérêt #emph[réel] $r$. Il s’agit d’un modèle de court terme de sorte que l’on omet les indices temporels. Tout au long de cet exercice, nous supposons que les prix sont fixes \(nous faisons donc abstraction de l’offre agrégée). Les composantes de la demande agrégée sont:

- la consommation totale des ménages: $C = C (Y , r)$
- l’investissement total des entreprises: $I = I (r)$
- les dépenses gouvernementales $G$ choisies de manière exogène par le gouvernement $G$

=== La croix keynésienne
<la-croix-keynésienne>
+ Écrire la relation définissant l’équilibre sur le marché des biens à l’état stationnaire $(overline(Y) , overline(r))$. Justifier brièvement, sans calcul, le signe des dérivées $C_Y^prime (overline(Y) , overline(r))$, $C_r^prime (overline(Y) , overline(r))$ et $I^prime (overline(r))$.

#set enum(numbering: "1.", start: 2)
+ On suppose maintenant que le gouvernement augmente ses dépenses d’une quantité infinitésimale $Delta G$ sans effet sur les taux d’intérêt. Quelle est l’augmentation $Delta Y$ de la production d’équilibre ? Calculer le multiplicateur fiscal $frac(Delta Y, Delta G)$. Représenter cette augmentation sur le diagramme à 45 degrés.


#set enum(numbering: "1.", start: 3)
+ Dans la question précédente, on n’a pas précisé comment était financée la dépense supplémentaire \(peut-être par un emprunt remboursé dans le futur). On suppose maintenant que le gouvernement impose une taxe forfaitaire $Delta T$ sur le revenu des ménages pour financer ses dépenses \($Delta T = Delta G$). Avec ces taxes, la consommation totale des ménages est une fonction du revenu disponible $C = C (Y - Delta T , r)$. De combien augmente la production d’équilibre et quel est le nouveau multiplicateur fiscal? Comment interpréter le résultat?


#set enum(numbering: "1.", start: 4)
+ Calculer et représenter sur un graphe du même type l’effet d’une baisse des taux d’intérêt nominaux en supposant que les prix sont fixes à court terme.


=== Agents hétérogènes
<agents-hétérogènes>
On suppose maintenant que les agents sont répartis en 2 groupes: les agents de type $H$ \(hand-to-mouth), pour une fraction $lambda$, et les agents de type $S$ \(savers) pour une fraction $1 - lambda$. Les agents $H$ n’ont pas accès aux marchés financiers et tous leurs revenus proviennent du travail. Les agents $S$ \(pour savers) peuvent lisser leur consommation par l’epargne. Ces derniers recoivent en plus de leur travail, les revenus du capital et les profits des firmes. Les différent revenus seront définis plus bas.

#set enum(numbering: "1.", start: 5)
+ On suppose que les fonctions de consommation des deux groupes sont données par: où $overline(Y_H)$ \(resp $overline(Y_S)$) est le revenu perçu à l’équilibre par les agents $H$ \(resp $S$)

+ Justifier #emph[intuitivement] les hypothèses sur $c_Y^H$ et $c_Y^S$. A-t-on assez d’infomations pour calculer la propension marginale à consommer agrégée#footnote[La propension marginale à consommer agrégée est l’augmentation de la consommation prévue totale, lorsque le revenu total augmente d’une unité.] comme dans la question 1?

On fait maintenant les hypothèses suivantes sur la répartition du revenu total:

- tous les agents travaillent au même salaire $W$
- une fraction $alpha_L$ des revenus totaux revient aux travailleurs, une fraction $alpha_K$ aux détenteurs du capital et une fraction $alpha_pi$ est payée sous forme de profits au détenteurs des firmes. On a bien sûr $alpha_L + alpha_K + alpha_pi = 1$
- le gouvernements taxe les profits et les revenus du capital à un taux $tau$, pour les redistribuer aux agents $H$

#set enum(numbering: "1.", start: 7)
+ Calculer la propension marginale à consommer agrégée. Peut-elle être plus grande que 1? Quel est le multiplicateur fiscal?
