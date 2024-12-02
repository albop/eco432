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

#show raw.where(block: true): set block(
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

// Subfloats
// This is a technique that we adapted from https://github.com/tingerrr/subpar/
#let quartosubfloatcounter = counter("quartosubfloatcounter")

#let quarto_super(
  kind: str,
  caption: none,
  label: none,
  supplement: str,
  position: none,
  subrefnumbering: "1a",
  subcapnumbering: "(a)",
  body,
) = {
  context {
    let figcounter = counter(figure.where(kind: kind))
    let n-super = figcounter.get().first() + 1
    set figure.caption(position: position)
    [#figure(
      kind: kind,
      supplement: supplement,
      caption: caption,
      {
        show figure.where(kind: kind): set figure(numbering: _ => numbering(subrefnumbering, n-super, quartosubfloatcounter.get().first() + 1))
        show figure.where(kind: kind): set figure.caption(position: position)

        show figure: it => {
          let num = numbering(subcapnumbering, n-super, quartosubfloatcounter.get().first() + 1)
          show figure.caption: it => {
            num.slice(2) // I don't understand why the numbering contains output that it really shouldn't, but this fixes it shrug?
            [ ]
            it.body
          }

          quartosubfloatcounter.step()
          it
          counter(figure.where(kind: it.kind)).update(n => n - 1)
        }

        quartosubfloatcounter.update(0)
        body
      }
    )#label]
  }
}

// callout rendering
// this is a figure show rule because callouts are crossreferenceable
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
    block(below: 0pt, new_title_block) +
    old_callout.body.children.at(1))
}

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
      if(body != []){
        block(
          inset: 1pt, 
          width: 100%, 
          block(fill: white, width: 100%, inset: 8pt, body))
      }
    )
}



#let article(
  title: none,
  subtitle: none,
  authors: none,
  date: none,
  abstract: none,
  abstract-title: none,
  cols: 1,
  margin: (x: 1.25in, y: 1.25in),
  paper: "us-letter",
  lang: "en",
  region: "US",
  font: "linux libertine",
  fontsize: 11pt,
  title-size: 1.5em,
  subtitle-size: 1.25em,
  heading-family: "linux libertine",
  heading-weight: "bold",
  heading-style: "normal",
  heading-color: black,
  heading-line-height: 0.65em,
  sectionnumbering: none,
  toc: false,
  toc_title: none,
  toc_depth: none,
  toc_indent: 1.5em,
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
      #set par(leading: heading-line-height)
      #if (heading-family != none or heading-weight != "bold" or heading-style != "normal"
           or heading-color != black or heading-decoration == "underline"
           or heading-background-color != none) {
        set text(font: heading-family, weight: heading-weight, style: heading-style, fill: heading-color)
        text(size: title-size)[#title]
        if subtitle != none {
          parbreak()
          text(size: subtitle-size)[#subtitle]
        }
      } else {
        text(weight: "bold", size: title-size)[#title]
        if subtitle != none {
          parbreak()
          text(weight: "bold", size: subtitle-size)[#subtitle]
        }
      }
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
    #text(weight: "semibold")[#abstract-title] #h(1em) #abstract
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
      depth: toc_depth,
      indent: toc_indent
    );
    ]
  }

  if cols == 1 {
    doc
  } else {
    columns(cols, doc)
  }
}

#set table(
  inset: 6pt,
  stroke: none
)
#import "@preview/fontawesome:0.1.0": *

#show: doc => article(
  title: [PC4: Offre et Demande à court terme.],
  toc_title: [Table of contents],
  toc_depth: 3,
  cols: 1,
  doc,
)

= Exercice 1: Macroéconomie de court terme
<exercice-1-macroéconomie-de-court-terme>
Trouver l’unique bonne réponse pour les aux questions suivantes, en raisonnant dans le cadre du modèle AS/AD.

