#import "@preview/touying:0.5.3": *
#import "@preview/fontawesome:0.3.0": *

== Programme des séances

- Séance 5 : demande globale
- Séance 6 : offre globale
- Séance 7 : fluctuations macroéconomiques
- Séance 8 : politique monétaire



= Nominal / Réel
<nominal-réel>
== Produit intérieur brut (PIB) Nominal / Réel
<produit-intérieur-brut-pib-nominal-réel>

Commençons par quelques notations#footnote[Nous utilisons $t$ pour désigner différentes périodes dans le temps.];. Dans ce cours :

- $Y_t$ : #emph[PIB réel] : le nombre de paniers de bien produits par l’économie
- $P_t$ : #emph[Niveau des prix] : le prix d’un panier de biens donné
- $#box(stroke: black, inset: 3pt, [$ pi_t = frac(P_t - P_(t - 1), P_(t - 1)) $])$ : #emph[Taux d’inflation]

Avec ces définitions, le #emph[PIB nominal];, c’est-à-dire la production vendue aux prix du marché, est simplement $P_t Y_t$.

== Taux d’intérêt nominal
<taux-dintérêt-nominal>
Pour épargner d’une période à l’autre, les agents ont accès à des obligations sans risque rapportant :

- $i_t$ : taux d’intérêt nominal entre $t$ et $t + 1$

Si un agent investit des économies $S_t$ à la période $t$, il obtient $S_t (1 + i_t)$ à la période $t + 1$.

== Taux d’intérêt nominal / réel
<taux-dintérêt-nominal-réel>
Qu’est-ce qui détermine la décision d’épargner davantage ou moins ?

Considérons l’ expérience de pensée suivante :

- un agent renonce à $1$ unité de consommation à la période $t$, valant $P_t$ aux prix du marché : sa richesse est $P_t$
- investie au taux nominal $i_t$, cette richesse devient $P_t (1 + i_t)$ à la période $t + 1$
- l’agent peut maintenant acheter $frac(P_t (1 + i_t), P_(t + 1))$ biens de consommation au nouveau prix du marché $P_(t + 1)$

En reconnaissant le ratio $1 + pi_(t + 1) = P_(t + 1) / P_t$, nous concluons que chaque unité de consommation aujourd’hui peut être échangée contre $frac(1 + i_t, 1 + pi_(t + 1))$ unités demain

- c’est plus avantageux lorsque le taux d’intérêt nominal est élevé
- c’est moins avantageux lorsque l’inflation est élevée
