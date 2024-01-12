// Some definitions presupposed by pandoc's typst output.
#let blockquote(body) = [
  #set text( size: 0.92em )
  #block(inset: (left: 1.5em, top: 0.2em, bottom: 0.2em))[#body]
]

#let horizontalrule = [
  #line(start: (25%,0%), end: (75%,0%))
]

#let endnote(num, contents) = [
  #stack(dir: ltr, spacing: 3pt, super[#num], contents)
]

#show terms: it => {
  it.children
    .map(child => [
      #strong[#child.term]
      #block(inset: (left: 1.5em, top: -0.4em))[#child.description]
      ])
    .join()
}

// Some quarto-specific definitions.

#show raw.where(block: true): block.with(
    fill: luma(230), 
    width: 100%, 
    inset: 8pt, 
    radius: 2pt
  )

#let block_with_new_content(old_block, new_content) = {
  let d = (:)
  let fields = old_block.fields()
  fields.remove("body")
  if fields.at("below", default: none) != none {
    // TODO: this is a hack because below is a "synthesized element"
    // according to the experts in the typst discord...
    fields.below = fields.below.amount
  }
  return block.with(..fields)(new_content)
}

#let empty(v) = {
  if type(v) == "string" {
    // two dollar signs here because we're technically inside
    // a Pandoc template :grimace:
    v.matches(regex("^\\s*$")).at(0, default: none) != none
  } else if type(v) == "content" {
    if v.at("text", default: none) != none {
      return empty(v.text)
    }
    for child in v.at("children", default: ()) {
      if not empty(child) {
        return false
      }
    }
    return true
  }

}

#show figure: it => {
  if type(it.kind) != "string" {
    return it
  }
  let kind_match = it.kind.matches(regex("^quarto-callout-(.*)")).at(0, default: none)
  if kind_match == none {
    return it
  }
  let kind = kind_match.captures.at(0, default: "other")
  kind = upper(kind.first()) + kind.slice(1)
  // now we pull apart the callout and reassemble it with the crossref name and counter

  // when we cleanup pandoc's emitted code to avoid spaces this will have to change
  let old_callout = it.body.children.at(1).body.children.at(1)
  let old_title_block = old_callout.body.children.at(0)
  let old_title = old_title_block.body.body.children.at(2)

  // TODO use custom separator if available
  let new_title = if empty(old_title) {
    [#kind #it.counter.display()]
  } else {
    [#kind #it.counter.display(): #old_title]
  }

  let new_title_block = block_with_new_content(
    old_title_block, 
    block_with_new_content(
      old_title_block.body, 
      old_title_block.body.body.children.at(0) +
      old_title_block.body.body.children.at(1) +
      new_title))

  block_with_new_content(old_callout,
    new_title_block +
    old_callout.body.children.at(1))
}

#show ref: it => locate(loc => {
  let target = query(it.target, loc).first()
  if it.at("supplement", default: none) == none {
    it
    return
  }

  let sup = it.supplement.text.matches(regex("^45127368-afa1-446a-820f-fc64c546b2c5%(.*)")).at(0, default: none)
  if sup != none {
    let parent_id = sup.captures.first()
    let parent_figure = query(label(parent_id), loc).first()
    let parent_location = parent_figure.location()

    let counters = numbering(
      parent_figure.at("numbering"), 
      ..parent_figure.at("counter").at(parent_location))
      
    let subcounter = numbering(
      target.at("numbering"),
      ..target.at("counter").at(target.location()))
    
    // NOTE there's a nonbreaking space in the block below
    link(target.location(), [#parent_figure.at("supplement") #counters#subcounter])
  } else {
    it
  }
})

// 2023-10-09: #fa-icon("fa-info") is not working, so we'll eval "#fa-info()" instead
#let callout(body: [], title: "Callout", background_color: rgb("#dddddd"), icon: none, icon_color: black) = {
  block(
    breakable: false, 
    fill: background_color, 
    stroke: (paint: icon_color, thickness: 0.5pt, cap: "round"), 
    width: 100%, 
    radius: 2pt,
    block(
      inset: 1pt,
      width: 100%, 
      below: 0pt, 
      block(
        fill: background_color, 
        width: 100%, 
        inset: 8pt)[#text(icon_color, weight: 900)[#icon] #title]) +
      block(
        inset: 1pt, 
        width: 100%, 
        block(fill: white, width: 100%, inset: 8pt, body)))
}



#let article(
  title: none,
  authors: none,
  date: none,
  abstract: none,
  cols: 1,
  margin: (x: 1.25in, y: 1.25in),
  paper: "us-letter",
  lang: "en",
  region: "US",
  font: (),
  fontsize: 11pt,
  sectionnumbering: none,
  toc: false,
  toc_title: none,
  toc_depth: none,
  doc,
) = {
  set page(
    paper: paper,
    margin: margin,
    numbering: "1",
  )
  set par(justify: true)
  set text(lang: lang,
           region: region,
           font: font,
           size: fontsize)
  set heading(numbering: sectionnumbering)

  if title != none {
    align(center)[#block(inset: 2em)[
      #text(weight: "bold", size: 1.5em)[#title]
    ]]
  }

  if authors != none {
    let count = authors.len()
    let ncols = calc.min(count, 3)
    grid(
      columns: (1fr,) * ncols,
      row-gutter: 1.5em,
      ..authors.map(author =>
          align(center)[
            #author.name \
            #author.affiliation \
            #author.email
          ]
      )
    )
  }

  if date != none {
    align(center)[#block(inset: 1em)[
      #date
    ]]
  }

  if abstract != none {
    block(inset: 2em)[
    #text(weight: "semibold")[Abstract] #h(1em) #abstract
    ]
  }

  if toc {
    let title = if toc_title == none {
      auto
    } else {
      toc_title
    }
    block(above: 0em, below: 2em)[
    #outline(
      title: toc_title,
      depth: toc_depth
    );
    ]
  }

  if cols == 1 {
    doc
  } else {
    columns(cols, doc)
  }
}
#show: doc => article(
  title: [PC7: Chocs d’Offre et de Demande],
  toc_title: [Table of contents],
  toc_depth: 3,
  cols: 1,
  doc,
)
#import "@preview/fontawesome:0.1.0": *