#block[
#set enum(numbering: "1.", start: 1)
+ La demande agrégée est une fonction décroissante de l’inflation. Choisissez la justification qui correspond le mieux au modèle AS/AD vu en cours :

  #block[
  #set enum(numbering: "a.", start: 1)
  + Une inflation plus élevée correspond à des taux d’intérêt réels plus élevés, ce qui correspond à des rendements de l’ épargne plus élevés et donc à des investissements plus élevés. L’augmentation des investissement augmente finalement la production et la consommation.
  + Lorsque l’inflation est plus élevée, la réaction de la banque centrale implique une hausse des taux réels qui incite les consommateurs ricardiens à diminuer leurs dépenses et les entreprises à reporter leurs investissements. La demande diminuée des ménages ricardiens et des entreprises induit également les ménages keynésiens à consommer moins.
  + Une inflation plus élevée correspond à des taux d’intérêt nominaux plus élevés, ce qui correspond à des rendements de l’épargne plus élevés et donc à des investissements plus élevés. Un investissement plus élevé augmente finalement la production et la consommation.
  + Une fonction de demande est décroissante par définition.
  ]
]

#block[
#callout(
body: 
[
#block[
#set enum(numbering: "a.", start: 1)
+ faux. Une inflation plus élevée correspond à un taux réel plus #emph[bas];. Aussi le raisonnement proposé mélange demande d’investissement et offre d’investissement (qui n’est pas déterminée par notre modèle de court terme)
+ #strong[vrai];. C’est exactement ça. Notons bien que si la banque centrale de réagissait pas, une hausse de l’inflation baisserait les taux réels.
+ faux. D’une part l’épargne est déterminée par les taux réels, pas nominaux. D’ autre part la hausse des taux provoque une baisse de la production.
+ faux. La demande agrégée n’est pas une fonction de demande normale. Il s’agit de l’équilibre implicite qui provient de la courbe IS.
]

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
)
]
#block[
#set enum(numbering: "1.", start: 2)
+ La courbe d’offre agrégée est croissante parce que (choisissez la meilleure justification) :

  #block[
  #set enum(numbering: "a.", start: 1)
  + Les courbes d’offre sont croissantes sur tous les micro-marchés.
  + Les courbes d’offre sont toujours ascendantes.
  + Des prix plus élevés permettent aux entreprises monopolistiques de réduire leur production.
  + Un niveau de prix plus élevé incite les entreprises qui ne peuvent pas ajuster leur propre prix à augmenter la production.
  ]
]

#block[
#callout(
body: 
[
#block[
#set enum(numbering: "a.", start: 1)
+ faux. L’offre agrégée peut conceptuellement être verticale, même si les marchés de chacun des biens à une pente d’offre normalement pentue.
+ faux. L’offre agrégée n’est pas une fonction d’offre normale normale.
+ faux. L’ajustement des prix par les firmes tant à limiter les variations de production. Si elles ajustaient toutes la courbe d’offre serait verticale.
+ #strong[vrai];. C’est le mécanisme qui fait que la production de certaines firmes augmentent lorsque la demande augmente, au lieu que ce soient seulement les prix qui servent de valeur d’ajustement. On a vu que l’ intuition reste vraie quand une fraction seulement des firmes peut ajuster.
]

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
)
]
#block[
#set enum(numbering: "1.", start: 3)
+ Trouvez la bonne déclaration :

  #block[
  #set enum(numbering: "a.", start: 1)
  + Les pays avec des marges plus basses ont des marchés plus concurrentiels.
  + Les pays où les marchés sont plus compétitifs ont une croissance plus élevée.
  + Des marges moyennes plus élevées signifient des prix plus flexibles.
  + La marge d’une entreprise en concurrence monopolistique dépend uniquement de son coût marginal.
  ]
]

#block[
#callout(
body: 
[
#block[
#set enum(numbering: "a.", start: 1)
+ #strong[vrai]
+ non, ce n’ est pas si simple. On a vue que la concurrence est moins forte aux États-Unis, mais la croissance y est plus faible qu’en France.
+ non
+ non. le lien entre coût marginal, marge et prix est par définition de la forme $p = (1 + mu) m c$. La marge $mu$ dépend de l’élasticité de la demande qui elle-même dépend de l’ environnement compétitif.
]

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
)
]
#block[
#set enum(numbering: "1.", start: 4)
+ Après un choc négatif d’offre :

  #block[
  #set enum(numbering: "a.", start: 1)
  + Les achats gouvernementaux peuvent atténuer l’effet sur le chômage.
  + La banque centrale ne peut rien faire car c’est un choc réel.
  + L’économie restera en déséquilibre jusqu’à ce que le gouvernement ou la banque centrale intervienne.
  + Les entreprises devraient changer de fournisseurs.
  ]
]

