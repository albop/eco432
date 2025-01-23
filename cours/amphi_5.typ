#import "@preview/touying:0.5.3": *
#import "@preview/fontawesome:0.3.0": *
#import "quarto_theme.typ": *

#show: clean-theme.with(
  aspect-ratio: "16-9",
                        )

#title-slide(
  title: [Politique Monétaire],
  subtitle: [ECO432 - Macroéconomie],
  authors: (
    (
      name: [Pablo Winant],
      affiliation: [],
      email: [],
      orcid: []),
    ),
  date: [],
)

#import "@preview/mitex:0.2.4": *


= Les outils de la politique monétaire

== Les outils de la politique monétaire

Quels sont les principaux outils de la politique monétaire ?

- Opérations d’open market

  - la BC échange des liquidités (cash) en échange d’actifs moins liquides (obligations/bons du tresor)
  - la BC prête sur le marché interbancaire

- Taux de réserves obligatoires

- Taux d’intérêt sur les réserves détenues par les banques auprès de la BC

  - "Discount rate" aux US
  - "Main Refinancing Operations" (MRO) en Zone Euro

- D’autres outils non-conventionnels (non couverts ici)


== Agrégats monétaires


La Banque Centrale a le monopole de la création de #strong[Monnaie Banque Centrale] :

- Pièces, billets de banque, euros numériques…

La Monnaie Banque Centrale est également appelée #strong[Base Monétaire];. Comment est-elle #emph[injectée] dans l’économie ?

#pause

En principe, la Banque Centrale #emph[pourrait] la distribuer :

- en envoyant des chèques ou en monétisant directement le déficit du gouvernement#footnote[La Monnaie Hélicoptère est une #emph[métaphore] inventée par Milton Friedman pour décrire, pour expliquer que, d’un point de vue macroéconomique, le destinataire réel de la monnaie n’est pas si important.]

#pause

Mais en pratique, les banques centrales échangent la Monnaie Banque Centrale contre des actifs moins liquides.

- ce qui permet la création d’argent par les banques privées.

== Qui possède la Monnaie Banque Centrale ?

#figure(
  image("assets_4b/base_money.png", height: 50%),
  caption: [Base Monétaire]
)

// Base Monétaire (statistiques de la BCE)

#pause

La majeure partie de l’argent créé par la Banque Centrale depuis 2009 est détenue par des institutions financières privées qui détiennent des réserves (comptes courants) à la Banque Centrale.#footnote[Cet argent reste virtuel dans le sens où il n’est jamais imprimé. Il s’agit effectivement de monnaie numérique.]


== Monnaie Étroite / Monnaie Large



#grid(columns:(60%, 40%), [

#set text(15pt)
La BCE répertorie plusieurs agrégats monétaires :

- M1 : #strong[Monnaie étroite]
  - monnaie fiducière (pièces, billets) en circulation et dépôts à vue (par exemple, les comptes chèques des consommateurs)

- M2 :
  - M1 + dépôts avec une maturité convenue de jusqu’à deux ans et dépôts remboursables avec un préavis de jusqu’à trois mois

- M3 : #strong[Monnaie large]
  - M2 + accords de rachat, parts/unités de fonds du marché monétaire et titres de créance avec une maturité de jusqu’à deux ans

Les agrégats monétaires contiennent des actifs financiers de _liquidité_#footnote[La liquidité d'un actif mesure, sa capacité] décroissante.

Notez que dans ces agrégats monétaires, seule la monnaie est créée par la Banque Centrale. Tous les autres actifs sont créés par le secteur privé.
],

figure(
  image("assets_4b/aggreg.png", height: 60%),
  caption: "Agrégats monétaire"
)

)



== 

#image("assets_4b/two_birds.png", width: 20%)

Attendez ? Les banques privées créent de l’argent ?

#pause

Oui, la plupart d’entre elles. Expliquons comment.


== Contrôler M1

#block[

#set text(16pt)

#grid(columns:(60%, 40%), [


- Lorsqu’une banque commerciale accorde un prêt, elle crée de l’argent directement !
- Le crédit des banques privées est limité par le ratio de réserve obligatoire
  - les banques commerciales doivent conserver une fraction $lambda$ de leurs passif sous forme de réserves
  - pour 1 unité de Monnaie Banque Centrale qu’elles reçoivent (par exemple, sous forme de dépôts), elles sont autorisées à  prêter $1 - lambda$
