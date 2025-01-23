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
#import "@preview/fontawesome:0.1.0": *

#show: doc => article(
  title: [Politique Monétaire],
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

== Programme des amphis
<programme-des-amphis>
- …
- Demande agrégée
- Offre agrégée
- Sources des fluctuations
- Politique monétaire (\*)
- …

== Cette session
<cette-session>
- Les outils de la politique monétaire
- Implémentation de la politique monétaire
  - La structure des taux d’intérêt
  - Le marché interbancaire

= Les outils de la politique monétaire
<les-outils-de-la-politique-monétaire>
== Les outils de la politique monétaire
<les-outils-de-la-politique-monétaire-1>
Quels sont les principaux outils de la politique monétaire ?

#block[
- Opérations d’open market

  - la BC échange des liquidités (cash) en échange d’actifs moins liquides (obligations/bons du gvt)
  - la BC prête sur le marché interbancaire

- Taux de réserves obligatoires

- Taux d’intérêt sur les réserves détenues par les banques auprès de la BC

  - "Discount rate" aux US
  - "Main Refinancing Operations" (MRO) en Zone Euro

- D’autres outils non-conventionnels (non couverts ici)

]
== Agrégats monétaires
<agrégats-monétaires>
La Banque Centrale a le monopole de la création de #strong[Monnaie Banque Centrale] :

- Pièces, billets de banque, euros numériques…

La Monnaie Banque Centrale est également appelée #strong[Base Monétaire];. Comment est-elle #emph[injectée] dans l’économie ?

. . .

En principe, la Banque Centrale #emph[pourrait] la distribuer :

- en envoyant des chèques ou en monétisant directement le déficit du gouvernement#footnote[L’Argent Hélicoptère est une #emph[métaphore] inventée par Milton Friedman pour décrire, pour expliquer que, d’un point de vue macroéconomique, le destinataire réel de l’argent n’est pas si important.]

. . .

Mais en pratique, les banques centrales échangent la Monnaie Banque Centrale contre des actifs moins liquides.

- ce qui permet la création d’argent par les banques privées.

#horizontalrule

=== Qui possède la Monnaie Banque Centrale ?
<qui-possède-la-monnaie-banque-centrale>
#figure([
#box(image("./assets/base_money.png", height: 50%))
], caption: figure.caption(
position: bottom, 
[
Base Monétaire (statistiques de la BCE)
]), 
kind: "quarto-float-fig", 
supplement: "Figure", 
)


. . .

La majeure partie de l’argent créé par la Banque Centrale depuis 2009 est détenue par des institutions financières privées qui détiennent des réserves (comptes courants) à la Banque Centrale.#footnote[Cet argent reste virtuel dans le sens où il n’est jamais imprimé. Il s’agit effectivement de la monnaie numérique.]

#horizontalrule

=== Monnaie Étroite / Monnaie Large
<monnaie-étroite-monnaie-large>
#block[
#block[
La BCE répertorie plusieurs agrégats monétaires :

- M1 : #strong[Monnaie étroite]
  - monnaie (pièces, billets) en circulation et dépôts à vue (par exemple, les comptes de chèques des consommateurs)
- M2 :
  - M1 + dépôts avec une maturité convenue de jusqu’à deux ans et dépôts remboursables avec un préavis de jusqu’à trois mois
- M3 : #strong[Monnaie large]
  - M2 + accords de rachat, parts/unités de fonds du marché monétaire et titres de créance avec une maturité de jusqu’à deux ans

Les agrégats monétaires contiennent des actifs financiers de liquidité décroissante.

Notez que dans ces agrégats monétaires, seule la monnaie est créée par la Banque Centrale. Tous les autres actifs sont créés par le secteur privé.

]
#block[
#box(image("assets/aggreg.png", height: 60%))

]
]

#horizontalrule

#box(image("two_birds.png", width: 20%))

Attendez ? Les banques privées créent de l’argent ?

. . .

Oui, la plupart d’entre elles. Expliquons comment.

#horizontalrule

=== Contrôler M1
<contrôler-m1>
#block[
#block[
- Lorsqu’une banque commerciale accorde un prêt, elle crée de l’argent directement !
- Le crédit des banques privées est limité par le ratio de réserve obligatoire
  - les banques commerciales doivent conserver une fraction $lambda$ des prêts en cours en réserves
  - pour 1 unité de Monnaie Banque Centrale qu’elles reçoivent (par exemple, sous forme de dépôts), elles peuvent prêter $1 - lambda$
