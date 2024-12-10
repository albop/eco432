#import "@preview/touying:0.5.3": *
#import "@preview/fontawesome:0.3.0": *
#import "quarto_theme.typ": *

#show: clean-theme.with(
  aspect-ratio: "16-9",
                        )

#title-slide(
  title: [Demande Agrégée],
  subtitle: [ECO432 - Macroéconomie],
  authors: (
                    ( name: [Pablo Winant],
            affiliation: [],
            email: [],
            orcid: []),
            ),
  date: [],
)



= Rappel: PIB Nominal / PIB Réel


== Produit intérieur brut (PIB) : Nominal / Réel

Commençons par quelques notations. Dans ce cours :

- $Y_t$ : *PIB réel* : le nombre de paniers de bien produits par l'économie
- $P_t$ : *Niveau des prix* : le prix d'un panier de biens donné
- $pi_t = frac(P_t-P_(t-1),P_(t-1)))$ : *Taux d'inflation*

Avec ces définitions, le *PIB nominal*, c'est-à-dire la production vendue aux prix du marché, est simplement $P_t Y_t$.


---

== Taux d'intérêt nominal

Pour épargner d'une période à l'autre, les agents ont accès à des obligations sans risque rapportant :

- $i_t$ : taux d'intérêt nominal entre $t$ et $t+1$

Si un agent investit des économies $S_t$ à la période $t$, il obtient $S_t (1+i_t)$ à la période $t+1$.


== Taux d'intérêt nominal / réel

Qu'est-ce qui détermine la décision d'épargner davantage ou moins ?

Considérons l' expérience de pensée suivante :

- un agent renonce à $1$ unité de consommation à la période $t$, valant $P_t$ aux prix du marché : sa richesse est $P_t$
- investie au taux nominal $i_t$, cette richesse devient $P_t (1+i_t)$ à la période $t+1$
- l'agent peut maintenant acheter $frac(P_t (1+i_t),P_(t+1))$ biens de consommation au nouveau prix du marché $P_(t+1)$

En reconnaissant le ratio $1+pi_(t+1) = frac(P_(t+1),P_t)$, nous concluons que chaque unité de consommation aujourd'hui peut être échangée contre $frac(1+i_t,1+pi_(t+1))$ unités demain

- c'est plus avantageux lorsque le taux d'intérêt nominal est élevé
- c'est moins avantageux lorsque l'inflation est élevée


== Taux d'Intérêt Réel

Le _taux d'intérêt réel_ $r_t$ est défini par :

$ 1+r_t = frac(1+i_t,1 + pi_(t+1)) $

Il mesure à quel point il est bénéfique d'échanger des biens de consommation actuels contre des biens de consommation futurs.

En logarithmes:

$ r_t = i_t - pi_(t+1) $

Cette relation est parfois appelée l'_équation de Fisher_.



== Mini-check

#columns(2,[

  #image("assets_2/check.jpg",width:30%)


==== Quizz 1

Supposons que le taux d'intérêt nominal soit de 4% et l'inflation de 5%. Quel est le taux d'intérêt réel (en pourcentage) ?

1. 1
2. -1
3. 4/5
4. 5/6

#colbreak()

#pause 
==== Quizz 2

L'effet fishérien est la tendance de l'inflation à augmenter et à annuler toute hausse des taux nominaux par la banque centrale. Cela est plus susceptible de se produire si :

1. le taux réel est indépendant des variables nominales
2. les prix sont rigides
3. l'inflation est élevée
4. la dette est élevée

])

= Les composantes de la demande

== Qui dépense ?

Rappelons la décomposition du PIB par les dépenses:

$ Y = C + I + G + N X $

où

- $Y$: PIB nominal
- $C$: Consommation
- $I$: Investissement
- $G$: Dépenses du gouvernement
- $N X$: Exportations nettes

== Rappel sur les consommateurs


Consommation: $C(Y,r)$

== Producteurs

