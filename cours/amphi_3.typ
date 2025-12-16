#import "@preview/touying:0.5.3": *
#import "@preview/fontawesome:0.3.0": *
#import "quarto_theme.typ": *

#show: clean-theme.with(
  aspect-ratio: "16-9",
)

#title-slide(
  title: [Offre Agrégée],
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


== Un vieux débat

#block[

  #set text(18pt)

On a vu que la demande agrégée répondait à des chocs et que l'on pouvait même la stimuler par des dépenses gouvernemententales...

... mais naturellement on ne peut pas produire tout ce que les gens veulent.

#pause

🤔 Pourquoi ?

#pause

Si la quantité produite est déjà optimale, augmenter la demande ne fera qu'augmenter les prix.

#pause

🤔 Mais si les prix n'augmentaient pas ? Est-ce que la production s'ajusterait?

#pause

Deux options:

- soit les firmes sont déjà à leur capacité maximale: les marchés sont en déséquilibre, il faut une autre théorie#footnote[Certains économistes (Patinkin, Benassy, Malinvaud...) ont essayé de développer une théorie du déséquilibre. Sans succès a l'époque.]
- soit il existe un facteur inutilisé (capital, travail) et les firmes peuvent produirent plus

]

== La grande dépression

#figure(
    image("assets_3/hungry_lion.png", height:60%),
  caption: [Taux de chômage aux États-Unis en  1932: 23.6%]
)

Au lendemain de la crise de 1929, il y avait de nombreux travailleurs près à être employés.

Il a fallu 40 ans aux économistes pour réconcilier ce fait avec un modèle macroéconomique d'équilibre. Il a notamment fallu modéliser la _concurrence imparfaite_ et la _rigidité des prix_.

= Concurrence imparfaite

== Structures de marché

Dans un cours classique de microéconomie#footnote[Ou d'économie industrielle pour aller plus loin] on voit plusieurs modèles de structures de marché :

- Concurrence parfaite : chaque entreprise est un preneur de prix
- Monopole : l’entreprise a un certain pouvoir de marché
- Duopole : chaque entreprise prend en compte les décisions de l’autre entreprise (Bertrand, Cournot)
- Interactions stratégiques : théorie des jeux

Dans notre contexte, nous utiliserons une structure qui se situe quelque part entre la concurrence parfaite et le monopole #strong[: concurrence monopolistique];.

== Comportement de fixation des prix

Nous voulons utiliser un modèle de tarification optimale pour étudier ce qui se passe lorsque les entreprises ne peuvent pas s’ajuster immédiatement.

#pause

Pourquoi pas la #strong[concurrence parfaite] ?

- Le prix de vente $p = m c$ est indépendant de la demande
- Toutes les entreprises facturent leur coût marginal $m c$
- La quantité que les entreprises peuvent produire à leur coût marginal est indépendante du prix global.

Ce n’est pas utile pour dériver la courbe de l’offre agrégée. Mais ce serait un modèle de l’équilibre à long terme.

== Comportement de fixation des prix


La dépendance de l’offre agrégée par rapport aux prix implique une certaine forme de pouvoir de marché des entreprises. 

#pause

#strong[Tarification monopolistique] :

- Un monopole fait face à une demande élastique $y (p)$ avec un coût de production linéaire $m c$
- Elle maximise le profit en fixant le bon prix : $max_p y (p) p - w y (p)$
- Résultat : l’entreprise facture $p = (1 + mu) "mc"$ où $mu$ dépend de l’élasticité de la demande.
- $mu$ est une marge par rapport aux coûts de production (le _markup_)

C’est mieux, mais comment capturer le fait que les prix s’ajustent imparfaitement s’il n’y a qu’un seul producteur et un seul prix ?

== Comportement de fixation des prix

La *concurrence monopolistique* est une structure de marché où :

- De _nombreux producteurs_ ($N>>1$) qui prennent les prix comme donnés mais n’interagissent pas directement
- Ils produisent des biens qui sont des _substituts imparfaits_ (c’est-à-dire que les consommateurs veulent en consommer un peu de chacun)
- Par conséquent, chaque producteur a un peu de #emph[pouvoir de marché];, car il peut facturer un prix plus élevé sans perdre immédiatement tous les consommateurs
- … et applique un markup $mu$ sur le coût de production $p = (1 + mu) m c$ un peu comme un monopole
- … le markup dépend (négativement) de l’élasticité de la demande #footnote[demande parfaitement élastique: consommateurs indifférents à remplacer un bien par un autre] et (négativement) de l’intensité de la concurrence (le nombre d’entreprises)#footnote[lors des la PC3, vous verrez une façon standard de modéliser la concurrence monopolistique]