= QCM
<qcm>
#block[
#set enum(numbering: "1.", start: 1)
+ Quelle est la bonne réponse ?

  #block[
  #set enum(numbering: "a.", start: 1)
  + Les agents ricardiens ont une propension marginale à consommer plus basse que les agents keynésiens et les agents ricardiens réagissent au taux d’intérêt nominal.
  + Les agents ricardiens ont une propension marginale à consommer plus élevée que les agents keynésiens et les agents ricardiens réagissent au taux d’intérêt nominal.
  + Les agents ricardiens ont une propension marginale à consommer plus basse que les agents keynésiens et les agents ricardiens réagissent au taux d’intérêt réel.
  + Les agents ricardiens ont une propension marginale à consommer plus élevé eque les agents keynésiens et les agents ricardiens réagissent au taux d’intérêt réel.
  ]

+ La demande agrégée est une fonction décroissante des prix. Choisissez la justification qui correspond le mieux au modèle AS/AD vu en cours :

  #block[
  #set enum(numbering: "a.", start: 1)
  + Une inflation plus élevée correspond à des taux d’intérêt réels plus élevés, ce qui correspond à des rendements de l’ épargne plus élevés et donc à des investissements plus élevés. L’augmentation des investissement augmente finalement la production et la consommation.
  + Lorsque l’inflation est plus élevée, une baisse des taux réels incite les consommateurs ricardiens à réduire leurs dépenses et les entreprises à reporter leurs investissements. La demande diminuée des ménages ricardiens et des entreprises induit également les ménages keynésiens à consommer moins.
  + Une inflation plus élevée correspond à des taux d’intérêt nominaux plus élevés, ce qui correspond à des rendements de l’épargne plus élevés et donc à des investissements plus élevés. Un investissement plus élevé augmente finalement la production et la consommation.
  + Une fonction de demande est décroissante par définition.
  ]