Une entreprise produit $f (K)$ en utilisant du capital K. Nous supposons des rendements marginaux décroissants dans la production, c’est-à-dire $f^('') (K) < 0$ (et bien sûr $f^(') (K) > 0$).

Supposons que l’entreprise emprunte une quantité I pour financer K, c’est-à-dire $K = I$. Après la production, elle doit rembourser I(1+r) dans la période suivante.

Le programme de maximisation des bénéfices se lit comme suit : $ max pi = f (I) - I (1 + r) $

Lorsque l’entreprise est libre d’emprunter autant qu’elle le souhaite, la condition d’optimalité est:$ f^(') (I) = 1 + r $

Cela définit implicitement $I (r)$. Étant donné que $f^(') (I)$ décroît en fonction de $I$, #strong[$I (.)$ est une fonction décroissante de r];.

== Reality Check
<reality-check>
#box(image("assets/investment.png"))

== Reality Check
<reality-check-1>
#block[
#block[
#box(image("assets/investment.png"))

]
#block[
- Ces dernières années, il semble que le canal de l’investissement n’ait pas très bien fonctionné.

- Au cours des deux dernières crises, et après, les taux d’intérêt étaient très bas. Et l’investissement était également faible.

]
]

#pause

Il y a de nombreuses raisons à cela :

- Incertitude concernant les résultats économiques
  - Les entreprises averses au risque qui font face à une valeur incertaine de la production produisent moins
- Même si le taux réel est bas, les conditions de financement auxquelles les entreprises sont confrontées peuvent être différentes
  - Les banques sont également averses au risque

== Producteurs
<producteurs-3>
Au-delà du coût de financement, pouvez-vous penser à d’autres raisons pour lesquelles l’investissement pourrait être réduit par les entreprises ?

- Une partie du capital préexistant appartient à l’entreprise, ce qui signifie qu’il n’est pas toujours nécessaire d’emprunter
- Tous les emprunts ne sont pas à court terme (et ne doivent pas être remboursés immédiatement après la production)
- De nombreuses entreprises ont des contraintes de crédit
  - En pratique, leur capacité à emprunter est limitée par le capital préexistant qu’elles ont et qu’elles utilisent comme "collatéral"

= Dérivation de la Demande Agrégée
<dérivation-de-la-demande-agrégée>
== La Courbe IS
<la-courbe-is>
Notre travail sur le comportement des consommateurs et des entreprises nous permet d’écrire. $ C (Y , r) & = & C_0 + C_Y Y + C_r r\
I (r) & = & I_0 + I_r r $

où $I_r < 0$ et où les valeurs $C_Y > 0$ et $C_r < 0$ dépendent de la proportion de ménages ricardiens et keynésiens.

Donc, si nous prenons $G$ et $N X$ comme exogènes, la somme de toutes les composantes de dépenses est :$ C (Y , r) + I (r) + G + N X $

#pause
Est-ce que cela représente la Demande Agrégée ? #strong[Non !]

== Courbe IS
<courbe-is>
En macroéconomie, le côté demande de toute l’économie est caractérisé par la relation :

$ Y = C (Y , r) + I (r) + G + N X $

qui lie #emph[implicitement] la production et le taux d’intérêt réel.

Cette relation est appelée équilibre #strong[Investissement-Épargne] (courbe IS) car elle traduit un compromis intertemporel (à travers le taux d’intérêt réel).

Elle correspond à un équilibre sur le marché des biens et services, déterminé par les préférences de dépenses, avec une production parfaitement élastique.

== Courbe IS
<courbe-is-1>
Quelques remarques :

- la relation IS microfondée n’implique que des quantités réelles
- elle implique uniquement des décisions rationnelles des consommateurs et des entreprises
- la demande peut être microfondée sans nécessiter de monnaie ou de prix

Fait intéressant, la microfondation de la demande montre qu’elle est parfaitement cohérente avec l’approche néoclassique.

Il n’y a pas de controverse dans la profession concernant l’existence de la courbe de demande. Il y a des désaccords concernant :

- la propension marginale à consommer agrégée et le multiplicateur fiscal
- la courbe d’offre…

== Courbe IS
<courbe-is-2>
Jusqu’à présent, nous avons justifié les dépendances suivantes pour les composantes des dépenses du PIB : $ C (Y , r) + I (r) + G + N X $

À l’équilibre du PIB et du taux d’intérêt, nous avons : $ Y_0 = C_0 + I_0 + G_0 + N X_0 $

On peut différentier l’équation ci-dessus pour obtenir :

$ Y_0 + Delta Y = C_0 + C_Y Delta Y + C_r Delta r + I_r Delta r + G_0 + N X_0 + Delta S $

Où $Delta S = Delta G + Delta N X$ capture le choc à la demande. Après soustraction des constantes, on obtient une approximation linéaire : $ Delta Y = C_Y Delta Y + C_r Delta r + I_r Delta r + Delta S $

== Courbe IS
<courbe-is-3>
On peut différencier la courbe IS pour obtenir : $ Delta Y = C_Y Delta Y + C_r Delta r + I_r Delta r $

En logarithmes:

$ frac(Delta Y, Y) = C_Y frac(Delta Y, Y) + C_r / Y Delta r + I_r / Y Delta r $

Avec $y = frac(Delta Y, Y)$ et $Delta r = r - r^star.op$ on obtien l’équation décrivant la courbe IS: $ y = - sigma (r - r^star.op) $

où $ sigma = frac(- (C_r / Y + I_r / Y), 1 - C_Y) > 0 $.



== Courbe IS
<courbe-is-4>
Dans ce qui suit, nous considérerons une version légèrement modifiée de la courbe IS

$ #box(stroke: black, inset: 3pt, [$ y_t = - sigma (r_r - r^star.op) + theta_t $]) $

où $sigma = frac(- (C_r / Y + I_r / Y), 1 - C_y) > 0$ et $theta_t$ est un choc de demande, qui capture tous les chocs externes au modèle ou que nous avons négligés pour simplifier.

Par exemple, les revenus futurs des consommateurs ont été exclus de toutes les équations. Si les attentes des consommateurs changent positivement (optimisme), nous le considérerions comme un changement dans $theta_t$.

De la même manière, une augmentation des dépenses publiques est un déplacement autonome de la courbe IS, que nous capturons par un déplacement de $theta_t$.

== Exercice pour interpéter $sigma$
<exercice-pour-interpéter-sigma>
#block[
#block[
]
#block[
==== Quizz 4