#block[
#callout(
body: 
[
#block[
#set enum(numbering: "a.", start: 1)
+ #strong[oui];, le gouvernemnt peut en effet augmenter la demande en augmentant les dépenses. Cela stabilise le chômage au prix d’une inflation plus haute
+ non, la banque centrale peut accomoder le choc, en déplacer la demande de manière à neutraliser son effet sur la production et/où l’inflation
+ non, s’il n’ est pas persistent l’effet du choc se résorbe de lui-même à mesure que les prix s’ajustent
+ non, pas de rapport
]

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
)
]
#block[
#set enum(numbering: "1.", start: 5)
+ Lequel des cas suivants est un choc négatif de demande ?

  #block[
  #set enum(numbering: "a.", start: 1)
  + Les déboires des sous-traitants de Boeing poussent la société à importer des moteurs allemands et italiens à la place des moteurs Pratt & Whitney
  + La fin de la Covid-19 provoque une hausse de l’optimisme des consommateurs.
  + Les réglementations en matière de crédit sont mises à jour pour limiter le surendettement
  + Un nouveau type de poussette électrique bon marché devient un must-have pour tous les passionnés de mode urbaine.
  ]
]

#block[
#callout(
body: 
[
#block[
#set enum(numbering: "a.", start: 1)
+ faux. cela augmente la demande étrangère pour la production domestique. C’est un choc de demande positif.
+ faux. les consommateurs plus optimistes pensent que leur consommation va augmenter dans le future. Pour lisser leur consommation dans le temps, ils augmentent donc leur consommation présente. (l’optimisme peut-aussi réduire leur perception du risque future et leur besoin d’une épargne de précaution, avec le même effet)
+ #strong[vrai];. la réglementation sur le surendettement empêche certains ménages de s’endetter pour consommer donc c’est un choc de demande négatif (même s’il peut être désirable)
+ faux. L’évolution des préférences entraîne une demande des consommateurs pour ce type de produit. C’est un choc de demande positif.
]

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
)
]
#block[
#set enum(numbering: "1.", start: 6)
+ Lequel des événements suivants est un choc d’offre positif:
  #block[
  #set enum(numbering: "a.", start: 1)
  + les prix mondiaux du pétrole augmentent à cause de la guerre en Ukraine
  + pour atteindre l’objectif "zéros émissions in 2030", les entreprises sont encouragées à éviter les énergies fossiles
  + le gouvernment met en place une subventions pour les entreprises qui investissent dans les technologies vertes
  + comme les voitures à essences sont interdites de circulation dans les grandes villes, les consommateurs achètent des voitures électriques
  ]
]

#block[
#callout(
body: 
[
#block[
#set enum(numbering: "a.", start: 4)
+ faux. choc d’offre négatif
+ faux. c’est équivalent à un renchérissement du prix des énergies fossiles donc à un choc d’offre négatif
+ #strong[vrai];. sans que le prix des autres énergie soient affectées, la production de technologies vertes est moins chère. C’est un choc d’offre positif.
+ faux. un choc de demande positif pour les voitures électrique
]

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
)
]
#block[
#set enum(numbering: "1.", start: 7)
+ Selon la version NK du modèle AS/AD vue pendant le cours, laquelle des déclarations suivantes est vraie :

  #block[
  #set enum(numbering: "a.", start: 1)
  + Après un choc de demande temporaire, les prix augmentent, puis diminuent pour revenir à leur niveau initial.
  + Un choc de demande positif persistant affecte l’écart de production, uniquement jusqu’à ce que tous les prix aient été ajustés.
  + Tout choc de demande induit une réponse d’offre opposée qui annulera finalement ses effets à long terme.
  + Les politiques de demande sont plus efficaces lorsque les prix sont plus flexibles.
  ]
]