- Le montant total d’argent étroit que le système financier peut créer à partir d’un dépôt de 1 unité est appelé multiplicateur monétaire : $mu = 1 / lambda - 1$

]
#block[
#box(image("multiplier.png", width: 80%))

]
]
Changer le ratio de réserve est un outil politique potentiel pour contrôler la création d’argent par le secteur privé#footnote[les calculs pour obtenir le multiplicateur monétaire sont très similaires au multiplicateur fiscal. Un euro de dépôts conduit à un prêt total de $(1 - lambda) + (1 - lambda)^2 + dots.h.c = (1 - lambda) frac(1, 1 - (1 - lambda))$];.

=== 
<section>
Quelle est la taille du multiplicateur monétaire ?

. . .

Les exigences de réserves étaient de 2% jusqu’en 2012. 1% depuis lors.

. . .

Le multiplicateur monétaire théorique était d’environ 50 jusqu’en 2012, 100 depuis lors.

. . .

Vérifions les données…

=== Contrôler M1
<contrôler-m1-1>
#figure([
#box(image("assets/base_money_multiplier.png", width: 60%))
], caption: figure.caption(
position: bottom, 
[
Base money and the money multiplier (BCE)
]), 
kind: "quarto-float-fig", 
supplement: "Figure", 
)


Depuis 2009, la base monétaire a augmenté considérablement, mais pas le crédit. Le multiplicateur monétaire est loin de son maximum. Les exigences de réserves ne sont pas contraignantes.

== Ciblage de l’inflation
<ciblage-de-linflation>
=== Évolution des pratiques politiques standard
<évolution-des-pratiques-politiques-standard>
#box(image("evolution_practices.png"))

=== Ciblage de l’inflation
<ciblage-de-linflation-1>
La plupart des BC (Banques Centrales) ont maintenant adopté une forme de "ciblage de l’inflation"

- la banque centrale tente d’atteindre un objectif d’inflation donné (par exemple, 2% dans la zone euro)

Elle atteint cet objectif en manipulant les taux d’intérêt nominaux :

- soit en contrôlant la masse monétaire
- soit en fixant directement les taux d’intérêt

. . .

#block[
#callout(
body: 
[
Depuis les années 2009, #strong[l’instrument principal de la politique monétaire est le taux d’intérêt]

- la quantité d’argent créée est déterminée par le secteur privé

]
, 
title: 
[
Message important
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
== La règle de Taylor
<la-règle-de-taylor>
=== Ciblage de l’inflation et la règle de Taylor
<ciblage-de-linflation-et-la-règle-de-taylor>
Quelles variables économiques la BC regarde-t-elle principalement pour stabiliser l’inflation ?

. . .

John Taylor, a découvert empiriquement (en 1993) que les décisions réelles en matière de taux d’intérêt étaient bien approximées (même avant l’adoption du ciblage de l’inflation) par une #emph[règle simple] de la forme :

$ i_t = i^star.op + 0.5 (pi_t - pi^star.op) + 0.5 (y_t - y_t^(n t)) $

Cela dépend de

- l’écart d’inflation par rapport à sa cible
- l’écart de production par rapport à son niveau naturel (écart de production)

=== Règle de Taylor vs Taux Effectif
<règle-de-taylor-vs-taux-effectif>
#figure([
#box(image("taylor_rule_vs_effective_1.png", width: 80%))
], caption: figure.caption(
position: bottom, 
[
Règle de Taylor d’origine par rapport aux décisions réelles (Données US)
]), 
kind: "quarto-float-fig", 
supplement: "Figure", 
)


Depuis 1999, la règle de Taylor reste globalement pertinente mais ne correspond complètement plus à la cible après 2014 (quand les taux d’intérêt étaient à 0).

=== Règle de Taylor améliorée
<règle-de-taylor-améliorée>
Une version basée sur les anticipations d’inflation décrit bien les décisions des BC :

$ i_t = i^star.op + 0 , 5 underbrace((E_t [pi_(t + 1)] - pi^star.op), upright("excès d’inflation attendu")) + 0 , 5 underbrace(E_t [y_t - y_t^(n t)], upright("écart de production attendu")) $

Cette version est un bon point de référence pour comprendre la communication de la banque centrale.