- Le montant total d’argent étroit que le système financier peut créer à partir d’un dépôt de 1 unité est appelé multiplicateur monétaire#footnote[les calculs pour obtenir le multiplicateur monétaire sont très similaires au multiplicateur fiscal. Un euro de dépôts conduit à un prêt total de $(1 - lambda) + (1 - lambda)^2 + dots.h.c = (1 - lambda) frac(1, 1 - (1 - lambda)) = 1/lambda - 1$.] : $mu = 1 / lambda - 1$

],

figure(image("assets_4b/multiplier.png", width: 80%))
)

Changer le ratio de réserve est un outil politique potentiel pour contrôler la création d’argent par le secteur privé.

]

== 


Quelle est la taille du multiplicateur monétaire ?

#pause

Le ratio de réserves obligatoire était de 2% jusqu’en 2012. 1% depuis lors.

#pause

Le multiplicateur monétaire théorique était d’environ 50 jusqu’en 2012, 100 depuis lors.

#pause

Vérifions les données…

== Contrôler M1

#figure(
  image("assets_4b/base_money_multiplier.png", width: 60%),
  caption: [La base monétaire et le multiplicateur monéntaire (BCE)]
)

#pause

#block[
  #set text(16pt)
Depuis 2009, la base monétaire a augmenté considérablement, mais pas le crédit. Le multiplicateur monétaire est loin de son maximum. Les exigences de réserves ne sont pas contraignantes.
]

== Ciblage de l’inflation


=== Évolution des pratiques politiques standard

#align(center)[
#image("assets_4b/evolution_practices.png",width: 80%)
]

== Ciblage de l’inflation

La plupart des BC (Banques Centrales) ont maintenant adopté une forme de "ciblage de l’inflation"

- la banque centrale tente d’atteindre un objectif d’inflation donné (par exemple, 2% dans la zone euro)

Elle atteint cet objectif en manipulant les taux d’intérêt nominaux :

- soit en contrôlant la masse monétaire
- soit en fixant directement les taux d’intérêt

#pause

Depuis les années 2009, #strong[l’instrument principal de la politique monétaire est le taux d’intérêt]

- la quantité d’argent créée est déterminée par le secteur privé


== Ciblage de l’inflation et la règle de Taylor

_De facto_, quelles variables économiques la BC considère-t-elle pour stabiliser l’inflation ?

#pause

John Taylor, a découvert empiriquement (en 1993) que les décisions réelles en matière de taux d’intérêt étaient bien approximées (même avant l’adoption du ciblage de l’inflation) par une #emph[règle simple] de la forme :

$ i_t = i^star.op + 0.5 (pi_t - pi^star.op) + 0.5 (y_t - y_t^(n t)) $

Cela dépend de

- l’écart d’inflation par rapport à sa cible
- l’écart de production par rapport à son niveau naturel (écart de production)


== Règle de Taylor vs Taux Effectif

#align(center)[
#image("assets_4b/taylor_rule_vs_effective_1.png", width: 80%)
]

Depuis 1999, la règle de Taylor reste globalement pertinente mais s'est détachée de la cible après 2014 (quand les taux d’intérêt étaient à 0).

== Règle de Taylor améliorée


Une version basée sur les anticipations d’inflation décrit bien les décisions des BC :

$ i_t = i^star.op + 0 , 5 underbrace((E_t [pi_(t + 1)] - pi^star.op), upright("excès d’inflation attendu")) + 0 , 5 underbrace(E_t [y_t - y_t^(n t)], upright("écart de production attendu")) $

Cette version est un bon point de référence pour comprendre la communication de la banque centrale.

== Règle de Taylor améliorée vs Taux Effectif

#figure(
  image("assets_4b/taylor_rule_vs_effective_2.png", width: 80%),
  caption: [Règle de Taylor améliorée (source: Orphanides et Wieland 2013)]
)

=== Résumé opérationnel

Évolution de la conduite de la politique monétaire:  depuis les années 90 les principales banques centrales sont passées au ciblage de l’inflation

