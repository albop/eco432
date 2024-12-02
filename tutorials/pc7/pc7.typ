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

= Questions de cours
<questions-de-cours>
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
]

#block[
#callout(
body: 
[
#strong[c] Voir le cours.

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
+ La demande agrégée est une fonction décroissante des prix. Choisissez la justification qui correspond le mieux au modèle AS/AD vu en cours :

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
+ faux. Une inflation plus élevéec correspond à un taux réel plus #emph[bas]
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
#set enum(numbering: "1.", start: 3)
+ La courbe d’offre agrégée est ascendante parce que (choisissez la meilleure justification) :

  #block[
  #set enum(numbering: "a.", start: 1)
  + Les courbes d’offre sont ascendantes sur tous les micro-marchés.
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
+ faux. L’offre agréegée peut conceptuellement être verticale, même si les marchés de chacun des biens à une pente d’offre normalement pentue.
+ faux. L’offre agrégée n’est pas une fonction d’offre normale normale.
+ faux. Une entreprise monopolistique peut décider de réduire sa production en augmentant le prix. Mais l’inverse n’a pas de sens car le prix est une variable de décision de la firme. La même explication tient pour les firmes monopolistiques.
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
#set enum(numbering: "1.", start: 4)
+ Trouvez la bonne déclaration :

  #block[
  #set enum(numbering: "a.", start: 1)
  + Les pays avec des marges plus basses ont des marchés plus concurrentiels.
  + Les pays où les marchés sont plus compétitifs ont une croissance plus élevée.
  + Des marges moyennes plus élevées signifient des prix plus flexibles.
  + La marge d’une entreprise monopolistique dépend uniquement de son coût marginal.
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
+ non. le lien entre coût marginal, marge et prix est de la forme $p = (1 + mu) m c$. La marge $mu$ dépend de l’élasticité de la demande qui elle-même dépend de l’ environnement compétitif.
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
+ #strong[oui] le gouvernemnt peut en effet augmenter la demande en augmentant les dépense. Cela stabilise le chômage au prix d’une inflation plus haute
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
#set enum(numbering: "1.", start: 6)
+ Lequel des cas suivants n’est pas un bon exemple de choc positif de la demande, du point de vue de l’économie européenne :

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
#set enum(numbering: "1.", start: 7)
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
#set enum(numbering: "1.", start: 8)
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
= Exercice 3: offre et demande
<exercice-3-offre-et-demande>
Lire les documents en annexe et répondre aux questions suivantes:

1/ La courbe de Phillips a-t-elle disparu ? Pourqui est-il important de savoir s’il s’agit d’une relation structurelle ou d’une relation statistique ?

#block[
#callout(
body: 
[
La courbe de Phillips est à l’origine une relation négative entre la niveau de l’inflation et le niveau du chômage. Cette relation était bien vérifiée dans les années 70 (cf cours ou picture).

Or le graphe de The Economist, semble montrer que depuis les années 1995, le chômage évolue indépendamment de l’inflation.

Cela dit, sur la figure 4, on observe une forte correlation depuis 2018 qui semble même augmenter sur les sous-périodes plus récentes.

Notons que la sur l’axe des abcisses, n’est pas précisément la même sur tous les graphes. Dans le graphe de Phillips original, il s’agit du chomage. Dans les graphes suivants, on veut garder une relation de court terme, les auteurs ont voulu neutraliser les variations persistantes dans le niveau du chômage. Pour la figure 2 on a donc on abcisse la déviation du chômageau à son niveau structurel. Dans les papiers plus récents, on utilise plutôt, comme dans la figure 4, la tension sur le marché du travail: c’est à dire que l’on regarde le ratio entre le nombre de chômeur, et le nombre d’emplois non pourvus. Intuitivement, c’est la même chose, dans la mesure où le nombre d’emploi à pourvoir est étroitement corrélé avec la capacité structurelle de l’économie à produire à court terme. Notons aussi que le graphe 6 est inversé gauche droite puisqu’ il utilise le nombre de poste à pourvoir sur le nombre de chômeurs au lieu de l’inverse.

Notons que que les graphes n’indiquent pas s’il s’agit seulement d’une relation statistique ou d’une relation structurelle. Une relation structurelle est vérifiées dans toutes les circonstances, et peut recevoir une interprétation causale. Si l’on croît que la relation chômage inflation est structurelle, alors on pourrait vouloir augmenter l’inflation par n’importe quel moyen pour réduire le chômage.

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
2/ Comment peut-on interpréter la courbe de Phillips nonlinéaire ? En s’inspirant de l’analyse graphique des chocs faite en cours, que peut-on en déduire sur l’efficacité des politiques de demande à court terme?

#block[
#callout(
body: 
[
La courbe AS/AD est parfois présentée de la faćon suivante (TODO change p for $pi$)

#figure([
#box(image("nonlinear_as_ad.svg.png", width: 60%))
], caption: figure.caption(
position: bottom, 
[
Modèle AS/AD avec AS nonlinéaaire
]), 
kind: "quarto-float-fig", 
supplement: "Figure", 
)


On peut l’interpréter intuitivement de la façon suivante: Pour la partie (presque) horizontale, le niveau de chômage est tel qu’il existe des ressources non utilisées. Si besoin les firmes peuvent donc produire plus à prix (presque) constant. A l’inverse, sur la partie verticale, l’économie est au plein emploi et ne peut produire plus sans que les prix augmentent très vite.

Traçons le diagramme AS/AD en remplaçant la courbe AS par la courbe de Phillips non-linéaire. Un choc de demande positif correspond à un déplacement de la courbe de demande vers la droite. En fonction du point d’équilibre initial, on peut alors avoir plusieurs dynamiques possibles:

- si l’équilibre initial est loin du plein emploi, l’emploi augmente significativement et l’augmentation de l’inflation est modérée
- si l’équilibre initial est au plein emploi, l’emploi ne bouge pas mais l’inflation augmente

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
)
]
3/ Quels changements persistents a apporté la crise de la Covid? Quelle raison y avait-il de penser que l’inflation élevée de 2023 pourrait être controlée sans dommage ?