+ La courbe d’offre agrégée est ascendante parce que \(choisissez la meilleure justification) :

  #block[
  #set enum(numbering: "a.", start: 1)
  + Les courbes d’offre sont ascendantes sur tous les micro-marchés.
  + Les courbes d’offre sont toujours ascendantes.
  + Des prix plus élevés permettent aux entreprises monopolistiques de réduire leur production.
  + Un niveau de prix plus élevé incite les entreprises qui ne peuvent pas ajuster leur propre prix à augmenter la production.
  ]

+ Trouvez la bonne déclaration :

  #block[
  #set enum(numbering: "a.", start: 1)
  + Les pays avec des marges plus basses ont des marchés plus concurrentiels.
  + Les pays où les marchés sont plus compétitifs ont une croissance plus élevée.
  + Des marges moyennes plus élevées signifient des prix plus flexibles.
  + La marge d’une entreprise monopolistique dépend uniquement de son coût marginal.
  ]

+ Après un choc négatif d’offre :

  #block[
  #set enum(numbering: "a.", start: 1)
  + Les achats gouvernementaux peuvent atténuer l’effet sur le chômage \(\*).
  + La banque centrale ne peut rien faire car c’est un choc réel.
  + L’économie restera en déséquilibre jusqu’à ce que le gouvernement ou la banque centrale intervienne.
  + Les entreprises devraient changer de fournisseurs.
  ]

+ Quel des cas suivants n’est pas un bon exemple de choc positif de la demande, du point de vue de l’économie européenne :

  #block[
  #set enum(numbering: "a.", start: 1)
  + Les constructeurs d’avions américains cessent d’importer des moteurs allemands et italiens et commencent à produire les leurs \(\*).
  + La fin de la Covid-19 provoque une hausse de l’optimisme des consommateurs.
  + Les réglementations en matière de crédit sont mises à jour pour faciliter l’emprunt pour tous les ménages.
  + Un nouveau type de poussette électrique bon marché devient un must-have pour tous les passionnés de mode urbaine.
  ]

+ Lequel des événements suivants est un choc d’offre positif:

  #block[
  #set enum(numbering: "a.", start: 1)
  + le gouvernment met en place une subventions pour les entreprises qui investissent dans les technologies vertes
  + pour atteindre l’objectif "zéros émissions in 2030", les entreprises sont encouragées à éviter les énergies fossiles
  + comme les voitures à essences sont interdites de circulation dans les grandes villes, les consommateurs achètent des voitures électriques
  + les prix mondiaux du pétrole augmentent à cause de la guerre en Ukraine
  ]

+ Selon la version NK du modèle AS/AD vue pendant le cours, laquelle des déclarations suivantes est vraie :
]

#block[
#set enum(numbering: "a.", start: 1)
+ Après un choc de demande temporaire, les prix augmentent, puis diminuent pour revenir à leur niveau initial.
+ Un choc de demande positif persistant affecte l’écart de production, uniquement jusqu’à ce que tous les prix aient ajusté \(\*).
+ Tout choc de demande induit une réponse d’offre opposée qui annulera finalement ses effets à long terme.
+ Les politiques de demande sont plus efficaces lorsque les prix sont plus flexibles.
]

#block[
#set enum(numbering: "1.", start: 9)
+ Quel des éléments suivants n’est pas un exemple de choc d’offre positif ?
]

#block[
#set enum(numbering: "a.", start: 1)
+ Une augmentation du prix mondial du pétrole.
+ L’invention du métier à tisser mécanique en 1785.
+ Une augmentation du nombre de migrants en âge de travailler.
+ La reprise de tous les modes de transport après la fin de l’épisode strict de confinement de la Covid-19.
]

= Exercice 2: dynamique des chocs
<exercice-2-dynamique-des-chocs>
Dans les amphis on a dérivé un modèle de la forme:

\$\$\$\$

où $pi_t$ est l’inflation, $i_t$ le taux d’intérêt nominal et $y_t$ le niveau de production. $y^(n t)$ et $theta_t$ sont respectivement des chocs exogènes, d’offre et de demande. $sigma$, $kappa$, $gamma$ sont tous des paramètres positifs.