La banque centrale augmente le taux d’intérêt

- lorsque la production (anticipée) est supérieure à son niveau naturel
  - pour éviter les pressions inflationnistes, la surchauffe économique
- lorsque l’inflation (anticipée) est trop élevée
  - la banque tente d’ancrer les anticipations autour de sa cible

Le fait que la banque centrale réagisse et manipule les #emph[anticipations] est la clé de la politique monétaire moderne.#footnote[Le blogueur Matt O’Brian note que les « Banques Centrales ont une forte influence sur les anticipations du marché » et compare leurs activités à des « jedi mind-tricks ».]

= Mise en œuvre de la politique monétaire

== Structure temporelle des taux d’intérêt

// === Équation de Fisher et anticipation d’inflation

// Rappel de l’équation de Fisher :

// $ r_t = i_t - pi_(t + 1) $

// Pour être plus précis, nous devrions écrire : $ r_t = i_t - E_t [pi_(t + 1)] $

// Car c’est seulement l’inflation "anticipée" qui est connue à la date $t$. Nous omettons le signe d’espérance, mais gardez à l’esprit que $pi_(t + 1)$ représente l’inflation anticipée.

// #pagebreak()

// === Règle monétaire et anticipation d’inflation

// Lors de la dérivation de la courbe AD, nous avons écrit la règle des taux d’intérêt réels (MP) comme suit : $ r_t = r^star.op + gamma (pi_t - overline(pi)) $

// Mais la BC ne contrôle pas directement le taux d’intérêt réel. Elle contrôle le taux d’intérêt nominal $i_t$.

// Maintenant, prenons l’équation de Fisher $r_t = i_t - pi_(t + 1)$. Nous pouvons la remplacer ci-dessus pour obtenir : $ i_t = r^star.op + gamma (pi_t - overline(pi)) + pi_(t + 1) $

// Nous voyons que la banque centrale fixe le taux d’intérêt pour contrôler une combinaison de l’inflation et de l’"inflation anticipée". Plus proche d’une règle de Taylor moderne.

// #pagebreak()

=== Taux d’intérêt à court terme

En réalité, la BC ne contrôle pas directement $i_t$ (le taux trimestriel ou annuel)

#pause

La BC contrôle plutôt les taux d’intérêt à très court terme, généralement du jour au lendemain. 

#pause

Où cela se passe-t-il ? Sur le #emph[marché interbancaire] :

- Les banques prêtent entre elles les réserves qu’elles détiennent sur un compte de la Banque Centrale.
- La Banque Centrale fixe le prix sur ce marché
- Comment le paramétrage d’un taux d’intérêt à court terme affecte-t-il le taux d’intérêt à long terme à n’importe quelle maturité (horizon) ?

#pagebreak()

=== Arbitrage

#grid(
  columns:(30%,5%,65%), 
  figure(
    image("assets_4b/arbitrage_1.png"),
    caption: [Arbitrage]
  ),[],
  [

Lorsque deux ou plusieurs options d’investissement équivalentes rapportent des rendements différents, les investisseurs se précipitent vers la plus rentable… jusqu’à ce que les rendements s’égalisent

Ainsi, à l’équilibre, toutes les options d’investissement équivalentes doivent finalement avoir le même rendement: c'est la condition "d'absence d'arbitrage".

Les différences entre les taux de rendement sont expliquées par des différences dans :

- les caractéristiques de risque
- la liquidité

])

#pagebreak()

=== Structure temporelle des taux d’intérêt

#grid(
  columns:(30%,5%,65%), 
  figure(
    image("assets_4b/arbitrage_2.png"),
    caption: [Arbitrage entre maturités]
  ),[],
  [

Appliquons le principe de l’arbitrage à :

- Une obligation d’un an rapportant $i_t^(1 y)$
- Deux obligations de six mois rapportant (annualisées)
  - $i_t^(6 m)$ achetée à la date $t$
  - $i_(t + 6 m)^(6 m)$ achetée à la date $t + 6 m$
- Cela nous fournit deux options pour investir sur 1 an.
- Quelle est la condition d’arbitrage ?

])

#pagebreak()

=== Structure temporelle des taux d’intérêt