#block[
#callout(
body: 
[
#block[
#set enum(numbering: "a.", start: 1)
+ Non. les prix augmentent mais ne baisse pas. L’inflation elle redescend à son niveau initial.
+ #strong[Oui];. cf cours.
+ Non. L’économie se déplace le long de la courbe d’offre de cours terme mais ce n’est pas un choc.
+ Non. Les politiques de demande sont plus efficaces lorsque les prix sont #emph[moins] flexible.
]

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
)
]
= Exercice 2: choc pétrolier et stagflation
<exercice-2-choc-pétrolier-et-stagflation>
Dans le graphique ci-joint, l’économie est à l’équilibre macroéconomique de long terme (initialement au point $E_0$), lorsqu’ un choc pétrolier déplace la courbe d’offre globale (de court terme) vers la gauche.#footnote[Notons que l’équilibre initial se situe à l’intersection des courbes AD at AS mais aussi AD et LRAS: l’équilibre de court terme correspond à l’équilibre de long terme.] Répondez aux questions suivantes à partir du graphique:

#figure([
#box(image("as_choc_petrolier.png"))
], caption: figure.caption(
position: bottom, 
[
Choc Pétrolier
]), 
kind: "quarto-float-fig", 
supplement: "Figure", 
)


#block[
#set enum(numbering: "1.", start: 8)
+ Comment varient à court terme l’ inflation et le PIB en conséquence du choc pétrolier ? Comment appelle-t-on ce phénomène ?
]

#block[
#callout(
body: 
[
Le choc d’offre est un shift de la courbe d’offre de court terme vers la gauche. A court terme l’équilibre se déplace vers $E_1$. Il y a simultanément une baisse du pib (augmentation du chômage) et une hausse du l’inflation. Cette situation est appelée stagflation.

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
)
]
#block[
#set enum(numbering: "1.", start: 9)
+ Quelle politique budgétaire ou monétaire le gouvernement peut-il utiliser pour gérer les effets du choc d’offre? Montrez graphiquement les effets des politiques choisies pour gérer la variation du PIB réel. Montrez sur un autre graphique les effets des politiques choisies pour stabiliser l’inflation.
]

#block[
#callout(
body: 
[
A court terme, il n’est pas possible d’influer sur la courbe d’offre. Mais on peut contrer l’effet sur le chômage en stimulant la demande. On parle alors de politique #emph[accomodante] (on accommode le choc d’offre).

Pour stimuler la demande, la banque centrale peut baisser les taux d’intérêt (hors réaction normale à l’ inflation déjà intégrée à la courbe de demande). Le gouvernement peut aussi augmenter ses dépenses. Dans les deux cas, la situation est représentée par le premier graphique.

#figure([
#box(image("as_choc_petrolier_2.png"))
], caption: figure.caption(
position: bottom, 
[
Choc Pétrolier - Politique accommodante
]), 
kind: "quarto-float-fig", 
supplement: "Figure", 
)


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
)
]
#block[
#callout(
body: 
[
A l’inverse si la banque centrale n’est préoccupée que par l’inflation elle peut la stabiliser complètement en augmentant les taux pour diminuer la demande au prix d’une augmentation du chômage. C’est la situation sur le deuxième graphique.

#figure([
#box(image("as_choc_petrolier_3.png"))
], caption: figure.caption(
position: bottom, 
[
Choc Pétrolier - Stabilisation de l’inflaiton
]), 
kind: "quarto-float-fig", 
supplement: "Figure", 
)


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
)
]
#block[
#set enum(numbering: "1.", start: 10)
+ En quoi le choc d’ offre présente-t-il un dilemme pour les décideurs 1?
]

Dans ce contexte, il n’est pas possible de réduire en même temps l’inflation et le chômage de sorte que les décideurs doivent arbitrer entre les deux.

= Exercice 1: Macroéconomie de court terme
<exercice-1-macroéconomie-de-court-terme-1>
Trouver l’unique bonne réponse pour les aux questions suivantes, en raisonnant dans le cadre du modèle AS/AD.

