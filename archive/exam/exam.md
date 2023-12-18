# Correction

## Exercice 1: la croix keynésienne

On considère une économie simplifiée où l'équilibre dépend de la production totale $Y$ et du taux d'intérêt *réel* $r$. Il s'agit d'un modèle de court terme de sorte que l'on omet les indices temporels. Tout au long de cet exercice, nous supposons que les prix sont fixes (nous faisons donc abstraction de l’offre agrégée). Les composantes de la demande agrégée sont:

- la consommation totale des ménages: $C=C(Y,r)$
- l'investissement total des entreprises: $I=I(r)$
- les dépenses gouvernementales $G$ choisies de manière exogène par le gouvernement $G$

### La croix keynésienne

1. __Écrire la relation définissant l'équilibre sur le marché des biens à l'état stationnaire $(\overline{Y},\overline{r})$. Justifier brièvement, sans calcul, le signe des dérivées $C^{\prime}_Y(\overline{Y},\overline{r})$, $C^{\prime}_r(\overline{Y},\overline{r})$ et $I^{\prime}(\overline{r})$.__

Nous analysons la détermination de l’équilibre au moyen d’un graphique (diagramme à 45 degrés, aussi appelé croix keynésienne): la demande est représentée sur l’axe vertical et la production est représentée sur l’axe horizontal. La production d’équilibre est donnée par l’égalité entre la production et la demande.

![Croix Keynesienne](cross.png)

2. __On suppose maintenant que le gouvernement augmente ses dépenses d'une quantité infinitésimale $\Delta G$ sans effet sur les taux d'intérêt. Quelle est l'augmentation $\Delta Y$ de la production d'équilibre ? Calculer le multiplicateur fiscal $\frac{\Delta Y}{\Delta G}$. Représenter cette augmentation sur le diagramme à 45 degrés.__


3. __Dans la question précédente, on n'a pas précisé comment était financée la dépense supplémentaire (peut-être par un emprunt remboursé dans le futur).  On suppose maintenant que le gouvernement impose une taxe forfaitaire $\Delta T$ sur le revenu des ménages pour financer ses dépenses ($\Delta T=\Delta G$). Avec ces taxes, la consommation totale des ménages est une fonction du revenu disponible $C=C(Y-\Delta T, r)$. De combien augmente la production d'équilibre et quel est le nouveau multiplicateur fiscal? Comment interpréter le résultat?__


4. __Calculer et représenter sur un graphe du même type l'effet d'une baisse des taux d'intérêt nominaux en supposant que les prix sont fixes à court terme.__


### Agents hétérogènes

On suppose maintenant que les agents sont répartis en 2 groupes: les agents de type $H$ (hand-to-mouth), pour une fraction $\lambda$, et les agents de type $S$ (savers) pour une fraction $1-\lambda$. Les agents $H$ n'ont pas accès aux marchés financiers et tous leurs revenus proviennent du travail. Les agents $S$ (pour savers) peuvent lisser leur consommation par l'epargne. Ces derniers recoivent en plus de leur travail, les revenus du capital et les profits des firmes. Les différent revenus seront définis plus bas.

5. __On suppose que les fonctions de consommation des deux groupes sont données par:__
\begin{align}
C^H(Y^H,r) & = & c^H_0 & + c^H_Y (Y_H - \overline{Y_H}) &  & \;\text{avec} & 1\approx c^1_H<1\\
C^S(Y^S,r) & = & c^S_0 & + c^S_Y (Y_S - \overline{Y_S}) & + c^S_r (r-\overline{r}) & \;\text{avec} & 0<c_1^S\approx 0 
\end{align}
__où $\overline{Y_H}$ (resp $\overline{Y_S}$) est le revenu perçu à l'équilibre par les agents $H$ (resp $S$)__


6. __Justifier *intuitivement* les hypothèses sur $c^H_Y$ et $c^S_Y$. A-t-on assez d'infomations pour calculer la propension marginale à consommer agrégée[^propension] comme dans la question 1?__

[^propension]: La propension marginale à consommer agrégée est l'augmentation de la consommation prévue totale, lorsque le revenu total augmente d'une unité.


On fait maintenant les hypothèses suivantes sur la répartition du revenu total:

- tous les agents travaillent au même salaire $W$
- une fraction $\alpha_L$ des revenus totaux revient aux travailleurs, une fraction $\alpha_K$ aux détenteurs du capital et une fraction $\alpha_\pi$ est payée sous forme de profits au détenteurs des firmes. On a bien sûr $\alpha_L + \alpha_K + \alpha_\pi=1$
- le gouvernements taxe les profits et les revenus du capital à un taux $\tau$, pour les redistribuer aux agents $H$

7. __Calculer la propension marginale à consommer agrégée. Peut-elle être plus grande que 1? Quel est le multiplicateur fiscal.__