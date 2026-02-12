
#import "@preview/mitex:0.2.4": *


= Introduction
<introduction>




== Cette session
<cette-session>
Les sources des fluctuations:

- L’équilibre
- Choc de demande agrégée
  - le court terme
  - la dynamique
- Choc d’offre

Cette sessions récapitule les deux sessions précédentes. Assurez-vous de bien comprendre l’approche générale et de développer les intuitions.

== Équilibre OA/DA

#block[

  #set text(18pt)

  - Demande Agrégée: $ y_t = theta_t - sigma gamma (pi_t - overline(pi)) $
    - #strong[mécanisme];: #emph[les presssions inflationnistes ($pi_t > overline(pi)$) poussent la banque centrale à adopter une politique monétaire restrictive, ce qui augmente le taux d'intérêt réel donc réduit la demande et la production#footnote[attention au rôle crucial de la banque centrale dans le modèle IS-MP ! Sans la banque centrale, le modèle ne dit pas comment changent les taux réels lorsque les prix augmentent.];]
  - Offre Agrégée: $ pi_t = overline(pi) + kappa (y_t - y_n^t) $
    - #strong[mécanisme];: #emph[un écart de production élevé engendre des tensions sur le marché du travail qui élèvent le salaire réel d’équilibre ; les entreprises qui le peuvent répercutent ce coût en élevant leur prix]

]

== Équilibre de long terme

- À long terme, tous les prix ont été ajustés de manière optimale et l’économie se comporte comme une économie de prix flexibles:  $ y_oo = y_oo^n (= - mu^star.op) $
- Par ailleurs, en supposant qu’à long terme $pi_oo = overline(pi)$, on a nécessairement: $ theta_oo = y_oo $ (c’est "l’offre qui détermine la demande")

== Équilibre de court terme

$ "DA": y_t = theta_t - sigma gamma (pi_t - overline(pi)) $

$ "OA": pi_t = overline(pi) + kappa (y_t - y^t_n) $

Dans ce modèle il y a:

- deux variables #strong[endogènes];#footnote[Par définition, les variables endogènes sont celles qui sont expliquées par le modèles contrairement aux variables exogènes déterminées par un mécanisme extérieur et prises comme données.];: $y_t$ et $pi_t$
- deux variables #strong[exogènes];: $theta_t$ et $y_t^n$

== Équilibre de court terme
<équilibre-de-court-terme-1>
On trouve aisément la paire (inflation $pi_t$ / output $y_t$) qui correspond aux variables exogènes ($theta_t$, $y_t^n$ ).

$ y_t = "cte"_1 + (frac(1, 1 + sigma gamma kappa)) theta_t + (frac(sigma gamma kappa, 1 + sigma gamma kappa)) y_t^n $

$ pi_t = "cte"_2 + (frac(kappa, 1 + sigma gamma kappa)) theta_t - (frac(kappa, 1 + sigma gamma kappa)) y_t^n $

Les termes entre parenthèse sont génériquement appelés "multiplicateurs":
- Ils quantifient la réaction de court terme à des chocs $dif theta_t$ et $dif y^n_t$
Ils ont bien le signe attendu. Voyons comment on peut interpréter leur effet.

== Choc de demande
<choc-de-demande>
Que représente $dif theta_t$ ? Qu’est-ce qui peut cause un déplacement négatif de la courbe de demande ?

#pause

- Un changement dans les préférences des consommateurs (désir de consommer)
- Un changement dans les anticipations des firmes et des consommateurs concernant leur revenus futurs.
- Une augmentation de l’incertitude dans les prévisions agents économiques (consommateurs, firmes)
- Une évolution des des exportations nette (changement dans la demande pour les biens domestiques, fluctuations dans le taux de change)
- Ou des mouvements de capitaux internationaux
- Un changement dans la politique de la banque centrale
- Un changement dans le niveau de dépenses du gouvernement


== Choc de demande

=== Impact

#columns(2, [

  #image(assets + "demand_shock.png")

  #colbreak()

  #only(1, [

    Un choc $dif theta_t$ sur la demande agrégée

    - Augmente immédiatement la production: $ dif y_t = (frac(1, 1 + sigma gamma kappa)) dif theta_t $
    - Augmente immédiatement l’inflation: $ dif pi_t = (frac(kappa, 1 + sigma gamma kappa)) dif theta_t $

  ])

  #only(2, [
    Les paramètres principaux sont:

    - $sigma$: la décision d’épargne investissement par les agents économiques (consommateurs et firmes)
    - $gamma$: la réaction de la banque centrale
    - $kappa$: la vitesse à laquelle les firmes ajustent leurs prix
      - (plus élevé lorsque plus de firmes ajustent)

  ])
])

== Choc de demande

=== Impact

Peut-on raconter intuitivement ce qui se passe en utilisant tous les mécanismes que l’on a vu jusqu’a présent ?

#pause

- Une augmentation de la demande agrégée pour les biens et les services
- Augmente la production
- Ce qui augmente la demande de travail
- Ce qui augmente les salaires réels (car l’offre de travail n’est pas parfaitement élastique)
- Ce qui augmente les coûts de production
- Ce qui augmente les prix de vente
  - mais pas jusqu’à annuler le choc car certaines firmes ne peuvent pas ajuster leur prix
- L’inflation des prix décourage la demande ce qui compense partiellement pour l’augmentation de la production.

== Choc de demande

=== Transition