L’équation de la Phillips Curve \(PC\_1) est obtenue en supposant qu’une fraction $omega$ des firmes n’ajustent pas leur prix, et que celles qui ajustent optimisent leur profit instantané à la date $t$.

Si au lieu de cela, on avait supposé \(comme dans le poly) que les firmes qui ne peuvent pas ajuster à la date $t$ fixent leur prix à l’avance en fonctions de leur anticipations d’inflation et si l’on suppose de plus que ces anticipations sont adaptative $E_t pi_(t + 1) = pi_t$, on obtient la courbe de phillips accélérante:

\$\$ PC\_2 \\pi\_t & \= &  \\pi\_{t-1} + \\kappa \(y\_t - y^{nt}\_t) \$\$

Enfin le modèle Néo-Keynésien standard suppose que les firmes qui n’ajustent pas en $t$ gardent leur prix de $t - 1$ et que celles qui ajustent fixent leur prix de manière à maximiser tous leur profits futures escomptés de sorte que leurs décisions dépendent de leurs anticipations. On a alors la courbe de Phillips néo-keynésienne:

\$\$ PC\_3 \\pi\_t & \= &  E\_t \\left\[ \\pi\_{t+1} \\right\] + \\kappa \(y\_t - y^{nt}\_t) \$\$

+ Pour les différentes versions de la courbe de Phillips, calculer la réponse de l’économie à un choc de demande de peristence $rho$. Faire de même pour un choc de production $rho$ de même persistence. Commenter.

+ Le critère de Taylor stipule que l’inflation \(et le reste de l’économie) a un équilibre unique non divergent si et seulement si $gamma > 1$. Pour lequels des modèles précédents ce critère est-il valide ?

= Exercice 3: offre et demande
<exercice-3-offre-et-demande>
Lire les documents en annexe et répondre aux questions suivantes:

1/ La courbe de Phillips a-t-elle disparu ? Pourqui est-il important de savoir s’il s’agit d’une relation structurelle ou d’une relation statistique ?

#block[
#callout(
body: 
[
#emph[Pourquoi elle aurait disparu:]

La courbe de Phillips est à l’origine une relation négative entre la niveau de d’inflation et le niveau du chômage. Cette relation était bien vérifiée dans les années 70 \(cf cours ou picture).

Or le graphe de The Economist, semble montrer que depuis les années 1995, le chômage évolue indépendamment de l’inflation.

Cela dit, sur le graphe XXX, on observe une forte correlation depuis 2018 qui semble même augmenter sur les sous-périodes plus récentes.

Notons que la sur l’axe des abcisses, n’est pas précisément la même sur tous les graphes. Dans le graphe de Phillips original, il s’agit du chomage. Dans les graphes suivants, on veut garder une relation de court terme, en neutralisant des variations persistantes dans le niveau du chômage. Pour le graphe XXX on regarde donc la déviation du chômageau à son niveau structurel. Dans les papiers plus récents, on utilise plutôt, comme dans le graphs YYY, la tension sur le marché du travail: c’est à dire que l’on regarde le ratio entre le nombre de chômeur, et le nombre d’emplois non pourvus. Intuitivement, c’est la même chose, dans la mesure où le nombre d’emploi à pourvoir est étroitement corrélé avec la capacité structurelle de l’économie à produire à court terme. Notons aussi que le graphe ZDY est inversé gauche droite puisqu’ il utilise le nombre de poste à pourvoir sur le nombre de chômeurs au lieu de l’inverse.

Notons que que les graphes n’indiquent pas s’il s’agit seulement d’une relation statistique \(définition??) ou d’une relation structurelle. Une relation structurelle est vérifiées dans toutes les circonstances, et peut recevoir une interprétation causale.

\(mention court-terme, long-terme)

]
, 
title: 
[
Note
]
, 
background_color: 
rgb("#dae6fb")
, 
icon_color: 
rgb("#0758E5")
, 
icon: 
fa-info()
, 
)
]
2/ Comment peut-on interpréter la courbe de Phillips nonlinéaire ? En s’inspirant de l’analyse graphique des chocs faite en cours, que peut-on en déduire sur l’efficacité des politiques de demande à court terme?