#block[
#callout(
body: 
[
Le graphe 5 nous renseigne sur le comportement du marché de l’emploi en conséquence de la crise. Le chômage a d’abord augmenté brutalement, puis s’est résorbé alors que le nombre d’emploi créé par l’économie américaine augmentait. Dans le nouvel équilibre, le marché de l’emploi est donc particulièrement tendu de sorte que l’excès de demande post-covid, est principalement inflationiste.

Cette situation était un argument pour penser qu’une augmentation des taux d’intérêts réduirait l’inflation sans augmenter le chômage ou peu: l’économie revient à la normale en suivant la partie verticale de la courbe AS.

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
4/ Quel est le point de vue de Ricardo Reis sur la courbe de Phillips ? Pourquoi David Beckworth parle-t-il de variable confondante ?

#block[
#callout(
body: 
[
Selon R. Reis, la banque centrale manipule les taux d’intérêt pour contrôler l’inflation, ce qui a pour effet #emph[secondaire] d’affecter le niveau chômage. Le mécanisme précis est expliqué dans les Tweets 2. L’augmentation des taux d’intérêt nominaux rend les actifs réels plus côuteux à détenir que les actifs nominaux. Donc les taux d’intérêts réels tendent à diminuer. Comme les taux réels baissent, la consommation, l’investissement (précisément la demande d’investissement) baissent aussi. Ce mécanisme est a priori le même quelque soit la réaction de l’offre et du marché du travail.

#block[

#block[
#box(image("pc7_files/figure-typst/mermaid-figure-1.png", height: 2.08in, width: 4.11in))

]

]
Si on regarde le graphe ci-dessus, on retrouve un motif familier en statistique celui d’une variable confondante: lorsqu’une variable aléatoire X cause à la fois Y et Z, on trouve une corrélation entre Y et Z, sans rapport de causalité. Par exemple, il existe une corrélation claire entre la quantité de chocolat consommée dans un pays et le nombre de prix Nobel produits par ce pays. Sauf s’il s’agit d’une anomalie statistique (corrélation parasite), cela peut s’expliquer par le fait que le niveau de vie cause une consommation plus élevée de produits de luxe (et de chocolat), et un système de recherche capable de produire des prix Nobel.