Trouvez l’affirmation incorrecte parmi les suivantes :

- Une PMC plus élevée implique une élasticité plus élevée de la demande aux chocs de revenu pour les ménages keynésiens
- Une élasticité plus élevée de la deamnde au taux d’intérêt signifie une réponse plus élevée de la demande à la politique monétaire pour les ménages et les entreprises ricardiens

]
]
= Le rôle de la Banque Centrale

== Politique Monétaire

L’objectif principal de la banque centrale consiste à #emph[stabiliser l’inflation] $pi$ autour de sa cible $pi^star.op$

- Elle atteint cet objectif en #emph[influençant la demande] en réponse aux fluctuations des cycles économiques

- La demande est affectée par le taux d’intérêt #emph[réel] $r$
  - plus précisément, les ménages et les entreprises ricardiens réagissent au taux d’intérêt réel

== Politique Monétaire

- En pratique, la banque centrale fixe le taux d’intérêt #emph[nominal] $i$

  - Comme l’inflation ne suit pas le taux d’intérêt 1 pour 1, la banque centrale est capable d’influencer le taux d’intérêt réel#footnote[on rappelle l’équation de Fisher $r_t = i_t - pi_(t + 1)$}]

- Pour simplifier, on suppose que la banque centrale choisit indirectement le taux d’intérêt réel à n’importe quel niveau qu’elle souhaite

- On peut alors décrire la fonction de réponse de la banque centrale#footnote[on suit ici l’approche de Romer 2002.] comme suit : $ #box(stroke: black, inset: 3pt, [$ r_r = r^star.op + gamma (pi_t - pi^star.op) $]) $

- En général, les banques centrales augmentent le taux d’intérêt pour réduire l’inflation, donc $gamma > 0$

= Demande Agrégée

== Demande Agrégée

Maintenant que nous disposons de la courbe (IS) : $ y_t = - sigma (r_t - r^star.op) + theta_t $

Et de la réponse de la politique de la banque centrale (MP) : $ r_t = r^star.op + gamma (pi_t - pi) $

On peut substituer le taux d’intérêt réel pour obtenir une équation de demande agrégée (AD) : $ #box(stroke: black, inset: 3pt, [$ y_t = - sigma gamma (pi_t - pi^star.op) + theta_t $]) $

où $theta_t$ est le choc de demande.

Cette courbe représente l’équilibre sur les marchés des biens et des services, en tenant compte de la règle de décision de la banque centrale.

== Courbe de Demande Agrégée#footnote[Dans certains manuels, vous trouverez les prix agrégés $P_t$ sur l’axe des ordonnées au lieu de l’inflation. Parce que $P_(t - 1)$ est donné et que l’inflation est $pi_t = P_t \/ P_(t - 1)$, c’est en fait équivalent.]

#image("assets/as_ad.png")

Demande Agrégée (AD) : $ y_t = theta_t - sigma gamma (pi_t - overline(pi)) $

Notez que la demande agrégée $y_t$ est une fonction décroissante de l’inflation (et des prix).

== Résumé Exécutif
<résumé-exécutif>
- La demande agrégée peut être fondée sur la micro-optimisation rationnelle des consommateurs et des entreprises
  - Les ménages keynésiens ont une propension marginale à consommer élevée
  - Les ménages ricardiens ont une propension marginale à consommer faible et réagissent (négativement) au taux d’intérêt réel
  - Les entreprises investissent moins lorsque le taux d’intérêt réel est plus élevé

~

- La demande agrégée est décroissante (en l’inflation)

- Pour stabiliser l’inflation, la banque centrale stimule la demande en modifiant le taux d’intérêt réel. Elle le fait indirectement en fixant le taux d’intérêt nominal.

  - …on verra dans la dernière session #emph[comment] la BC influence le taux nominal

== À Suivre

#strong[Offre Agrégée] : pourquoi est-elle croissante à court terme ?
