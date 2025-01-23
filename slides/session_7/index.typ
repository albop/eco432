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

#let unescape-eval(str) = {
  return eval(str.replace("\\", ""))
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

#show: doc => article(
  title: [Source des Fluctuations],
  subtitle: [ECO432 - Macroéconomie],
  authors: (
    ( name: [Pablo Winant],
      affiliation: [],
      email: [] ),
    ),
  toc_title: [Table of contents],
  toc_depth: 3,
  cols: 1,
  doc,
)

= Introduction
<introduction>
== Programme des amphis
<programme-des-amphis>
- Séance 5 : demande agrégée
- Séance 6 : offre agrégée
- Séance 7 : fluctuations macroéconomiques (\*)
- Séance 8 : politique monétaire

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
<équilibre-oada>
Rappelons notre modèle:

- Demande Agrégée: $ y_t = theta_t - sigma gamma (pi_t - overline(pi)) $
  - #strong[mécanisme];: #emph[les presssions inflationnistes ($pi_t > overline(pi)$) poussent la banque centrale à adopter une politique monétaire restrictive, ce qui réduit la demande et la production#footnote[attention au rôle crucial de la banque centrale dans le modèle IS-MP! Sans la banque centrale, le modèle ne dit pas comment changent les taux réels lorsque les prix augmentent.];]
- Offre Agrégée: $ pi_t = overline(pi) + kappa (y_t - y_n^t) $
  - #strong[mécanisme];: #emph[un écart de production élevé engendre des tensions sur le marché du travail qui élèvent le salaire réel d’équilibre ; les entreprises qui le peuvent répercutent ce coût en élevant leur prix]

== Équilibre de long terme
<équilibre-de-long-terme>
- À long terme, tous les prix ont été ajustés de manière optimale et l’économie se comporte comme une économie de prix flexibles (OA): $ y_oo = y_oo^n = z_oo - mu^star.op $
- Par ailleurs, en supposant qu’à long terme $pi_oo = overline(pi)$, on a: $ theta_oo = y_oo $ (c’est "l’offre qui détermine la demande")

== Équilibre de court terme
<équilibre-de-court-terme>
\$\$\\text{\\textbf{DA}}: y\_t = \\theta\_t - \\sigma \\gamma (\\pi\_t - \\overline{\\pi})\$\$ \$\$\\text{\\textbf{OA}}: \\pi\_t = \\overline{\\pi} + \\kappa (y\_t - y^t\_n)\$\$

Dans ce modèle il y a:

- deux variables #strong[endogènes];#footnote[Par définition, les variables endogènes sont celles qui sont expliquées par le modèles, les variables exogènes sont déterminées par un mécanisme extérieur et sont prises comme données.];: $y_t$ et $pi_t$
- deux variables #strong[exogènes];: $theta_t$ et $y_t^n$

== Équilibre de court terme
<équilibre-de-court-terme-1>
On trouve aisément la paire (inflation $pi_t$ / output $y_t$) qui correspond aux chocs ($theta_t$, $y_t^n$ ).

$ y_t = c o n s t a n t + (frac(1, 1 + sigma gamma kappa)) theta_t + (frac(sigma gamma kappa, 1 + sigma gamma kappa)) y_t^n $

$ pi_t = c o n s t a n t + (frac(kappa, 1 + sigma gamma kappa)) theta_t - (frac(kappa, 1 + sigma gamma kappa)) y_t^n $

Les termes entre parenthèse sont génériquement appelés "multiplicateurs". Ils ont bien le signe attendu. Voyons comment on peut interpréter leur effet.

== Choc de demande
<choc-de-demande>
Que représente $d theta_t$ ? Qu’est-ce qui peut cause un déplacement négatif de la courbe de demande ?

#block[
- Un changement dans les préférences des consommateurs (désir de consommer)
- Un changement dans les anticipations des firmes et des consommateurs concernant leur revenus futurs.
- Une augmentation de l’incertitude dans les prévisions agents économiques (consommateurs, firmes)
- Une évolution des des exportations nette (changement dans la demande pour les biens domestiques, fluctuations dans le taux de change)
- / Ou des mouvements de capitaux internationaux
- Un changement dans la politique de la banque centrale
- Un changement dans le niveau de dépenses du gouvernement

]
== Choc de demande
<choc-de-demande-1>
#block[
#block[
#box(image("assets/demand_shock.png"))

]
#block[
Un choc $d theta_t$ sur la demande agrégée

- Augmente la production de $ d y_t = (frac(1, 1 + sigma gamma kappa)) d theta_t $
- Augmente l’inflation de $ d pi_t = (frac(kappa, 1 + sigma gamma kappa)) d theta_t $

Les paramètres principaux sont:

- $sigma$: la décision d’épargne investissement par les agents économiques (consommateurs et firmes)
- $gamma$: la réaction de la banque centrale
- $kappa$: la vitesse à laquelle les firmes ajustent leurs prix
  - (plus élevé lorsque plus de firmes ajustent)

]
]
== Choc de demande
<choc-de-demande-2>
Peut-on raconter intuitivement ce qui se passe en utilisant tous les mécanismes que l’on a vu jusqu’a présent ?