En particulier si l’on affecte l’inflation par une variable quelconque Z, mais qu’inflation et chômage ne sont pas liés structurellement on n’a aucun effect sur le chômage.

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
5/ Qu’est ce qui caractérise le prix d’un actif ? En quoi est-ce pertinent pour comprendre la caractérisation par Olivier Blanchard de sa diférence avec Ricardo Reis dans les Tweets (3) ?#footnote[on peut laisser ici de côté la référence à la théorie fiscale du niveau des prix de John Cochrane.]

#block[
#callout(
body: 
[
Un actif (réel ou nominal) est un titre de propriété qui donne le droit à un flux de revenu (réel ou nominal). Typiquement la valorisation d’un actif réel qui produit un dividende $d_t$ peut prendre la forme:

$ p_t = E_t [sum_(s gt.eq t)^oo 1 / (1 + r)^(s - t) d_s] $

que l’on peut aussi écrire sous la forme:

$ p_t = frac(1, 1 + r) E_t [p_(t + 1)] + d_t $

Dans un modèle keynésien standard (comme dans l’exercice 3), la courbe PC s’écrit:

$ pi_t = alpha E_t pi_(t + 1) + y_t $

avec $0 < alpha < 1$ ce qui par substitution donne la formule

$ pi_t = E_t [sum_(s gt.eq t)^oo alpha^(s - t) y_s] $

formellement équivalente à la formule de valuation précédente si l’on remplace les dividendes par l’output gap $y_s$

En particulier, on voit dans la formule plus haut que les #emph[anticipations d’inflation] jouent formellement le même rôle dans la détermination de l’inflation présente que l’anticipation des prix futurs dans la détermination des prix présents. Il s’ensuit que le travail d’une banque centrale consiste en grande partie à contrôler ces anticipations d’inflations par tous les moyens disponibles (par exemple en communiquant sur sa politique future).

Un autre caractéristique d’un actif classique est l’existence d’un marché pour cet actif. L’intéraction des acheteurs et vendeurs sur ce marché est parfaitement coordonnée par les prix.

A l’inverse O. Blanchard considère que le niveau des prix (donc l’inflation) n’entre pas directement dans leur décisions de fixation des salaires et des prix, car les firmes considèrent uniquement des prix relatifs pertinents pour eux (leur salaires, leur prix de vente, celui des concurrents…). On ne peut donc pas coordonner les actions des firmes en agissant sur leurs anticipations d’inflation. Il faut donc pour réduire l’inflation agir directement sur les décisions des firmes pour les inciter à réduire leur prix. Cela est possible si l’on réduit la demande. Dans cette vision l’ajustement par les entreprises est un canal de transmission dû la politique monétaire.

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
+ Pourquoi le point de vue sur rigidités nominales est-il central pour distinguer un point de vue de l’autre?
]

#block[
#callout(
body: 
[
On a vu dans le cours, comment les rigidités nominales aboutissaient à une courbe AS croissante.

Schématiquement, le point de vue d’O Blanchard, est parfaitement compatible avec le graphe AS/AD. La banque centrale peut contrôler l’inflation en déplaçant l’équilibre le long de la courbe AS.

A l’inverse, en l’absence de rigidité des prix (cf Tweets 4), la courbe AS de court terme ne suffirait pas à déterminer l’inflation puisqu’elle serait verticale. L’aspect intertemporel serait donc primordial pour déterminer l’inflation, même à court terme.

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
= Exercice 3: dynamique des chocs
<exercice-3-dynamique-des-chocs>
Dans les amphis on a dérivé un modèle de la forme:

où $pi_t$ est l’inflation, $i_t$ le taux d’intérêt nominal et $y_t$ le niveau de production. $y^(n t)$ et $theta_t$ sont respectivement des chocs exogènes, d’offre et de demande. $sigma$, $kappa$, $gamma$ sont tous des paramètres positifs.

L’équation de la Phillips Curve (PC\_1) est obtenue en supposant qu’une fraction $omega$ des firmes n’ajustent pas leur prix, et que celles qui ajustent optimisent leur profit instantané à la date $t$.

Si au lieu de cela, on avait supposé (comme dans le poly) que les firmes qui ne peuvent pas ajuster à la date $t$ fixent leur prix à l’avance en fonctions de leur anticipations d’inflation et si l’on suppose de plus que ces anticipations sont adaptative $E_t pi_(t + 1) = pi_t$, on obtient la courbe de phillips accélérante:

$ pi_t = pi_(t - 1) + kappa (y_t - y_t^(n t)) $

Enfin le modèle Néo-Keynésien standard suppose que les firmes qui n’ajustent pas en $t$ gardent leur prix de $t - 1$ et que celles qui ajustent fixent leur prix de manière à maximiser tous leur profits futures escomptés de sorte que leurs décisions dépendent de leurs anticipations. On a alors la courbe de Phillips "augmentée des anticipations": $ pi_t = E_t [pi_(t + 1)] + kappa (y_t - y_t^(n t)) $

+ Pour les différentes versions de la courbe de Phillips, calculer la réponse de l’économie à un choc de demande de persistence $rho$. Faire de même pour un choc de production $rho$ de même persistence. Commenter.

+ Le critère de Taylor stipule que l’inflation (et le reste de l’économie) a un équilibre unique non divergent si et seulement si $gamma > 1$. Pour lequel (lesquel) des modèles précédents ce critère est-il valide ?

#pagebreak()
= Annexe: Documents
<annexe-documents>
== Où est passée la courbe de Phillips?
<où-est-passée-la-courbe-de-phillips>
#figure([
#box(image("original_pc.png", width: 70%))
], caption: figure.caption(
position: bottom, 
[
Original Phillips Curve
]), 
kind: "quarto-float-fig", 
supplement: "Figure", 
)