== Comportement de fixation des prix : Concurrence monopolistique

Les markups sont une façon de mesurer la compétitivité des industries.

#figure(
  table(
    columns: 3,
    align: (center,center,center,),
    table.header([], [Fabrication], [Services],),
    table.hline(),
    [États-Unis], [28%], [36%],
    [Zone euro], [18%], [56%],
    [France], [15%], [26%],
    [Allemagne], [16%], [54%],
    [Italie], [23%], [87%],
  ),
  caption: "Markups mesurés en 2018"
)

A noter: les markups ne sont pas la  pas la seule mesure de la compétitivité. Par exemple, une industrie pourrait avoir des markups très faibles, mais des coûts excessifs, résultant d’un manque de concurrence.

== Markups : UE vs.~États-Unis

#figure(
  grid(columns:2,
    image("assets_3/philipon_telecoms.png", width: 100%),
    image("assets_3/philipon_markups.png", width: 100%)
  )
)


De Thomas Philippon, #emph[The Great Reversal. How America Gave up on Free Markets];, 2019

= L'économie de l'offre

== Salaires et prix à la consommation

Nous souhaitons comprendre le comportement des entreprises… dans un environnement macroéconomique

- Les entreprises fixent des prix sur les marchés des biens
- Les entreprises embauchent des travailleurs sur le marché du travail

Les deux sont interdépendants :

- Les travailleurs avec des salaires plus élevés augmentent la demande de biens de consommation
- Des prix plus élevés incitent les travailleurs à demander des augmentations de salaire

== Salaires et prix à la consommation

#columns(2,[

#figure(
  image("assets_3/wage_price_spiral.png", width: 100%),
  caption: "Croissance du salaire horaire et des prix à la consommation, États-Unis", 
  
)

#colbreak()

Il existe une corrélation évidente entre le coût de la vie et les salaires.

Dans les années 60 et 70, l’inflation des prix et l’inflation des salaires augmentaient #emph[ensemble];.

])




== La spirale de l’inflation


#columns(2, [

#figure(
  image("assets_3/spiral_diagram.png", width: 90%),
  caption: "Croissance des salaires et des prix à la consommation, États-Unis", 
  
)

#colbreak()



Cela a conduit les économistes de l'époque à croire qu’il existait une spirale inflation salariale / prix…

- les prix augmentent
- $arrow.r.double$ les travailleurs demandent des salaires plus élevés
- $arrow.r.double$ les coûts de production augmentent
- $arrow.r.double$ les prix augmentent, ….

])


== La spirale de l’inflation

#columns(2, [

#figure(
    image("assets_3/reagan.png", width: 90%),
    caption: "Reagan contre la spirale de l’inflation"
)




…Et préconiser des mesures politiques pour limiter l’inflation

- Nixon : 1970, gel des prix sur les salaires et les prix
- en vain

Cette inflation s’est arrêtée avec le plan Volcker

- La Fed a augmenté les taux d’intérêt de 17% à 20%
- l’inflation a été maîtrisée au prix d’une profonde récession en 1982/1983

])

== La spirale de l’inflation

#columns(2, [

#figure(
  image("assets_3/warhol_spiral.png", width: 60%),
  // caption: ""
  
)

#colbreak()
De nos jours, on estime que les boucles salaire-prix incontrôlées sont peu probables

- les agents anticipent correctement l’inflation future
- ils intègrent ces attentes dans la fixation des salaires et des prix
- lorsque tous les marchés sont en équilibre, l’inflation retourne vers l’équilibre

])


== Les entreprises, les consommateurs et les travailleurs

*Objectif*: Établir pourquoi même si les marchés des biens sont #emph[à l’équilibre];, les entreprises monopolistiques choisissent de produire davantage lorsque les prix augmentent.


Pour cela, il faut comprendre comment les entreprises intéragissent sur:
- le marché des biens
- le marché du travail

== Marché des biens