#block[
#set enum(numbering: "1.", start: 11)
+ La demande agrégée est une fonction décroissante de l’inflation. Choisissez la justification qui correspond le mieux au modèle AS/AD vu en cours :

  #block[
  #set enum(numbering: "a.", start: 1)
  + Une inflation plus élevée correspond à des taux d’intérêt réels plus élevés, ce qui correspond à des rendements de l’ épargne plus élevés et donc à des investissements plus élevés. L’augmentation des investissement augmente finalement la production et la consommation.
  + Lorsque l’inflation est plus élevée, la réaction de la banque centrale implique une hausse des taux réels qui incite les consommateurs ricardiens à diminuer leurs dépenses et les entreprises à reporter leurs investissements. La demande diminuée des ménages ricardiens et des entreprises induit également les ménages keynésiens à consommer moins.
  + Une inflation plus élevée correspond à des taux d’intérêt nominaux plus élevés, ce qui correspond à des rendements de l’épargne plus élevés et donc à des investissements plus élevés. Un investissement plus élevé augmente finalement la production et la consommation.
  + Une fonction de demande est décroissante par définition.
  ]
]

#block[
#callout(
body: 
[
#block[
#set enum(numbering: "a.", start: 1)
+ faux. Une inflation plus élevée correspond à un taux réel plus #emph[bas];. Aussi le raisonnement proposé mélange demande d’investissement et offre d’investissement (qui n’est pas déterminée par notre modèle de court terme)
+ #strong[vrai];. C’est exactement ça. Notons bien que si la banque centrale de réagissait pas, une hausse de l’inflation baisserait les taux réels.
+ faux. D’une part l’épargne est déterminée par les taux réels, pas nominaux. D’ autre part la hausse des taux provoque une baisse de la production.
+ faux. La demande agrégée n’est pas une fonction de demande normale. Il s’agit de l’équilibre implicite qui provient de la courbe IS.
]

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
)
]
#block[
#set enum(numbering: "1.", start: 12)
+ La courbe d’offre agrégée est croissante parce que (choisissez la meilleure justification) :

  #block[
  #set enum(numbering: "a.", start: 1)
  + Les courbes d’offre sont croissantes sur tous les micro-marchés.
  + Les courbes d’offre sont toujours ascendantes.
  + Des prix plus élevés permettent aux entreprises monopolistiques de réduire leur production.
  + Un niveau de prix plus élevé incite les entreprises qui ne peuvent pas ajuster leur propre prix à augmenter la production.
  ]
]

#block[
#callout(
body: 
[
#block[
#set enum(numbering: "a.", start: 1)
+ faux. L’offre agrégée peut conceptuellement être verticale, même si les marchés de chacun des biens à une pente d’offre normalement pentue.
+ faux. L’offre agrégée n’est pas une fonction d’offre normale normale.
+ faux. L’ajustement des prix par les firmes tant à limiter les variations de production. Si elles ajustaient toutes la courbe d’offre serait verticale.
+ #strong[vrai];. C’est le mécanisme qui fait que la production de certaines firmes augmentent lorsque la demande augmente, au lieu que ce soient seulement les prix qui servent de valeur d’ajustement. On a vu que l’ intuition reste vraie quand une fraction seulement des firmes peut ajuster.
]

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
)
]
#block[
#set enum(numbering: "1.", start: 13)
+ Trouvez la bonne déclaration :

  #block[
  #set enum(numbering: "a.", start: 1)
  + Les pays avec des marges plus basses ont des marchés plus concurrentiels.
  + Les pays où les marchés sont plus compétitifs ont une croissance plus élevée.
  + Des marges moyennes plus élevées signifient des prix plus flexibles.
  + La marge d’une entreprise en concurrence monopolistique dépend uniquement de son coût marginal.
  ]
]