=== Règle de Taylor améliorée vs Taux Effectif
<règle-de-taylor-améliorée-vs-taux-effectif>
#figure([
#box(image("taylor_rule_vs_effective_2.png", width: 80%))
], caption: figure.caption(
position: bottom, 
[
Règle de Taylor améliorée
]), 
kind: "quarto-float-fig", 
supplement: "Figure", 
)


Source : Orphanides et Wieland

=== Résumé opérationnel
<résumé-opérationnel>
Évolution de la Banque Centrale

- depuis les années 90 et le ciblage de l’inflation, les principales banques centrales sont passées au ciblage de l’inflation

La banque centrale augmente le taux d’intérêt

- lorsque la production (anticipée) est supérieure à son niveau naturel
  - pour éviter les pressions inflationnistes, la surchauffe économique
- lorsque l’inflation (anticipée) est trop élevée
  - la banque tente d’ancrer les anticipations autour de sa cible

Le fait que la banque centrale réagisse et manipule les #emph[anticipations] est la clé du central banking moderne.#footnote[Le blogueur Matt O’Brian note que les « Banques Centrales ont une forte influence sur les anticipations du marché » et compare leurs activités à des « jedi mind-tricks ».]

= Mise en œuvre de la politique monétaire
<mise-en-œuvre-de-la-politique-monétaire>
== Structure temporelle des taux d’intérêt
<structure-temporelle-des-taux-dintérêt>
=== Équation de Fisher et anticipation d’inflation
<équation-de-fisher-et-anticipation-dinflation>
Rappel de l’équation de Fisher :

$ r_t = i_t - pi_(t + 1) $

Pour être plus précis, nous devrions écrire : $ r_t = i_t - E_t [pi_(t + 1)] $

Car c’est seulement l’inflation "anticipée" qui est connue à la date $t$. Nous omettons le signe d’espérance, mais gardez à l’esprit que $pi_(t + 1)$ représente l’inflation anticipée.

=== Règle monétaire et anticipation d’inflation
<règle-monétaire-et-anticipation-dinflation>
Lors de la dérivation de la courbe AD, nous avons écrit la règle des taux d’intérêt réels (MP) comme suit : $ r_t = r^star.op + gamma (pi_t - overline(pi)) $

Mais la BC ne contrôle pas directement le taux d’intérêt réel. Elle contrôle le taux d’intérêt nominal $i_t$.

Maintenant, prenons l’équation de Fisher $r_t = i_t - pi_(t + 1)$. Nous pouvons la remplacer ci-dessus pour obtenir : $ i_t = r^star.op + gamma (pi_t - overline(pi)) + pi_(t + 1) $

Nous voyons que la banque centrale fixe le taux d’intérêt pour contrôler une combinaison de l’inflation et de l’"inflation anticipée". Plus proche d’une règle de Taylor moderne.

=== Taux d’intérêt à court terme
<taux-dintérêt-à-court-terme>
En réalité, la BC ne contrôle pas directement $i_t$ (le taux trimestriel ou annuel)

La BC contrôle plutôt les taux d’intérêt à très court terme, généralement du jour au lendemain. Où cela se passe-t-il ? Sur le #emph[marché interbancaire] :

- Les banques prêtent entre elles les réserves qu’elles détiennent sur un compte de la Banque Centrale.
- La Banque Centrale fixe le prix sur ce marché
- Comment le paramétrage d’un taux d’intérêt à court terme affecte-t-il le taux d’intérêt à long terme à n’importe quelle maturité (horizon) ?

=== Arbitrage
<arbitrage>
#block[
#block[
#box(image("arbitrage_1.png"))

]
#block[
#block[
L’arbitrage est un concept très général

Lorsque deux ou plusieurs options d’investissement équivalentes rapportent des rendements différents, les investisseurs se précipitent vers la plus rentable… jusqu’à ce que les rendements s’égalisent

Ainsi, à l’équilibre, toutes les options d’investissement équivalentes doivent finalement avoir le même rendement.

Les différences entre les taux de rendement sont expliquées par des différences dans :

- les caractéristiques de risque
- la liquidité

]
]
]
=== Structure temporelle des taux d’intérêt
<structure-temporelle-des-taux-dintérêt-1>
#block[
#block[
#box(image("arbitrage_2.png"))

]
#block[
Appliquons le principe de l’arbitrage à :

- Une obligation d’un an rapportant $i_t^(1 y)$
- Deux obligations de six mois rapportant (annualisées)
  - $i_t^(6 m)$ achetée à la date $t$
  - $i_(t + 6 m)^(6 m)$ achetée à la date $t + 6 m$