Supposons que les entreprises produisent en utilisant la main-d’œuvre $L$ louée au salaire horaire $W$ à l’aide d’une fonction de production simple $ Y = L $

Le _coût marginal_ de production d’une unité est simplement $W$.

Sous la concurrence monopolistique, le _prix optimal_ fixé par les entreprises est donc :

$ #box(stroke: black, inset: 3pt, [$ P^star.op = (1 + mu) W $]) $

où $mu$ est un markup qui mesure l’intensité de la concurrence, comme vu avant.

== Marché du travail

=== Quel est le coût des travailleurs?

Pour comprendre le coût d'embaucher des travailleurs, nous examinons le #emph[marché du travail]

Que savons-nous avec certitude?

- le coût est plus élevé lorsque les prix agrégés sont plus élevés
  - car les travailleurs demandent des salaires plus élevés
- le coût est plus élevé lorsque la quantité de travail est plus élevée
  - car les travailleurs n’aiment pas travailler autant…

Essayons de modéliser cela.

#pagebreak()

// === Comment expliquer le chômage théoriquement?

// #columns(2,[


// #strong[Nouvelle synthèse néoclassique]

// Les ménages choisissent rationnellement la quantité de travail qu’ils fournissent#footnote[Dans les théories antérieures, dites de la _synthèse néoclassique_, le chômage était un phénomène _involontaire_, c'est à dire qu'il n'était pas cohérent (dans le modèle) avec l'optimisation des agents.]

// - arbitrage entre loisir et travail
// - les variations de l’offre de travail sont #emph[microfondées] en utilisant les préférences des travailleurs
// - marché du travail en équilibre
// - pas de chômage involontaire

// #colbreak()

// #strong[Théorie de la recherche]

// Développements plus récents :

// - par Mortensen, Pissarides, Diamond, …
// - les travailleurs et les employeurs recherchent constamment une correspondance
// - le manque de bonnes correspondances est expliqué par le modèle
// ])

== Marché du travail

=== Offre de travail


#columns(2,[

#image("assets_3/optimization.png", width:80%)

#colbreak()
Un travailleur choisit entre : 

- consommer un panier de biens $C$ au niveau de prix $P$
- profiter du temps libre $U = 1 - L$

Nous pouvons écrire la contrainte budgétaire : $ W 1 gt.eq P C + W U + Delta A $ où $Delta A$ est la variation nette de la richesse.

L’utilité à maximiser est$ V (C , u) = log (C) - xi (1-U)^(1 / xi) $

])

== Marché du travail

=== Offre de travail


Le résultat de l’optimisation donne pour l'ensemble des travailleurs#footnote[Pour obtenir le résultat suivant, il faut aussi utiliser la condition d'aggrégation $C=Y=L$]:

$ #box(stroke: black, inset: 3pt, [$ L^S = (W / P)^xi $]) $

L’offre de travail est une fonction croissante du salaire #emph[réel];.

- elle augmente lorsque les salaires augmentent
- elle diminue lorsque le niveau des prix augmente

Le paramètre $xi$ est l’élasticité de l’offre de travail au salaire réel

== Marché du travail

=== Coût du travail

La dernière relation peut être inversée pour obtenir le salaire que les entreprises doivent proposer pour embaucher $L$ travailleurs :

$ W (L) = P L^(1 / xi) $

Nous voyons clairement que le salaire d’équilibre est :

- proportionnel au niveau des prix
- croissant en fonction du nombre de travailleurs

Face à une demande plus élevée, toutes les entreprises pourront produire davantage, mais feront face à des coûts croissants à mesure que les travailleurs deviendront plus chers.

== Marché du travail

=== Le lien salaire-prix
<le-lien-salaire-prix>
Rappelons la fonction de production $Y = L$, de sorte que $W (L) = W (Y)$.

Résumons ce que nous avons jusqu’à présent :

- Marché des biens :
  - prix optimal : $P^star.op = (1 + mu) W (Y)$
- Marché du travail
  - salaire horaire : $W (Y) = P Y^xi$

Comment ces deux marchés sont-ils liés? Quel type de dynamique créent-ils?

= L’équilibre naturel

== L’équilibre naturel

#strong[Équilibre naturel] : niveau de production lorsque tous les prix sont flexibles ou ont eu suffisamment de temps pour s’ajuster. C'est aussi l'équilibre de long terme.

Ici, cela signifie que le prix optimal $P^star.op$ est égal au niveau général des prix $P$.