#block[
#callout(
body: 
[
#block[
#set enum(numbering: "a.", start: 1)
+ #strong[vrai]
+ non, ce n’ est pas si simple. On a vue que la concurrence est moins forte aux États-Unis, mais la croissance y est plus faible qu’en France.
+ non
+ non. le lien entre coût marginal, marge et prix est par définition de la forme $p = (1 + mu) m c$. La marge $mu$ dépend de l’élasticité de la demande qui elle-même dépend de l’ environnement compétitif.
]

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
)
]
#block[
#set enum(numbering: "1.", start: 14)
+ Après un choc négatif d’offre :

  #block[
  #set enum(numbering: "a.", start: 1)
  + Les achats gouvernementaux peuvent atténuer l’effet sur le chômage.
  + La banque centrale ne peut rien faire car c’est un choc réel.
  + L’économie restera en déséquilibre jusqu’à ce que le gouvernement ou la banque centrale intervienne.
  + Les entreprises devraient changer de fournisseurs.
  ]
]

#block[
#callout(
body: 
[
#block[
#set enum(numbering: "a.", start: 1)
+ #strong[oui];, le gouvernemnt peut en effet augmenter la demande en augmentant les dépenses. Cela stabilise le chômage au prix d’une inflation plus haute
+ non, la banque centrale peut accomoder le choc, en déplacer la demande de manière à neutraliser son effet sur la production et/où l’inflation
+ non, s’il n’ est pas persistent l’effet du choc se résorbe de lui-même à mesure que les prix s’ajustent
+ non, pas de rapport
]

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
)
]
#block[
#set enum(numbering: "1.", start: 15)
+ Lequel des cas suivants est un choc négatif de demande ?

  #block[
  #set enum(numbering: "a.", start: 1)
  + Les déboires des sous-traitants de Boeing poussent la société à importer des moteurs allemands et italiens à la place des moteurs Pratt & Whitney
  + La fin de la Covid-19 provoque une hausse de l’optimisme des consommateurs.
  + Les réglementations en matière de crédit sont mises à jour pour limiter le surendettement
  + Un nouveau type de poussette électrique bon marché devient un must-have pour tous les passionnés de mode urbaine.
  ]
]

#block[
#callout(
body: 
[
#block[
#set enum(numbering: "a.", start: 1)
+ faux. cela augmente la demande étrangère pour la production domestique. C’est un choc de demande positif.
+ faux. les consommateurs plus optimistes pensent que leur consommation va augmenter dans le future. Pour lisser leur consommation dans le temps, ils augmentent donc leur consommation présente. (l’optimisme peut-aussi réduire leur perception du risque future et leur besoin d’une épargne de précaution, avec le même effet)
+ #strong[vrai];. la réglementation sur le surendettement empêche certains ménages de s’endetter pour consommer donc c’est un choc de demande négatif (même s’il peut être désirable)
+ faux. L’évolution des préférences entraîne une demande des consommateurs pour ce type de produit. C’est un choc de demande positif.
]

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
)
]
#block[
#set enum(numbering: "1.", start: 16)
+ Lequel des événements suivants est un choc d’offre positif:
  #block[
  #set enum(numbering: "a.", start: 1)
  + les prix mondiaux du pétrole augmentent à cause de la guerre en Ukraine
  + pour atteindre l’objectif "zéros émissions in 2030", les entreprises sont encouragées à éviter les énergies fossiles
  + le gouvernment met en place une subventions pour les entreprises qui investissent dans les technologies vertes
  + comme les voitures à essences sont interdites de circulation dans les grandes villes, les consommateurs achètent des voitures électriques
  ]
]

#block[
#callout(
body: 
[
#block[
#set enum(numbering: "a.", start: 4)
+ faux. choc d’offre négatif
+ faux. c’est équivalent à un renchérissement du prix des énergies fossiles donc à un choc d’offre négatif
+ #strong[vrai];. sans que le prix des autres énergie soient affectées, la production de technologies vertes est moins chère. C’est un choc d’offre positif.
+ faux. un choc de demande positif pour les voitures électrique
]

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
)
]
#block[
#set enum(numbering: "1.", start: 17)
+ Selon la version NK du modèle AS/AD vue pendant le cours, laquelle des déclarations suivantes est vraie :

  #block[
  #set enum(numbering: "a.", start: 1)
  + Après un choc de demande temporaire, les prix augmentent, puis diminuent pour revenir à leur niveau initial.
  + Un choc de demande positif persistant affecte l’écart de production, uniquement jusqu’à ce que tous les prix aient été ajustés.
  + Tout choc de demande induit une réponse d’offre opposée qui annulera finalement ses effets à long terme.
  + Les politiques de demande sont plus efficaces lorsque les prix sont plus flexibles.
  ]
]