- Cela nous fournit deux options pour investir sur 1 an.
- Quelle est la condition d’arbitrage ?

]
]
=== Structure temporelle des taux d’intérêt
<structure-temporelle-des-taux-dintérêt-2>
Investissement de la valeur X à la date $t$

L’option 1 rapporte :

- $X (1 + i^(1 y))$ après un an
- Le rendement brut est $(1 + i^(1 y))$

L’option 2 rapporte (faites attention au fait que les rendements sont annualisés)

- $X (1 + i_t^(6 m))^(1 \/ 2)$ après 6 mois
- $X (1 + i_t^(6 m))^(1 \/ 2) (1 + i_(6 m)^(t + 6 m))^(1 \/ 2)$ après un an
- Le rendement brut est $(1 + i_t^(6 m))^(1 \/ 2) (1 + i_(6 m)^(t + 6 m))^(1 \/ 2)$

=== Structure temporelle des taux d’intérêt
<structure-temporelle-des-taux-dintérêt-3>
L’équation d’arbitrage s’écrirait : $ (1 + i^(1 y)) = (1 + i_t^(6 m))^(1 \/ 2) (1 + i_(6 m)^(t + 6 m))^(1 \/ 2) $ Ou en termes logarithmiques : $i_t^(1 y) = 1 / 2 i_t^(6 m) + 1 / 2 i_(t + 6 m)^(6 m)$ Étant donné que les investisseurs sont averses au risque et apprécient la flexibilité d’avoir de l’argent plus tôt, ils demandent une prime de risque $phi$ : $ i^(1 y) = 1 / 2 i_t^(6 m) + 1 / 2 i_(t + 6 m)^(6 m) + phi $

La prime de risque intègre l’incertitude concernant le fait que les opportunités d’investissement pourraient changer avant un an, et la possibilité que le taux d’intérêt à six mois puisse changer avant un an.

=== Structure temporelle des taux d’intérêt
<structure-temporelle-des-taux-dintérêt-4>
Le même raisonnement s’applique au taux quotidien fixé par la banque centrale :

$ i_t^(1 y) = 1 / 365 (i_(1 d)^t + i_(t + 1 d)^(1 d) + i_(t + 2 d)^(1 d) i_(t + 2 d)^(1 d) + dots.h.c i_(t + 364 d)^(1 d)) + phi $

- En manipulant les taux d’intérêt de courte durée (maturité annualisée), la banque centrale peut manipuler le taux d’intérêt annuel.
- Elle le fait en annonçant une trajectoire des taux d’intérêt futurs.
- Pour que la manipulation soit efficace, la trajectoire des taux d’intérêt futurs doit être claire et prévisible, de même que son ajustement éventuel aux contingences économiques.
- C’est l’une des raisons pour lesquelles la banque centrale tente de s’engager dans une politique claire et transparente.

=== Taux d’intérêt à court terme
<taux-dintérêt-à-court-terme-1>
#block[
#block[
#box(image("short_term.png"))

]
#block[
- Les taux d’intérêt sont examinés régulièrement (tous les quelques mois).
- En général, ils évoluent lentement, de manière prévisible.
  - La Fed américaine laisse les taux fluctuer dans une fourchette.
- Notez que les taux sont restés à des niveaux historiquement bas depuis 2008.

]
]
=== Taux d’intérêt à court terme et taux d’intérêt à long terme
<taux-dintérêt-à-court-terme-et-taux-dintérêt-à-long-terme>
#block[
#block[
#box(image("short_term_long_term.png"))

]
#block[
- Les taux d’intérêt à court terme sur le marché interbancaire influencent les maturités plus longues (3 mois et 10 ans)

- Les taux d’intérêt à long terme ne varient pas de manière équivalente aux taux d’intérêt à court terme.

- Cela s’explique par le fait que les taux d’intérêt à long terme intègrent les changements futurs des taux d’intérêt à court terme.

]
]
== Le marché interbancaire
<le-marché-interbancaire>
=== Taux d’intérêt sur les réserves et taux d’intérêt sur le marché interbancaire
<taux-dintérêt-sur-les-réserves-et-taux-dintérêt-sur-le-marché-interbancaire>
- Donc, la banque centrale (BC) manipule $r$ en manipulant $i$ en fixant le taux d’intérêt sur le marché interbancaire de nuit…