Investissement de la valeur X à la date $t$

L’option 1 rapporte :

- $X (1 + i^(1 y)_t)$ après un an
- Le rendement brut est $(1 + i^(1 y)_t)$

L’option 2 rapporte (attention au fait que les rendements sont annualisés)

- $X (1 + i_t^(6 m))^(1 \/ 2)$ après 6 mois
- $X (1 + i_t^(6 m))^(1 \/ 2) (1 + i_(6 m)^(t + 6 m))^(1 \/ 2)$ après un an
- Le rendement brut est $(1 + i_t^(6 m))^(1 \/ 2) (1 + i_(6 m)^(t + 6 m))^(1 \/ 2)$

#pagebreak()

=== Structure temporelle des taux d’intérêt

La condition d'absence d’arbitrage s’écrit : $ (1 + i^(1 y)) = (1 + i_t^(6 m))^(1 \/ 2) (1 + i_(6 m)^(t + 6 m))^(1 \/ 2) $ Ou en termes logarithmiques : $i_t^(1 y) = 1 / 2 i_t^(6 m) + 1 / 2 i_(t + 6 m)^(6 m)$

Étant donné que les investisseurs sont averses au risque et apprécient la flexibilité d’avoir de l’argent plus tôt, ils demandent une prime de risque $phi$ : $ i^(1 y) = 1 / 2 i_t^(6 m) + 1 / 2 i_(t + 6 m)^(6 m) + phi $

La prime de risque intègre l’incertitude concernant le fait que les opportunités d’investissement pourraient changer avant un an, et la possibilité que le taux d’intérêt à six mois puisse changer avant un an.

=== Structure temporelle des taux d’intérêt

Le même raisonnement s’applique au taux quotidien fixé par la banque centrale :

$ i_t^(1 y) = 1 / 365 (i^(1 d)_t + i_(t + 1 d)^(1 d) + i_(t + 2 d)^(1 d) + dots.h.c i_(t + 364 d)^(1 d)) + phi $

- En manipulant les taux d’intérêt de courte durée (maturité annualisée), la banque centrale peut manipuler le taux d’intérêt annuel.
- Elle le fait en annonçant une trajectoire des taux d’intérêt futurs.
- Pour que la manipulation soit efficace, la trajectoire des taux d’intérêt futurs doit être _claire et prévisible_, de même que son ajustement éventuel aux contingences économiques.



=== Taux d’intérêt à court terme et taux d’intérêt à long terme



#grid(
  columns:(50%,5%,45%), 
  figure(
  image("assets_4b/short_term_long_term.png"),
    caption: [Évolution des différentes maturités]
  ),[],
  [


- Les taux d’intérêt à court terme sur le marché interbancaire influencent les maturités plus longues (3 mois et 10 ans)
- Les taux d’intérêt à long terme ne varient pas de manière équivalente aux taux d’intérêt à court terme.
- Cela s’explique par le fait que les taux d’intérêt à long terme intègrent les changements futurs des taux d’intérêt à court terme.

])


=== Taux d’intérêt à court terme

#grid(
  columns:(50%,5%,45%), 
  figure(
    image("Taux-directeurs.png"),
    caption: [Divers taux directeurs#footnote[Il s'agit de taux sur le marché interbancaire que contrôle la banque centrale] à court terme]
  ),[],
  [

- Les taux d’intérêt sont examinés régulièrement (tous les quelques mois).
- En général, ils évoluent lentement, de manière prévisible.

- Notez que les taux sont restés à des niveaux historiquement bas depuis 2008 jusqu'au retour de l'inflation en 2022

])

== Le marché interbancaire


=== Taux d’intérêt sur les réserves et taux d’intérêt sur le marché interbancaire

- Donc, la banque centrale (BC) manipule $r$ en manipulant $i$ en fixant le taux d’intérêt sur le marché interbancaire au jour le jour

- Mais comment la BC fixe-t-elle le prix sur le marché interbancaire ? 🤔

  - C’est un prix d’équilibre, pas directement décidé par la BC.

#pagebreak()

=== Le marché interbancaire

Lorsque les clients d’une banque donnée font des transactions entre eux, aucun argent ne quitte la banque.