#pause 
On peut écrire : $ P = (1 + mu) underbrace(P Y^xi, W (Y)) $

Ce qui donne : $ 1 = (1 + mu) Y^(1 / xi) $

Cette équation détermine la production d’équilibre $Y$. 

== Production naturelle

Le niveau de production naturelle est : $ #box(stroke: black, inset: 3pt, [$ Y^(n t) = (frac(1, 1 + mu))^xi $]) $

#pause

Remarque:
- La production d'équilibre diminue avec les markups $mu$. 
  - intuition: chaque entreprise est en monopole partiel et sa stratégie optimale consiste à rationner le marché pour augmenter les prix et les bénéfices
- La production est indépendante des prix…
  - ils sont indéterminés


== Offre agrégée de long terme

#grid(columns: 2,
    figure(
    image("assets_3/lras.png"),
    caption: [Offre agrégée]
  ) 
  ,[
  - *Production naturelle*: offre avec des prix flexibles
    - est représentée comme une ligne verticale dans le plan $(pi , y)$
    - bonne description lorsque les prix ont eu le temps de s’ajuster
    - c'est l'offre à long terme     (LRAS#footnote[LRAS: Long run aggregate supply.])
  - Lorsque les prix sont parfaitement flexibles, les politiques de demande sont inefficaces
    - soutenir la demande déplace la courbe de demande vers la droite
    - les prix absorbent toute la demande excédentaire
    - seule l'inflation augmente
  ]
)

== offre agrégée à long terme

#grid(columns: 2,[

#figure(
  image("assets_3/as.png"),
  caption: "LRAS"

)
],
[
Deux eux cas extrêmes :
- prix constants
  - aucune contrainte d’offre
  - une façon de penser aux politiques de demande
- prix parfaitement flexibles
  - courbe verticale
  - aucune importance des prix

Pouvons-nous modéliser une situation où il y a un ajustement limité des prix? 
- c’est-à-dire une relation positive entre l’inflation et la production à court terme?
- c'est-à-dire une courbe d'offre globale croissante?

])


= Rigidités nominales

== Rigidités nominales

Pour nous éloigner de l’équilibre naturel, nous avons besoin de #strong[frictions] soit dans le marché des biens, soit dans le marché du travail.

Explications les plus courantes :

- prix rigides:
  - les entreprises ne peuvent pas ajuster les prix librement#footnote[C'est l'hypothèse qu'on développe dans la PC3.]
- salaires rigides :
  - le marché du travail n’est pas en équilibre
- mauvaise perception :
  - les entreprises ajustent les prix librement mais n’utilisent pas les bonnes informations

Hypothèse centrale des modèles de la synthèse néo-classique :
- certaines _rigidités nominales_ ont des effets réels

== Rigidité des prix


- Si les prix étaient flexibles, ils changeraient tout le temps
  - Les prix des actions sont mis à jour en continu (LSE : 126 microsecondes)
- Il existe des statistiques sur les changements de prix : ils sont rigides#footnote[En anglais: sticky prices.] (voir tableau ci-dessous)
  - Fréquence mensuelle des changements de prix : proportion des prix qui sont ajustés chaque mois
  - Durée moyenne des prix : temps moyen nécessaire pour réviser un prix

#table(
  columns: 3,
  align: (center,center,center,),
  table.header([], [Zone euro (1996-2000)], [États-Unis (1998-200)],),
  table.hline(),
  [Fréq mensuelle des changements de prix], [15,1%], [21,5%],
  [Durée moyenne des prix], [13,0 mois], [9,6 mois],
)


== Quels prix sont les plus rigides?

#figure(
  image("assets_3/sectoral_spending.png", height: 80%), caption: "Dépenses sectorielles et rigidité des prix"
)


== Prix rigides

=== fixation des prix échelonnée.

- Nous modéliserons la situation où seulement une fraction $omega in [0 , 1]$ des entreprises a la possibilité d’ajuster leurs prix à chaque période

- Les biens sont vendus à deux prix différents :

  - $P_(t - 1)$ : ancien prix, toujours utilisé par les entreprises qui n'ont pas ajusté
  - $P_t^star.op$ : nouveau prix par les entreprises qui ajustent

