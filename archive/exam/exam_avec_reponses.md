# Correction

## Exercice 1: la croix keynésienne

On considère une économie simplifiée où l'équilibre dépend de la production totale $Y$ et du taux d'intérêt *réel* $r$. Il s'agit d'un modèle de court terme de sorte que l'on omet les indices temporels. Tout au long de cet exercice, nous supposons que les prix sont fixes (nous faisons donc abstraction de l’offre agrégée). Les composantes de la demande agrégée sont:

- la consommation totale des ménages: $C=C(Y,r)$
- l'investissement total des entreprises: $I=I(r)$
- les dépenses gouvernementales $G$ choisies de manière exogène par le gouvernement $G$

### La croix keynésienne

1. __Écrire la relation définissant l'équilibre sur le marché des biens à l'état stationnaire $(\overline{Y},\overline{r})$. Justifier brièvement, sans calcul, le signe des dérivées $C^{\prime}_Y(\overline{Y},\overline{r})$, $C^{\prime}_r(\overline{Y},\overline{r})$ et $I^{\prime}(\overline{r})$.__

*La relation d'équilibre sur le marché des biens est: $$\overline{Y} = C(\overline{Y}, \overline{r}) + I(\overline{r})  + G$$*

*Le coefficient $C_Y^{\prime}$ représente la propension marginale à consommer. Elle est comprise entre 0 (pour les agents ricardiens) et 1 pour les agents keynésiens.
Lorsque le taux d'intérêt augmente les consommateurs ont tendance à épargner plus, donc consommer moins d'où $C^{\prime}_r<0$. De même, il est dans ce cas plus coûteux pour les firmes d'emprunter pour investir, d'où $I^{\prime}_r<0$.*


Nous analysons la détermination de l’équilibre au moyen d’un graphique (diagramme à 45 degrés, aussi appelé croix keynésienne): la demande est représentée sur l’axe vertical et la production est représentée sur l’axe horizontal. La production d’équilibre est donnée par l’égalité entre la production et la demande.

![Croix Keynesienne](cross.png)

1. __On suppose maintenant que le gouvernement augmente ses dépenses d'une quantité infinitésimale $\Delta G$ sans effet sur les taux d'intérêt. Quelle est l'augmentation $\Delta Y$ de la production d'équilibre ? Calculer le multiplicateur fiscal $\frac{\Delta Y}{\Delta G}$. Représenter cette augmentation sur le diagramme à 45 degrés.__

Si l'on différencie la relation d'équilibre, on obtient:

$$\Delta Y = C_Y^{\prime} \Delta Y + \Delta G$$

soit

$$\boxed{\Delta Y= \frac{1}{1-C_Y}\Delta G}$$

d'où l'on obtient le multiplicateur fiscal:

$$\boxed{\frac{\Delta Y}{\Delta G}= \frac{1}{1-C_Y}}$$

Les dépenses du gouvernement étant la part autonome des dépenses supplémentaires, on peut aussi écrire:

$$\boxed{\Delta Y= \underbrace{\Delta G}_{\text{Dépense autonome}} + \underbrace{\left(\frac{C_Y}{1-C_Y}\right)\Delta G}_{\text{Dépense induite}}}$$



1. __Dans la question précédente, on n'a pas précisé comment était financée la dépense supplémentaire (peut-être par un emprunt remboursé dans le futur).  On suppose maintenant que le gouvernement impose une taxe forfaitaire $\Delta T$ sur le revenu des ménages pour financer ses dépenses ($\Delta T=\Delta G$). Avec ces taxes, la consommation totale des ménages est une fonction du revenu disponible $C=C(Y-\Delta T, r)$. De combien augmente la production d'équilibre et quel est le nouveau multiplicateur fiscal? Comment interpréter le résultat?__


*Puisque les dépenses sont financées par des taxes $\Delta T=\Delta G$, on écrit maintenant:*

$$\overline{Y} + \Delta Y= C(\overline{Y} + \Delta Y -\Delta G, \overline{r}) + I(\overline{r})  + G + \Delta G$$

*ce qui donne*

$$\Delta Y = C_Y (\Delta Y - \Delta G) + \Delta G$$

*On en déduit (en supposant $C_Y \neq 1$), $\Delta Y=\Delta G$. Cela est surprenant à première vue : le gouvernement réussit à augmenter la demande sans s'endetter.
On peut comprendre le resultat en voyant que la taxe revient à transférer des revenus d'un agent (le consommateur) vers un autre (l'état) dont la propension marginale à consommer est plus élevée. Cela dit 1/le modèle implique que la production ne dépend que de la demande ce qui est irréaliste 2/ sur le moyen terme, maximmiser la demande n'est pas optimal donc il ne faut pas surinterpréter le modèle*