#block[
#callout(
body: 
[
Une présentation usuelle de la courbe AS/AD se présente comme:

On peut l’interpréter intuitivement de la façon suivante: Pour la partie \(presque) horizontale, le niveau de chômage, il existe des ressources non utilisées. Si besoin les firmes peuvent donc produire plus à prix \(presque) constant. A l’inverse, sur la partie verticale, l’économie est au plein emploi et ne peut produire plus sans que les prix augmentent très vite.

Traçons le diagramme AS/AD en remplaçant la courbe AS par la courbe de Phillips non-linéaire. Un choc de demande positif correspond à un déplacement de la courbe de demande vers la droite. En fonction du point d’équilibre initial, on peut alors avoir plusieurs dynamiques possibles: - si l’équilibre initial est loin du plein emploi, l’emploi augmente significativement et l’augmentation de l’inflation est modérée - si l’équilibre initial est au plein emploi, l’emploi ne bouge pas mais l’inflation augmente

Dans le deuxième cas, la politique de relance est inefficace.

]
, 
title: 
[
Note
]
, 
background_color: 
rgb("#dae6fb")
, 
icon_color: 
rgb("#0758E5")
, 
icon: 
fa-info()
, 
)
]
3/ Quels changements persistents a apporté la crise de la Covid? Quelle raison y avait-il de penser que l’inflation élevée de 2023 pourrait être controlée sans dommage ?

#block[
#callout(
body: 
[
Le graphe 3/ nous renseigne sur le comportement du marché de l’emploi en conséquence de la crise. Le chômage a d’abord augmenté brutalement, puis s’est résorbé alors que le nombre d’emploi créé par l’économie américaine augmentait. Dans le nouvel équilibre, le marché de l’emploi est donc particulièrement tendu de sorte que l’excès de demande post-covid, est principalement inflationiste.

Cette situation était un argument pour penser qu’une augmentation des taux d’intérêts réduirait l’inflation sans augmenter le chômage.

]
, 
title: 
[
Note
]
, 
background_color: 
rgb("#dae6fb")
, 
icon_color: 
rgb("#0758E5")
, 
icon: 
fa-info()
, 
)
]
4/ Quel est le point de vue de Ricardo Reis sur la courbe de Phillips ? Pourquoi David Beckworth parle-t-il de variable confondante ?

#block[
#callout(
body: 
[
Selon R. Reis, la banque centrale manipule les taux d’intérêt pour contrôler l’inflation, ce qui a pour effet secondaire d’affecter le chômage. Le mécanisme précis est expliqué dans les Tweets 2. L’augmentation des taux d’intérêt nominaux rend les actifs réels plus côuteux à détenir que les actifs nominaux. Donc les taux d’intérêts réels tendent à diminuer. Comme les taux réels baissent, la consommation, l’investissement \(précisément la demande d’investissement) baissent aussi. Ce mécanisme est a priori le même quelque soit la réaction de l’offre et du marché du travail.

#block[
#block[
#block[

#block[
#box(width: 3.17in, image("pc7_files/figure-typst/mermaid-figure-1.png"))

]

]
]
]
Si on regarde le graphe Z, on retrouve un motif familier en statistique celui d’une variable confondante: lorsqu’une variable aléatoire X cause à la fois Y et Z, on trouve une corrélation entre Y et Z, sans rapport de causalité. Par exemple, il existe une corrélation claire entre la quantité de chocolat consommée dans un pays et le nombre de prix Nobel produits par ce pays. Sauf s’il s’agit d’une anomalie statistique \(corrélation parasite), cela peut s’expliquer par le fait que le niveau de vie cause une consommation plus élevée de produits de luxe \(et de chocolat), et un système de recherche capable de produire des prix Nobel.

]
, 
title: 
[
Note
]
, 
background_color: 
rgb("#dae6fb")
, 
icon_color: 
rgb("#0758E5")
, 
icon: 
fa-info()
, 
)
]
5/ Qu’est ce qui caractérise le prix d’un actif ? En quoi est-ce pertinent pour comprendre la caractérisation par Olivier Blanchard de sa diférence avec Ricardo Reis dans les Tweets \(3) ?#footnote[on peut laisser ici de côté la référence à la théorie fiscale du niveau des prix de John Cochrane.]