- Ensuite, nous avons le prix d’un panier de consommation qui est une moyenne des deux prix#footnote[Ce cadre théorique s'appelle "fixation des prix échelonnée" ou "staggered price setting" et est du à Calvo.]

  - $P_t = P_(t - 1)^((1 - omega)) (P_t^star.op)^omega$

#pagebreak()

=== calculs

#block[

#set text(18pt)
Revenons à la décision de tarification optimale : $ P_t^star.op = (1 + mu) overbrace(P_t Y_t^(1 / xi), upright("Coût de la main-d’œuvre")) $

Maintenant, à l’équilibre, les nouveaux prix fixés par les entreprises optimisantes modifient partiellement le prix des paniers de consommation (et le pouvoir d’achat des travailleurs) : $ P_t^star.op = (1 + mu) underbrace(P_(t - 1)^((1 - omega)) (P_t^star.op)^omega, P_t) Y^(1 / xi) $

Nous pouvons réécrire : $ (P_t^star.op / P_(t - 1))^(1 - omega) = (1 + mu) Y_t^(1 / xi) arrow.l.r.double Y_t = (frac(1, 1 + mu))^xi (P_t^star.op / P_(t - 1))^(xi (1 - omega)) $

]

#pagebreak()

=== Production en équilibre

Le ratio $P_t^star.op / P_(t - 1)$ fait apparaître le prix optimal au lieu de l'indice $P_t$. En réécrivant la formule de la moyenne des prix comme $P_t^star.op / P_(t - 1) = (P_t / P_(t - 1))^(1 / omega)$, nous obtenons une version plus agréable :

$ Y_t = (frac(1, 1 + mu))^xi (P_t / P_(t - 1))^(xi frac(1 - omega, omega)) $

Ou, en fonction de l’inflation : $ #box(stroke: black, inset: 3pt, [$ Y_t = (frac(1, 1 + mu))^xi (1 + pi_t)^(xi frac(1 - omega, omega)) $]) $

Cette équation établit une relation positive entre l’inflation et la production.


=== Calculs


Dans la dernière équation, nous reconnaissons la production naturelle : $Y_t^(n t) = (frac(1, 1 + mu))^xi$

$ Y_t = Y^(n t) (1 + pi_t)^(xi frac(1 - omega, omega)) $

Prenez les logarithmes pour obtenir une équation linéaire : $ y_t - y_t^(n t) = xi frac(1 - omega, omega) pi_t $

En posant $kappa = 1 / xi frac(omega, 1 - omega)$, on obtient notre version de la courbe de Phillips

$ #box(stroke: black, inset: 3pt, [$ kappa (y_t - y_t^(n t)) = pi_t $]) $

#pagebreak()

=== Courbe de Phillips 

#grid(columns: 2,
  figure(
    image("assets_3/session_32.png"),
    caption: "Courbe de Phillips (1958)"
  ),
  
[
  
  À l’origine, la courbe de Phillips était formulée comme une relation négative entre l’inflation et le chômage.

  ~

  Le chômage est évidemment lié au travail et le travail à la production 
  
  - dans notre modèle $U = 1 - L = 1 - Y$
  
])


== Notre courbe de l’offre agégée

Nous avons obtenu la courbe d'offre agrégée : $ pi_t = kappa (y_t - y_t^(n t)) $

avec $ kappa = 1 / xi frac(omega, 1 - omega) $

où $omega$ est la fraction d’entreprises qui peuvent optimiser leurs prix.

Cette formulation englobe :

- l’offre agrégée à long terme : lorsque $omega = 1$
- les prix rigides : lorsque $omega = 0$
- tous les cas intermédiaires

== Notre courbe de l’offre agégée


En cours de route, nous avons fait quelques simplifications par rapport au cadre standard:

- on a omis les chocs de productivité
  - nous les réintroduirons comme chocs dans $y_t^(n t)$
- on n'a incorporé aucune "anticipation" dans le comportement des entreprises. en principe, elles devraient
  - faire des prévisions de prix rationnelles pour fixer leurs prix
  - maximiser leur profit intertemporel
- en fonction du choix de modélisation on on obtient des termes dans la courbe de Phillips en:
  - $pi_(t - 1)$ si optimisation statique et extrapolation du trend ($E_t pi_(t + 1) = pi_t$)
  - $pi_(t + 1)$ si optimisation dynamique et anticipations rationnelle (modèle standard)


== Prix rigides