4. __Calculer et représenter sur un graphe du même type l'effet d'une baisse des taux d'intérêt nominaux en supposant que les prix sont fixes à court terme.__

*On rappelle la relation de Fisher $r=i-\pi$. Si les prix sont rigides $\pi=0$  l'augmentation des taux nominaux est équivalente à la même augmentation des taux réels.*

*Cette fois, différencier la relation d'équilibre donne:*

$$\Delta Y = C_Y^{\prime} \Delta Y + C_r^{\prime} \Delta r + I_r^{\prime} \Delta r$$

*d'où l'augmentation de la production demandée:*

$$\frac{\Delta Y}{\Delta r} = \frac{ C_r^{\prime} + I_r^{\prime}} {1-C_Y^{\prime}}$$

*que l'on peut aussi décomposer comme suit:*

$$\frac{\Delta Y}{\Delta r} = \underbrace{\left(C_r^{\prime} + I_r^{\prime}\right)}_{\text{effet direct}}  + \underbrace{ \left( C_r^{\prime} + I_r^{\prime} \right) \frac{C_Y^{\prime}} {1-C_Y^{\prime}} }_{\text{effet induit}}$$

<!-- 
1. __A votre avis quelle zone du graphe, hors équilibre peut être qualifiée d'inflationniste?__
*Comme dans la dérivation classique d'islm: à droite de l'équilibre la demande est supérieure à l'équilibre, le taux d'intérêt réel doit diminuer pour ramener la demande à un niveau compatible avec l'équilibre. * -->

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

*On a déjà vu en cours pourquoi $c_Y^H \approx 1$ (ménages keynésiens) et on a parlé des ménages ricardiens pour lesquels $c^Y_H \approx 0$. On aura mentionné l'arbitrage consommation travail sans faire de calcul.*
- *Un ménage ricardien place son revenu pour le transformer en revenu permanent et essentiellement en consommer les intérêts à chaque période.*
- *Un ménage keynésien consomme tout ce qu'il peut. S'il reçoit un revenu additionnel ce revenu sera donc consommer intégralement.*

*Pour calculer la propension marginale à consommer agrégée, il manque une information sur la façon dont le revenu marginal est distribué.*

On fait maintenant les hypothèses suivantes sur la répartition du revenu total:

- tous les agents travaillent au même salaire $W$
- une fraction $\alpha_L$ des revenus totaux revient aux travailleurs, une fraction $\alpha_K$ aux détenteurs du capital et une fraction $\alpha_\pi$ est payée sous forme de profits au détenteurs des firmes. On a bien sûr $\alpha_L + \alpha_K + \alpha_\pi=1$
- le gouvernements taxe les profits et les revenus du capital à un taux $\tau$, pour les redistribuer aux agents $H$

1. __Calculer la propension marginale à consommer agrégée. Peut-elle être plus grande que 1? Quel est le multiplicateur fiscal.__

*Les revenus du travail sont $\alpha_L Y$. Les revenus du capital sont $(\alpha_K + \alpha_{\Pi})Y$.*
*Regardons comment se répartissent les dépenses prévues en réponse à une augmentation du revenu agégé $\Delta Y$.Comme le salaire est le meme pour tout le monde, le revenu du travail des agents H augmente de $\alpha_L \lambda \Delta Y$. Ils reçoivent en plus les transferts $\tau (\alpha_K + \alpha_{\Pi})\Delta Y$ de sorte que leur propension marginale à consommer en fonction du revenu 'total' est $$\frac{\Delta C^H}{\Delta Y}=c^H_1(\alpha_L \lambda + \tau(\alpha_K + \alpha_\pi))$$*
*De la même façon celle des agents $S$ est*:

$$\frac{\Delta C^S}{\Delta Y}=c^S_1(\alpha_L (1-\lambda) + (1-\tau)(\alpha_K + \alpha_\pi))$$

*La propension marginale à consommer totale est donc*:
\begin{align}\frac{\Delta C^H}{\Delta Y}+\frac{\Delta C^S}{\Delta Y} & = & c^H_1(\alpha_L \lambda + \tau(\alpha_K & + \alpha_\pi))+c^S_1(\alpha_L (1-\lambda) + (1-\tau)(\alpha_K + \alpha_\pi))\\
 & \approx & (\alpha_L \lambda + \tau(\alpha_K + \alpha_\pi)) &
\end{align}.

On voit que la propension marginale à consommer croît logiquement avec la proportion $\lambda$ d'agents keynésiens et avec le degré de répartition des profits $\tau$. En supposant à l'extrême que $\lambda$ est proche de 1, pour que la MPC soit plus grande que 1, il faudrait avoir: $\tau \geq \frac{1-\alpha_L}{\alpha_K+\alpha_{\pi}}=1$ ce qui est impossible.