Maintenant, considérons l’expérience mentale suivante :

- Lorsqu’un client de la banque A paie un client de la banque B, la banque A devrait recevoir des réserves de la banque B.
- Le même jour, il peut y avoir des transactions de B vers A pour compenser la première transaction.
- Mais à la fin de la journée, les déséquilibres doivent être corrigés et la banque A doit payer la banque B.
- Si A a suffisamment de réserves, elle peut les utiliser.
- Sinon, elle peut les emprunter à une autre banque C pour couvrir la transaction
  - sur le marché interbancaire.

#pagebreak()

=== Taux d’intérêt sur les réserves et taux d’intérêt sur le marché interbancaire

#block[
#set text(18pt)

- Pour s’assurer qu’elles peuvent effectuer les transactions pour régler les déséquilibres :

  - Les banques détiennent des réserves à la BC pour couvrir les paiements interbancaires en cas de besoin.
  - Elles se prêtent des réserves les unes sur le marché interbancaire.

- Il y a deux taux correspondants :

  - Les réserves à la BC rapportent un taux d’intérêt $i_R$. Fixé par la banque centrale
  - Le taux de marché $i_M$

- Le montant total $R_0$ de réserves (Monnaie Banque centrale) est décidé par la banque centrale.

- La banque centrale a donc deux instruments :

  - introduire davantage de réserves via des opérations d'open market : changer $R_0$
  - changer le taux d’intérêt payé sur les réserves $i_R$

]

#pagebreak()


== Le marché interbancaire

=== Équilibre sur le marché interbancaire



#grid(
  columns:(45%,5%,50%), 

  [


#only("1",figure(
  image("assets_4b/interbank.png", width: 80%),
  caption: "Équilibre sur le marché interbancaire"
))

#only("2",figure(
  image("assets_4b/interbank_quantitative.png", width: 80%),
  caption: "Marché interbancaire : intervention quantitative"
))

#only("3",figure(
  image("assets_4b/interbank_ir.png", width: 80%),
  caption: "Marché interbancaire : intervention quantitative"

))

  ],[],


[

#only("1",[


- Plus le taux d’intérêt est élevé, plus l’incitation est grande pour une banque ayant besoin de liquidité de puiser dans ses propres réserves (au prix de certains risques opérationnels).
- La demande diminue avec le taux d’intérêt à court terme.

])

#only("2",[

Intervention quantitative :

- Une offre plus importante de réserves diminue le taux de marché $i_M$
  #footnote[Comme dans le modèle IS-LM $♡$.]
- Plus le niveau de réserves est élevé, plus le canal quantitatif est faible.

])

#only("3",[

Fixation directe des taux d’intérêt sur les réserves

- La diminution des taux d’intérêt sur les réserves fonctionne toujours.
- Pas de piège à liquidité
- Les taux d’intérêt peuvent même être négatifs
  - les banques paient pour la fourniture de liquidités

])

])

== Le marché interbancaire


=== Équilibre sur le marché interbancaire


#grid(columns: (50%,50%),
  image("assets_4b/short_term.png", width: 80%),

  image("assets_4b/excess_reserves.png", width: 100%)
)

Le taux d’intérêt sur les réserves est devenu l’instrument principal de politique monétaire. Cela découle des excédents importants (par précaution) de réserves détenus par les banques.



== Conclusion

- Les banques centrales contrôlent les taux d’intérêt grâce à plusieurs instruments de politique monétaire.
- De nos jours, elles se concentrent sur la fixation du taux d’intérêt sur le marché interbancaire.
- Le contrôle des taux d’intérêt par la croissance monétaire est moins efficace car les banques privées ne prêtent pas suffisamment et détiennent d’énormes quantités de réserves à la banque centrale.
- Les taux d’intérêt sur les réserves détenues par les banques commerciales à la banque centrale sont devenus l’instrument principal de la banque centrale.
- … Cela dit, lors des crises (financières, covid), des mesures non conventionnelles tendent à revenir au premier plan.
  - Par exemple, la quantitiative easing (l'achat d'actifs risqués par la BC), vise moins à augmenter la quantité de monnaie qu'à réduire le risque encouru par les banques donc à restaurer leur capacité à prêter.