Le graphe suivant est extrait de #emph[The Economist] (2017):

#figure([
#box(image("disparition_pc.png", width: 70%))
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
#box(image("inflation_without_unemployement.png", width: 70%))
], caption: figure.caption(
position: bottom, 
[
Inflation et Chômage
]), 
kind: "quarto-float-fig", 
supplement: "Figure", 
)


#figure([
#box(image("beveridge_curve.png", width: 70%))
], caption: figure.caption(
position: bottom, 
[
Courbe de Beveridge
]), 
kind: "quarto-float-fig", 
supplement: "Figure", 
)


#figure([
#box(image("nonlinear_phillips_curve.png", width: 70%))
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
#box(image("no_pc.png", width: 70%))
], caption: figure.caption(
position: bottom, 
[
Courbe Phillips Nonlinéaire
]), 
kind: "quarto-float-fig", 
supplement: "Figure", 
)
<fig-nopc>


#pagebreak()
== Twitter & Short Term Macroeconomics
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
#box(image("rreis_response.png", width: 70%))
], caption: figure.caption(
position: bottom, 
[
Tweets (1)
]), 
kind: "quarto-float-fig", 
supplement: "Figure", 
)


#figure([
#box(image("rreis_explanation.png", width: 70%))
], caption: figure.caption(
position: bottom, 
[
Tweets (2)
]), 
kind: "quarto-float-fig", 
supplement: "Figure", 
)


#figure([
#box(image("blanchard_response_2.png", width: 70%))
], caption: figure.caption(
position: bottom, 
[
Tweets (3)
]), 
kind: "quarto-float-fig", 
supplement: "Figure", 
)


#figure([
#box(image("blanchard_response_3.png", width: 70%))
], caption: figure.caption(
position: bottom, 
[
Tweets (4)
]), 
kind: "quarto-float-fig", 
supplement: "Figure", 
)


= Exercice 1: Macroéconomie de court terme
<exercice-1-macroéconomie-de-court-terme>
Trouver l’unique bonne réponse pour les aux questions suivantes, en raisonnant dans le cadre du modèle AS/AD.

#block[
#set enum(numbering: "1.", start: 9)
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
#set enum(numbering: "1.", start: 10)
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
#set enum(numbering: "1.", start: 11)
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
#set enum(numbering: "1.", start: 12)
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
#set enum(numbering: "1.", start: 13)
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
#set enum(numbering: "1.", start: 14)
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
#set enum(numbering: "1.", start: 15)
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
#set enum(numbering: "1.", start: 16)
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
#set enum(numbering: "1.", start: 17)
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
#set enum(numbering: "1.", start: 18)
+ En quoi le choc d’ offre présente-t-il un dilemme pour les décideurs 1?
]

Dans ce contexte, il n’est pas possible de réduire en même temps l’inflation et le chômage de sorte que les décideurs doivent arbitrer entre les deux.