=== Intuition

Supposons que les prix partent du niveau d’équilibre à long terme

- Un choc crée une pression inflationniste#footnote[Pression inflationniste: la courbe de demande se déplace vers la droite par rapport à la courbe d'offre.] (par exemple, la banque centrale baisse les taux d’intérêt)
- Les prix devraient augmenter
- Mais les entreprises ne peuvent pas ajuster facilement leurs prix
- Au lieu d’augmenter leurs prix, elles produisent davantage
- Et embauchent plus de travailleurs
- La production est augmentée et le chômage est réduit

Nous avons vu dans les diapositives précédentes qu’il est possible de donner un sens rigoureux à cette série d’événements.

= Salaires rigides

== Salaires rigides

Il existe une théorie alternative qui génère également une courbe d'offre agrégée croissante : la théorie des salaires rigides.

Si le marché du travail était sans friction, les salaires s’ajusteraient immédiatement à la hausse et à la baisse.

Mais en pratique, tant les employeurs que les employés évitent les baisses de salaire.

Il y a deux grandes façons d'expliquer pourquoi :

- les syndicats et la négociation salariale
- la théorie du salaire d’efficience


== Les salaires sont-ils rigides?

#figure(
  box(image("assets_3/sticky_wages.png", height: 80%)), caption: "Répartition des changements de salaire non nuls, travailleurs horaires\n Données US, Panel 1996 "
)

== Salaires rigides

Supposons que les salaires ne soient pas facilement renégociés à court terme. Considérez la séquence d’événements suivante :

- Un choc crée une pression inflationniste (par exemple, la banque centrale imprime de l’argent)
- Les prix ont tendance à augmenter
- Comme les salaires réels chutent, les travailleurs demandent qu’ils soient réévalués
- Mais les contrats ne sont pas facilement renégociés
- Le coût des travailleurs reste bon marché
- Les entreprises produisent davantage et augmentent l’emploi

= Mauvaise perception

== Mauvaise perception

#figure(
  image("assets_3/lucas_islands.jpg", width: 30%),
  caption: "Îles de Lucas"
)

- Bob Lucas a proposé une autre explication : les producteurs n’observent que les changements de prix des biens qu’ils vendent, et ne savent pas si les changements observés sont idiosyncratiques ou liés à l’inflation globale. Ils perçoivent mal la nature de l’inflation.
- Dans ce cadre, il a montré comment la production peut répondre à des chocs d’inflation #emph[inattendus];.

== Mauvaise perception


Supposons que les producteurs observent les prix de leur propre industrie. Ils ne réalisent pas qu’ils sont indexés sur les prix agrégés.

Voici l'intuition :

- Un choc crée une pression inflationniste (par exemple, la banque centrale imprime de l’argent)
- Les prix ont tendance à augmenter
- Les producteurs d’une industrie donnée observent des prix plus élevés dans leur secteur
- Ils croient (à tort) que leur industrie est relativement plus rentable
- Ils décident de produire davantage et d’embaucher plus de travailleurs

== Mauvaise perception

#figure(
  image("assets_3/inflation_dashboard.png", height: 60%), caption: "Tableau de bord de l’inflation"
)

Avec une transparence accrue (consultez le #link("https://www.ecb.europa.eu/stats/macroeconomic_and_sectoral/hicp/html/index.en.html")[tableau de bord];) des banques centrales occidentales, ce canal est moins pertinent de nos jours, sauf dans des conditions désordonnées.

= Conclusion

== A retenir?

- Comment les entreprises monopolistiques fixent-elles leurs prix ?
  - en fixant un markup sur leur coûts marginaux
- Qu’est-ce qui détermine le salaire horaire auquel les travailleurs sont prêts à travailler ?
  - leur revenu réel
  - leur élasticité consommation loisir

- Qu'est-ce que la production naturelle ?
  - l'équilibre en prix flexibles
  - la production de long terme
- L’intuition derrière les trois théories expliquant la courbe AS :
  - Prix rigides
  - Salaires rigides
  - Misperception

== À venir

#strong[PC: coûts de catalogue]: expliquer comment 


#strong[Amphi/PC: Fluctuations macroéconomiques] : Quels sont les chocs et comment la banque centrale et le gouvernement peuvent-y répondre ?

#strong[Amphi: Politique monétaire]: que fait la banque centrale ?