#block[
#callout(
body: 
[
Un actif \(réel ou nominal) est un titre de propriété qui donne le droit à un flux de revenu \(réel ou nominal). Typiquement la valorisation d’un actif réel qui produit un dividende $d_t$ peut prendre la forme:

$ p_t = E_t [sum_(s gt.eq t)^oo 1 / (1 + r)^(s - t) d_s] $

que l’on peu aussi écrire sous la forme:

$ p_t = frac(1, 1 + r) E_t [p_(t + 1)] + d_t $

Dans un modèle keynésien standard, la courbe PC s’écrit:

$ pi_t = alpha E_t pi_(t + 1) + y_t $

avec $0 < alpha < 1$ ce qui par substitution donne la formule

$ pi_t = E_t [sum_(s gt.eq t)^oo 1 / (1 + r)^(s - t) y_s] $

formellement équivalente à la formule de valuation précédente si l’on remplace les dividendes par l’output gap $y_s$

En particulier, on voit dans la formule XYZ que les #emph[anticipations d’inflation] jouent formellement le même rôle dans la détermination de l’inflation présente que l’anticipation des prix futurs dans la détermination des prix présents. Il s’ensuit que le travail d’une banque centrale consiste en grande partie à contrôler ces anticipations d’inflations par tous les moyens disponibles \(par exemple en communiquant sur sa politique future).

Un autre caractéristique d’un actif classique est l’existence d’un marché pour cet actif. L’intéraction des acheteurs et vendeurs sur ce marché est parfaitement coordonnée par les prix.

A l’inverse O. Blanchard considère que le niveau des prix \(donc l’inflation) ne compte pas directement pour leur décisions fixation des salaires et des prix, car les firmes considèrent des prix relatifs pertinents pour eux \(leur salaires, leur prix de vente, celui des concurrents…). On ne peut donc pas coordonner les actions des firmes en agissant sur leurs anticipations d’inflation. Il faut donc pour réduire l’inflation agir directement sur les décisions des firmes pour les inciter à réduire leur prix. Cela est possible si l’on réduit la demande. Dans cette vision l’ajustement par les entreprises est un canal de transmission dû la politique monétaire.

]
, 
title: 
[
Note
]
, 
background_color: 
rgb("#dae6fb")
, 
icon_color: 
rgb("#0758E5")
, 
icon: 
fa-info()
, 
)
]
#block[
#set enum(numbering: "1.", start: 6)
+ Pourquoi le point de vue sur rigidités nominales est-il central pour distinguer un point de vue de l’autre?
]

#block[
#callout(
body: 
[
On a vu dans le cours, comment les rigidités nominales aboutissaient à une courbe AS croissante.

Schématiquement, le point de vue d’O Blanchard, est parfaitement compatible avec le graphe AS/AD. La banque centrale peut contrôler l’inflation en déplaçant l’équilibre le long de la courbe AS.

A l’inverse, en l’absence de rigidité des prix \(cf Tweets 4), la courbe AS de court terme ne suffirait pas à déterminer l’inflation puisqu’elle serait verticale. L’aspect intertemporel serait donc primordial pour déterminer l’inflation, même à court terme.

]
, 
title: 
[
Note
]
, 
background_color: 
rgb("#dae6fb")
, 
icon_color: 
rgb("#0758E5")
, 
icon: 
fa-info()
, 
)
]
#pagebreak()
= Où est passée la courbe de Phillips?
<où-est-passée-la-courbe-de-phillips>
Le graphe suivant est extrait de #emph[The Economist] \(2017):

#figure([
#box(width: 70%,image("disparition_pc.png"))
], caption: figure.caption(
position: bottom, 
[
Disparition de la Courbe de Phillips
]), 
kind: "quarto-float-fig", 
supplement: "Figure", 
)