- Une augmentation de la demande agrégée pour les biens et les services
- Augmente la production
- Ce qui augmente la demande de travail
- Ce qui augmente les salaires réels (car l’offre de travail n’est pas parfaitement élastique)
- Ce qui augmente les coûts de production
- Ce qui augmente les prix de vente
  - mais pas jusqu’à annuler le choc car certaines firmes ne peuvent pas ajuster leur prix
- L’inflation des prix décourage la demande ce qui compense partiellement pour l’augmentation de la production.

== Choc de demande
<choc-de-demande-3>
#block[
#block[
#figure([
#box(image("assets/demand_shock_adjustment.png"))
], caption: figure.caption(
position: bottom, 
[
Choc persistant
]), 
kind: "quarto-float-fig", 
supplement: "Figure", 
)


]
#block[
Considérons un choc de demande transitoire

- Qui dure un certain nombre de périodes avant de disparaître
- Les conclusions dépendent du degré de #strong[persistence]

Lorsque plus de firmes ont eu le temps d’ajuster, la pente de la courbe AS augmente (elle est donnée par $kappa = frac(omega, xi (1 - omega))$ où $omega$ est le nombre de firmes qui ont ajusté)

On peut décrire la #strong[dynamique de l’inflation] informellement comme suit:

- L’inflation augmente initialement à cause du choc de demande
- L’augmentation de l’inflation continue alors que la fraction des firmes qui ajustent augmente (rotation de la courbe AS)
- L’inflation revient à la normale quand le choc de demande s’arrête
- Plus les prix s’ajustent vite, plus l’nflation augmente

Et pour la dynamique de la production ?

- Elle augmente initialement avec la demande
- Puis revient à la normale alors que l’effet du choc de demande s’estompe
- Plus les prix s’ajustent vite, plus faible est l’effet sur la production

]
]
== Choc de demande: vérification empirique
<choc-de-demande-vérification-empirique>
#block[
#block[
Le graphe ci-contre montre l’effet d’un choc de demande "pur": un choc de politique monétaire non-anticipé

Il compare la réponses de plusieurs variables économiques

- Dans les données (économétrie: estimation VAR)
- Dans un modèle avec des rigidités nominale (DSGE)
- Les deux ont un comportement similaire

Et par rapport à notre modèle?

- L’investissement et la consommation augmentent

- L’inflation augmente à moyen terme (pas juste à l’impact)

- Le salaire réel augmente

- L’augmentation de la production est persistante

  - … mais il y a du capital qui lisse la production dans le temps

]
#block[
#box(image("assets/irf.png"))

]
]
== Choc d’Offre
<choc-doffre>
#block[
#block[
#box(image("assets/negative_supply_shock.png"))

]
#block[
Un choc $d y_t^(n t)$ sur l’offre agrégée

- Augmente la production de: $ d y_t = (frac(sigma gamma kappa, 1 + sigma gamma kappa)) d y_t^(n t) $
- Augmente l’inflation de: $ d pi_t = (frac(kappa, 1 + sigma gamma kappa)) d y_t^(n t) $

Les paramètres sont les mêmes qu’avant:

- $gamma$: réaction de la banque centrale
- $sigma$: décision d’épargne investissment par les consommateurs et les firmes
- $kappa$: lié à la fixation des prix par les firmes

]
]
== Offre
<offre>
Un choc d’offre est un choc sur le PIB naturel $d y_t^(n t)$. Qu’est-ce qu’il représente ? Qu’est-ce qui cause un shift vers la gauche ou la droite de la courbe d’offre ?

- Les changements qui affectent le long terme (il affecte le pib naturel)
- Des changements dans les facteurs de production
- Des chocs de productivités
- Dans changement dans les markups (ou la compétitivité)
- Des changemements dans les anticipations (qui affectent la fixation des prix par les firmes)

== Chocs d’offre
<chocs-doffre>
#block[
#block[
#box(image("assets/stabilization.png"))

]
#block[
Un choc d’offre négatif déplace la courbe OA vers la gauche

- L’inflation augmente
- La production diminue

Comment le gouvernement et la BC peuvent-ils mitiger le choc ?

- Impossible d’agir sur l’offre

Dans notre modèle la #strong[banque centrale] est déjà incluse dans la courbe DA

- Ce qui rend la demande plus réactive à l’inflation (plus horizontale)
- Mais la règle MP suppose que la BC ne regarde que l’inflation
- … ce qui est un mauvais cadre pour étudier la réponse de la BC

Le #strong[gouvernement] peut stimuler la demande pour contrer le choc d’offre

- Avec des politiques fiscales
- Mais ća ne fonctionne qu’à court terme
- … et pose quelques questions(est-ce efficace ? d’où vient l’argent ?)

]
]
== A retenir
<a-retenir>
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