#block[
#callout(
body: 
[
#block[
#set enum(numbering: "a.", start: 1)
+ Non. les prix augmentent mais ne baisse pas. L’inflation elle redescend à son niveau initial.
+ #strong[Oui];. cf cours.
+ Non. L’économie se déplace le long de la courbe d’offre de cours terme mais ce n’est pas un choc.
+ Non. Les politiques de demande sont plus efficaces lorsque les prix sont #emph[moins] flexible.
]

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
)
]
= Exercice 2: choc pétrolier et stagflation
<exercice-2-choc-pétrolier-et-stagflation-1>
Dans le graphique ci-joint, l’économie est à l’équilibre macroéconomique de long terme (initialement au point $E_0$), lorsqu’ un choc pétrolier déplace la courbe d’offre globale (de court terme) vers la gauche.#footnote[Notons que l’équilibre initial se situe à l’intersection des courbes AD at AS mais aussi AD et LRAS: l’équilibre de court terme correspond à l’équilibre de long terme.] Répondez aux questions suivantes à partir du graphique:

#figure([
#box(image("as_choc_petrolier.png"))
], caption: figure.caption(
position: bottom, 
[
Choc Pétrolier
]), 
kind: "quarto-float-fig", 
supplement: "Figure", 
)


#block[
#set enum(numbering: "1.", start: 18)
+ Comment varient à court terme l’ inflation et le PIB en conséquence du choc pétrolier ? Comment appelle-t-on ce phénomène ?
]

#block[
#callout(
body: 
[
Le choc d’offre est un shift de la courbe d’offre de court terme vers la gauche. A court terme l’équilibre se déplace vers $E_1$. Il y a simultanément une baisse du pib (augmentation du chômage) et une hausse du l’inflation. Cette situation est appelée stagflation.

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
)
]
#block[
#set enum(numbering: "1.", start: 19)
+ Quelle politique budgétaire ou monétaire le gouvernement peut-il utiliser pour gérer les effets du choc d’offre? Montrez graphiquement les effets des politiques choisies pour gérer la variation du PIB réel. Montrez sur un autre graphique les effets des politiques choisies pour stabiliser l’inflation.
]

#block[
#callout(
body: 
[
A court terme, il n’est pas possible d’influer sur la courbe d’offre. Mais on peut contrer l’effet sur le chômage en stimulant la demande. On parle alors de politique #emph[accomodante] (on accommode le choc d’offre).

Pour stimuler la demande, la banque centrale peut baisser les taux d’intérêt (hors réaction normale à l’ inflation déjà intégrée à la courbe de demande). Le gouvernement peut aussi augmenter ses dépenses. Dans les deux cas, la situation est représentée par le premier graphique.

#figure([
#box(image("as_choc_petrolier_2.png"))
], caption: figure.caption(
position: bottom, 
[
Choc Pétrolier - Politique accommodante
]), 
kind: "quarto-float-fig", 
supplement: "Figure", 
)


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
)
]
#block[
#callout(
body: 
[
A l’inverse si la banque centrale n’est préoccupée que par l’inflation elle peut la stabiliser complètement en augmentant les taux pour diminuer la demande au prix d’une augmentation du chômage. C’est la situation sur le deuxième graphique.

#figure([
#box(image("as_choc_petrolier_3.png"))
], caption: figure.caption(
position: bottom, 
[
Choc Pétrolier - Stabilisation de l’inflaiton
]), 
kind: "quarto-float-fig", 
supplement: "Figure", 
)


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
)
]
#block[
#set enum(numbering: "1.", start: 20)
+ En quoi le choc d’ offre présente-t-il un dilemme pour les décideurs 1?
]

Dans ce contexte, il n’est pas possible de réduire en même temps l’inflation et le chômage de sorte que les décideurs doivent arbitrer entre les deux.