Les graphes suivants proviennent du papier #emph[Reducing Inflation along a Nonlinear Phillips Curve] par Erin E. Crust, Kevin J. Lansing, et Nicolas Petrosky-Nadeau

#figure([
#box(width: 70%,image("inflation_without_unemployement.png"))
], caption: figure.caption(
position: bottom, 
[
Inflation et Chômage
]), 
kind: "quarto-float-fig", 
supplement: "Figure", 
)


#figure([
#box(width: 70%,image("beveridge_curve.png"))
], caption: figure.caption(
position: bottom, 
[
Courbe de Beveridge
]), 
kind: "quarto-float-fig", 
supplement: "Figure", 
)


#figure([
#box(width: 70%,image("nonlinear_phillips_curve.png"))
], caption: figure.caption(
position: bottom, 
[
Courbe Phillips Nonlinéaire
]), 
kind: "quarto-float-fig", 
supplement: "Figure", 
)


Its’ baaack. The Phillips Curve is

#figure([
#box(width: 70%,image("no_pc.png"))
], caption: figure.caption(
position: bottom, 
[
Courbe Phillips Nonlinéaire
]), 
kind: "quarto-float-fig", 
supplement: "Figure", 
numbering: "1", 
)
<fig-nopc>


#pagebreak()
= Twitter & Short Term Macroeconomics
<twitter-short-term-macroeconomics>
Le 7 août 2023, Ricardo Reis professor à London School of Economics était interviewé par David Beckworth sur le podcast #emph[Macro Musings] #footnote[https:\/\/www.mercatus.org/macro-musings/ricardo-reis-macroeconomics-financial-crises-and-recent-inflation-surge];. Le transcript de cet interview#footnote[Le transcript est généré par IA d’où certaines bizarreries de syntaxe…] a provoqué une discussion intéressante sur twitter, impliquant notamment Olivier Blanchard, ancien chef économiste du FMI, maintenant au Peterson institute.

#quote(block: true)[
Ricardo’s View of the Phillips Curve
]

#quote(block: true)[
Beckworth: Okay, one last question and then I’ll let you go, but the Phillips curve, it’s a key part of modern macro, and at least in the US, it’s come under a lot of criticism because we’ve had low inflation, low unemployment, all of the predictions of some of the big names that we would have to have this huge amount of unemployment to get to the inflation we’ve gotten to, it hasn’t happened. What is your thoughts on the Phillips curve? And maybe we should begin with, how do you view the Phillips curve? Do you view it as a reduced form relationship or a deep structural one? And then from there I guess it’s maybe easier to think about its future.
]

#quote(block: true)[
Reis: David, let me start by saying that I’m the Phillips professor at the LSE, so I have to defend the Phillips curve.
]

#quote(block: true)[
Beckworth: Okay.
]

#quote(block: true)[
Reis: I can never say it’s obsolete otherwise I would fall on the floor since my chair would become obsolete. So it’s definitely present. But with that account, let me make three observations. The first one is that, the way I understand monetary policy is, whereby tightening monetary policy, a central bank is able to bring inflation down. In the same way that when I go to the doctor with an infection with a bacteria of some kind, antibiotics are the way to kill the bacteria and cure me from that. However, a side effect, and I emphasize, let me say it slowly, a side effect of raising interest rates is that you also cause a recession. You also lead to an increase in unemployment. In the same way that a side effect of taking antibiotics is that they tend to wreak havoc with your gastrointestinal, digestive system.
]

#quote(block: true)[
Reis: Note that it is not a channel. It’s not by taking antibiotics and screwing up my intestines that I therefore kill the bacteria. No, no, it’s a side effect. Likewise, raising interest rates lowers inflation and has a side effect of unemployment, but it may not lower unemployment the same way that you may go through a course of antibiotics and be perfectly fine with your gastrointestinal system. So the fact that unemployment has not gone up, does not in any way discredit the way in which monetary policy works, does not pose a puzzle of any kind, because an increase in unemployment following a tightening of monetary policy is not something that has to happen for inflation to fall. It’s something that often happens as a side effect. So I make that point first. Second, the Phillips curve is, I think, still one of the most important concepts for any monetary policymaker precisely because if you were to say that raising interest rates brings down inflation, and you are to ignore the side effects, you would go crazy on raising and lowering interest rates in sharp ways, focusing solely on inflation.
]