#grid(
  columns: (40%, 55%),

  figure(
    image(assets + "demand_shock_adjustment.png"),
    caption: [Choc transitoire],
  ),
  [

    #only(1, [

      Considérons un choc de demande transitoire

      - Qui dure un certain nombre de périodes avant de disparaître
      - Les conclusions dépendent du degré de #strong[persistence]

      Lorsque plus de firmes ont eu le temps d’ajuster, la pente de la courbe AS augmente (elle est donnée par $kappa = frac(omega, xi (1 - omega))$ où $omega$ est le nombre de firmes qui ont ajusté)

    ])

    #only(2, [

      On peut décrire la #strong[dynamique de l’inflation] informellement comme suit:

      - L’inflation augmente initialement à cause du choc de demande
      - L’augmentation de l’inflation continue alors que la fraction des firmes qui ajustent augmente (rotation de la courbe AS)
      - L’inflation revient à la normale quand le choc de demande s’arrête
      - Plus les prix s’ajustent vite, plus l’nflation augmente

    ])

    #only(3, [

      Et pour la dynamique de la production ?

      - Elle augmente initialement avec la demande
      - Puis revient à la normale alors que l’effet du choc de demande s’estompe
      - Plus les prix s’ajustent vite, plus faible est l’effet sur la production

    ])

  ],
)

== Choc de demande: vérification empirique


#grid(
  columns: (50%, 50%),

  [


    #only(1, [
      Le graphe ci-contre montre l’effet d’un choc de demande "pur": un choc de politique monétaire non-anticipé.

      Il compare la réponses de plusieurs variables économiques

      - Dans les données (économétrie: estimation VAR)
      - Dans un modèle avec des rigidités nominale (DSGE)
      - Les deux ont un comportement similaire

    ])

    #only(2, [

      Et par rapport à notre modèle?

      - L’investissement et la consommation augmentent

      - L’inflation augmente à moyen terme (pas juste à l’impact)

      - Le salaire réel augmente

      - L’augmentation de la production est persistante

        - … mais il y a du capital qui lisse la production dans le temps

    ])

  ],
  [
    #figure(
      image(assets + "irf.png", height: 80%),
    )
    #block[
      #set text(12pt)
      Extrait de Nominal Rigidities and the Dynamic Effect of a Shock to Monetary Policy, Christiano, Eichenbaum and Evans, Journal of Political Economy, 2005
    ]
  ],
)


== Offre

<offre>
Un choc d’offre est un choc sur le PIB naturel $d y_t^(n t)$. Qu’est-ce qu’il représente ? Qu’est-ce qui cause un shift vers la gauche ou la droite de la courbe d’offre ?

- Les changements qui affectent le long terme (il affecte le pib naturel)
- Des changements dans les facteurs de production
- Des chocs de productivités
- Dans changement dans les markups (ou la compétitivité)
- Des changemements dans les anticipations (qui affectent la fixation des prix par les firmes)


== Choc d’Offre

#grid(
  columns: 2,

  figure(image(assets + "negative_supply_shock.png")),
  [

    #only(1, [
      Un choc $d y_t^(n t)$ sur l’offre agrégée

      - Augmente la production de: $ d y_t = (frac(sigma gamma kappa, 1 + sigma gamma kappa)) d y_t^(n t) $
      - Augmente l’inflation de: $ d pi_t = (frac(kappa, 1 + sigma gamma kappa)) d y_t^(n t) $
    ])

    #only(2, [
      Les paramètres sont les mêmes qu’avant:

      - $gamma$: réaction de la banque centrale
      - $sigma$: décision d’épargne investissment par les consommateurs et les firmes
      - $kappa$: lié à la fixation des prix par les firmes

    ])


  ],
)

== Chocs d’offre

#grid(
  columns: 2,

  figure(image(assets + "stabilization.png")),

  [


    #only(1, [
      Un choc d’offre négatif déplace la courbe OA vers la gauche

      - L’inflation augmente
      - La production diminue

      Comment le gouvernement et la BC peuvent-ils mitiger le choc ?

      - Impossible d’agir sur l’offre

    ])

    #only(2, [

      Dans notre modèle la #strong[banque centrale] est déjà incluse dans la courbe DA

      - Ce qui rend la demande plus réactive à l’inflation (plus horizontale)
      - Mais la règle MP suppose que la BC ne regarde que l’inflation
      - … ce qui est un mauvais cadre pour étudier la réponse de la BC

    ])

    #only(3, [

      Le #strong[gouvernement] peut stimuler la demande pour contrer le choc d’offre

      - Avec des politiques fiscales
      - Mais ça ne fonctionne qu’à court terme
      - … et pose quelques questions(est-ce efficace ? d’où vient l’argent ?)

    ])

  ],
)

== A retenir
<a-retenir>

#block[

  #set text(18pt)

  - Dans notre modèle, à court terme:

    - Un choc de demande positif implique que l’inflation et la production augmentent
    - Un choc d’offre positif implique une baisse de l’inflation et une augmentation de la production

  - Après un choc de demande #emph[persistant]

    - Alors que les prix s’ajustent l’augmentation initiale de la production s’inverse
    - Lorsque la demande revient à la nomale, l’inflation revient à son niveau naturel
    - IRL, les réaction de la production et de l’inflation ont aussi des lags

  - Les politiques monétaires et fiscales pevent annuler les choc de demande à court terme

  - Les chocs d’offre ne peuvent pas être directement annulés mais…

    - Les politiques de demande peuvent les #emph[accomoder] à court terme (jusqu’à ce que les prix s’ajustent)

]