- Mais comment la BC fixe-t-elle le prix sur le marché interbancaire ? 🤔

  - C’est un prix d’équilibre, pas directement décidé par la BC.

=== Le marché interbancaire
<le-marché-interbancaire-1>
Lorsque les clients d’une banque donnée font des transactions entre eux, aucun argent ne quitte la banque.

Maintenant, considérons l’expérience mentale suivante :

- Lorsqu’un client de la banque A paie un client de la banque B, la banque A devrait recevoir des réserves de la banque B.
- Le même jour, il peut y avoir des transactions de B vers A pour compenser la première transaction.
- Mais à la fin de la journée, les déséquilibres doivent être corrigés et la banque A doit payer la banque B.
- Si A a suffisamment de réserves, elle peut les utiliser.
- Sinon, elle peut les emprunter à une autre banque C pour couvrir la transaction
  - sur le marché interbancaire.

=== Taux d’intérêt sur les réserves et taux d’intérêt sur le marché interbancaire
<taux-dintérêt-sur-les-réserves-et-taux-dintérêt-sur-le-marché-interbancaire-1>
- Pour s’assurer qu’elles peuvent effectuer les transactions pour régler les déséquilibres :

  - Les banques détiennent des réserves à la BC pour couvrir les paiements interbancaires en cas de besoin.
  - Et elles prêtent de l’argent les unes aux autres sur le marché interbancaire.

- Il y a deux taux correspondants :

  - Les réserves à la BC rapportent un taux d’intérêt $i^R$. Fixé de manière exogène par la BC.
  - Le taux de marché $i_M$

- Le montant total $R_0$ de réserves (Monnaie Banque centrale) est décidé par la banque centrale.

- Deux instruments :

  - introduire davantage de réserves via des opérations de marché ouvertes : changer $R_0$
  - changer le taux d’intérêt payé sur les réserves

=== Équilibre sur le marché interbancaire
<équilibre-sur-le-marché-interbancaire>
#block[
#block[
#figure([
#box(image("assets/interbank.png", width: 80%))
], caption: figure.caption(
position: bottom, 
[
Équilibre sur le marché interbancaire
]), 
kind: "quarto-float-fig", 
supplement: "Figure", 
)


#figure([
#box(image("assets/interbank_quantitative.png", width: 80%))
], caption: figure.caption(
position: bottom, 
[
Équilibre sur le marché interbancaire : intervention quantitative
]), 
kind: "quarto-float-fig", 
supplement: "Figure", 
)


quantitative #box(image("assets/interbank_ir.png", width: 80%))

]
#block[
- Plus le taux d’intérêt est élevé, plus l’incitation est grande pour une banque ayant besoin de liquidité de puiser dans ses propres réserves (au prix de certains risques opérationnels).
- La demande diminue avec le taux d’intérêt à court terme.

Intervention quantitative :

- Une offre plus importante de réserves diminue le taux de marché $i_M$
  - comme dans le modèle IS-LM $♡$
- Plus le niveau de réserves est élevé, plus le canal quantitatif est faible.

Fixation directe des taux d’intérêt :

- La diminution des taux d’intérêt sur les réserves fonctionne toujours.
- Pas de piège à liquidité
- Les taux d’intérêt peuvent même être négatifs
  - les banques paient pour la fourniture de liquidités

]
]
=== Équilibre sur le marché interbancaire
<équilibre-sur-le-marché-interbancaire-1>
#box(image("short_term.png", width: 40%)) #box(image("excess_reserves.png", width: 40%))

Le taux d’intérêt sur les réserves est devenu l’instrument principal de politique monétaire. Cela découle des excédents importants (par précaution) de réserves détenus par les banques.

== Conclusion
<conclusion>
- Les banques centrales contrôlent les taux d’intérêt grâce à plusieurs instruments de politique monétaire.
- De nos jours, elles se concentrent sur la fixation du taux d’intérêt sur le marché interbancaire.
- Le contrôle des taux d’intérêt par la croissance monétaire est moins efficace car les banques privées ne prêtent pas suffisamment et détiennent d’énormes quantités de réserves à la banque centrale.
- Les taux d’intérêt sur les réserves détenues par les banques commerciales à la banque centrale sont devenus l’instrument principal de la banque centrale.
- … Mais récemment, des mesures non conventionnelles ont remis les mesures quantitatives au premier plan.