#quote(block: true)[
Reis: It’s understanding that side effect, and that side effect is the Phillips curve, that when you raise interest rates, you’re going to bring down inflation, but you may also increase unemployment. That side effect is there. That makes central banking hard, monetary policy hard. That leads you to be cautious. That leads you to not destroy economies in your obsession with controlling inflation. So understanding the Phillips curve as a trade-off, as a structural trade-off, as a side effect of what happens after you raise interest rates and lower down inflation, is, I think, essential. And any central bank that told me it does not understand the Phillips curve \[inaudible\] in the central bank, is one that should resign immediately because it would be a very dangerous central bank in that sense.
]

#quote(block: true)[
Reis: However, and third answer now here, the Phillips curve, however, and as it is, as indeed it was written by Bill Phillips originally, my predecessor here at the LSE many decades ago, as an empirical relation that says that you have a correlation between inflation and employment, or even as a causal relation, that it’s through raising unemployment, they lower inflation, is a deeply flawed empirical as well as theoretical claim, precisely because it is a side effect. And when that happens sometimes, but not always, precisely because it’s not the causal mechanism, it very often happens that you have inflation going up and down with unemployment not going up and down in that way. That is why when you look at a correlation between inflation and employment, you end up with relatively low values.
]

#quote(block: true)[
Reis: It is also why when Bill Phillips did those correlations, under some circumstances, having to do with monetary-fiscal regimes, he found very nice Phillips curves, but under other circumstances you wouldn’t find them. Just like, David, under some circumstances, antibiotics mess up your stomach and some others, it doesn’t. So that Phillips curve is seen as an ironclad law of what happens when employment and inflation moves, seen as a causal part of the mechanism when inflation goes down. That, indeed, is, I think, something that does not receive a lot of support in theory or in the data. But the Phillips curve has a very important trade off as what you can do, is why you have to be careful in controlling inflation, that is absolutely essential for any central bank.
]

#quote(block: true)[
Beckworth: Well, let me tell you how I think about it, and correct my understanding here. I view it more as a reduced form relationship. It’s reflecting some other third variable, which is aggregate demand, which is being shaped by monetary policy. So aggregate demand can affect inflation, it can affect unemployment, and so policy is moving aggregate demand towards some goal and maybe it affects unemployment, maybe it affects inflation. Is that too simple of an understanding?
]

#quote(block: true)[
Reis: That’s a perfectly acceptable complementary view to the ones I was saying. It goes back a little bit to my, as a side effect, meaning you want to be monitoring employment to understand this correlation exists, because it is reflecting something going on in your body, right? You’re trying to diagnose the body of the patient. You’re trying to kill the bacteria. You know that when you do the antibiotics, it’s going to have an effect on a bunch of other things, and you want to be monitoring them, and focusing on your digestion is a very useful one, sometimes even if you’re really as triggering is whether the antibiotics are creating problems in other parts of the body, absolutely.
]

#figure([
#box(width: 70%,image("rreis_response.png"))
], caption: figure.caption(
position: bottom, 
[
Tweets \(1)
]), 
kind: "quarto-float-fig", 
supplement: "Figure", 
)


#figure([
#box(width: 70%,image("rreis_explanation.png"))
], caption: figure.caption(
position: bottom, 
[
Tweets \(2)
]), 
kind: "quarto-float-fig", 
supplement: "Figure", 
)


#figure([
#box(width: 70%,image("blanchard_response_2.png"))
], caption: figure.caption(
position: bottom, 
[
Tweets \(3)
]), 
kind: "quarto-float-fig", 
supplement: "Figure", 
)


#figure([
#box(width: 70%,image("blanchard_response_3.png"))
], caption: figure.caption(
position: bottom, 
[
Tweets \(4)
]), 
kind: "quarto-float-fig", 
supplement: "Figure", 
)





