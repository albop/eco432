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
  title: [PC2: Croix Keynésienne],
  toc_title: [Table of contents],
  toc_depth: 3,
  cols: 1,
  doc,
)

= Exercice 1: agents ricardiens et keynesiens
<exercice-1-agents-ricardiens-et-keynesiens>
+ Commenter brièvement les graphes suivants#footnote[Les deux premiers graphes sont tirés de Fiscal Policy and MPC Heterogeneity, Tullio Jappelli et Luigi Pistaferri, American Economic Journal: Macroeconomics, 2014, les deux derniers d’"Une brève histoire de l’égalité", Thomas Piketty, éditions du seuil.];. Quelle explication proposeriez-vous pour les ménages dont la PMC est égale à 50%?
+ En utilisant le dernier graphique justifier l’expression de "Wealthy Hand to Mouth"#footnote[Les "Wealthy Hand to Mouth" on été mis en évidence dans l’article Monetary Policy According to HANKde Kaplan, Moll and Violante dans American Economic Review, 2018] pour les ménages dont la PMC est non-nulle alors qu’ils disposent d’une richesse financière importante.

#quarto_super(
kind: 
"quarto-float-fig"
, 
caption: 
[
]
, 
label: 
<fig-elephants>
, 
position: 
bottom
, 
supplement: 
"Figure"
, 
subrefnumbering: 
"1a"
, 
subcapnumbering: 
"(a)"
, 
[
#grid(columns: 2, gutter: 2em,
  [
#block[
#figure([
#box(image("assets/mpc_1.png"))
], caption: figure.caption(
position: bottom, 
[
PMC (Autodéclarée) en Réponse à un Choc de Revenu Temporaire
]), 
kind: "quarto-float-fig", 
supplement: "Figure", 
)


]
],
  [
#block[
#figure([
#box(image("assets/mpc_2.png"))
], caption: figure.caption(
position: bottom, 
[
MC Moyenne par Percentiles de Trésorerie
]), 
kind: "quarto-float-fig", 
supplement: "Figure", 
)


]
],
  [
#block[
#figure([
#box(image("assets/mpc_3.png"))
], caption: figure.caption(
position: bottom, 
[
Distribution de la Richesse
]), 
kind: "quarto-float-fig", 
supplement: "Figure", 
)


]
],
  [
#block[
#figure([
#box(image("assets/mpc_4.png"))
], caption: figure.caption(
position: bottom, 
[
Décomposition de la Richesse
]), 
kind: "quarto-float-fig", 
supplement: "Figure", 
)


]
],
)
]
)
#block[
#callout(
body: 
[
+ Dans le premier graphe on note que la proportion d’agent ricardiens (dont la PMC est proche de zero) est sensiblement égale à celle des agents keynésiens (PMC proche de un). Cela dit, on remarque que toutes les valeurs intermédiaires sont présentes, notamment celle de 0.5. Ces valeurs sont a priori incompatibles avec un modèle d’optimisation intertemporelle sans risque. Comment peut-on l’interpéter? Sans exclusive, on peut avancer les explications suivantes:

- certains agents ne sont pas rationnels: ils suivent des règles de consommation (rule of thumb). C’est particulièrement plausible pour la valeur de 50%.
- la propension à consommer est une fonction continue de l’épargne de précaution. Elle est fonction des contraintes de crédit (voir question suivante) et du revenu disponible (graphes 2 et 3) qui a une distribution continue.

#block[
#set enum(numbering: "1.", start: 2)
+ Le graphe 3 montre l’importance de l’inégalité de la distribution de richesse. Sur le dernier on note l’existence d’une catégorie d’agents, dont la richesse est en grande partie une richesse immobilière. Concrètement il s’agit d’agents, dont le remboursement du crédit représente une part importante du revenu. Qui peuvent donc facilement être contraints de consommer moins si leur revenu baisse. Dans le cas extrême où cette correspondance s’opère un pour un, on les appelle "wealthy hand to mouth". Sinon, en général, ces agents consomment seulement une fraction de leur revenu additionel de façon à se couvrir contre une perte potentielle de revenu.
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
= Exercice 2: la croix keynésienne
<exercice-2-la-croix-keynésienne>
On considère une économie simplifiée où l’équilibre dépend de la production totale $Y$ et du taux d’intérêt #emph[réel] $r$. Il s’agit d’un modèle de court terme de sorte que l’on omet les indices temporels. Tout au long de cet exercice, nous supposons que les prix sont fixes (nous faisons donc abstraction de l’offre agrégée). Les composantes de la demande agrégée sont:

- la consommation totale des ménages: $C = C (Y , r)$
- l’investissement total des entreprises: $I = I (r)$
- les dépenses gouvernementales $G$ choisies de manière exogène par le gouvernement $G$

== La croix keynésienne
<la-croix-keynésienne>
+ #strong[Écrire la relation définissant l’équilibre sur le marché des biens à l’état stationnaire $(overline(Y) , overline(r))$. Justifier brièvement, sans calcul, le signe des dérivées $C_Y^(') (overline(Y) , overline(r))$, $C_r^(') (overline(Y) , overline(r))$ et $I^(') (overline(r))$.]

#block[
#callout(
body: 
[
La relation d’équilibre sur le marché des biens est: $ overline(Y) = C (overline(Y) , overline(r)) + I (overline(r)) + G $

Le coefficient $C_Y^(')$ représente la propension marginale à consommer. Elle est comprise entre 0 (pour les agents ricardiens) et 1 pour les agents keynésiens. Lorsque le taux d’intérêt augmente les consommateurs ont tendance à épargner plus, donc consommer moins d’où $C_r^(') < 0$. De même, il est dans ce cas plus coûteux pour les firmes d’emprunter pour investir, d’où $I_r^(') < 0$.

Nous analysons la détermination de l’équilibre au moyen d’un graphique (diagramme à 45 degrés, aussi appelé croix keynésienne): la demande est représentée sur l’axe vertical et la production est représentée sur l’axe horizontal. La production d’équilibre est donnée par l’égalité entre la production et la demande.

#figure([
#box(image("cross.png", width: 40%))
], caption: figure.caption(
position: bottom, 
[
Croix Keynesienne
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
#set enum(numbering: "1.", start: 2)
+ #strong[On suppose maintenant que le gouvernement augmente ses dépenses d’une quantité infinitésimale $Delta G$ sans effet sur les taux d’intérêt. Quelle est l’augmentation $Delta Y$ de la production d’équilibre ? Calculer le multiplicateur fiscal $frac(Delta Y, Delta G)$. Représenter cette augmentation sur le diagramme à 45 degrés.]
]

#block[
#callout(
body: 
[
Si l’on différencie la relation d’équilibre, on obtient:

$ Delta Y = C_Y^(') Delta Y + Delta G $

soit

$ #box(stroke: black, inset: 3pt, [$ Delta Y = frac(1, 1 - C_Y) Delta G $]) $

d’où l’on obtient le multiplicateur fiscal:

$ #box(stroke: black, inset: 3pt, [$ frac(Delta Y, Delta G) = frac(1, 1 - C_Y) $]) $

Les dépenses du gouvernement étant la part autonome des dépenses supplémentaires, on peut aussi écrire:

$ #box(stroke: black, inset: 3pt, [$ Delta Y = underbrace(Delta G, upright("Dépense autonome")) + underbrace((frac(C_Y, 1 - C_Y)) Delta G, upright("Dépense induite")) $]) $

#figure([
#box(image("cross2.png", width: 40%))
], caption: figure.caption(
position: bottom, 
[
Effet des dépenses gouvrnementales
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
#set enum(numbering: "1.", start: 3)
+ #strong[Dans la question précédente, on n’a pas précisé comment était financée la dépense supplémentaire (peut-être par un emprunt remboursé dans le futur). On suppose maintenant que le gouvernement impose une taxe forfaitaire $Delta T$ sur le revenu des ménages pour financer ses dépenses ($Delta T = Delta G$). Avec ces taxes, la consommation totale des ménages est une fonction du revenu disponible $C = C (Y - Delta T , r)$. De combien augmente la production d’équilibre et quel est le nouveau multiplicateur fiscal? Comment interpréter le résultat?]
]

#block[
#callout(
body: 
[
#emph[Puisque les dépenses sont financées par des taxes $Delta T = Delta G$, on écrit maintenant:]

$ overline(Y) + Delta Y = C (overline(Y) + Delta Y - Delta G , overline(r)) + I (overline(r)) + G + Delta G $

#emph[ce qui donne]

$ Delta Y = C_Y (Delta Y - Delta G) + Delta G $

#emph[On en déduit (en supposant $C_Y eq.not 1$), $Delta Y = Delta G$. Cela est surprenant à première vue : le gouvernement réussit à augmenter la demande sans s’endetter. On peut comprendre le resultat en voyant que la taxe revient à transférer des revenus d’un agent (le consommateur) vers un autre (l’état) dont la propension marginale à consommer est plus élevée. Cela dit 1/le modèle implique que la production ne dépend que de la demande ce qui est irréaliste 2/ sur le moyen terme, maximmiser la demande n’est pas optimal donc il ne faut pas surinterpréter le modèle]

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
+ #strong[Calculer et représenter sur un graphe du même type l’effet d’une baisse des taux d’intérêt nominaux en supposant que les prix sont fixes à court terme.]
]

#block[
#callout(
body: 
[
#emph[On rappelle la relation de Fisher $r = i - pi$. Si les prix sont rigides $pi = 0$ l’augmentation des taux nominaux est équivalente à la même augmentation des taux réels.]

#emph[Cette fois, différencier la relation d’équilibre donne:]

$ Delta Y = C_Y^(') Delta Y + C_r^(') Delta r + I_r^(') Delta r $

#emph[d’où l’augmentation de la production demandée:]

$ frac(Delta Y, Delta r) = frac(C_r^(') + I_r^('), 1 - C_Y^(')) $

#emph[que l’on peut aussi décomposer comme suit:]

$ frac(Delta Y, Delta r) = underbrace((C_r^(') + I_r^(')), upright("effet direct")) + underbrace((C_r^(') + I_r^(')) frac(C_Y^('), 1 - C_Y^(')), upright("effet induit")) $

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
== Agents hétérogènes
<agents-hétérogènes>
On suppose maintenant que les agents sont répartis en 2 groupes: les agents de type $H$ (hand-to-mouth), pour une fraction $lambda$, et les agents de type $S$ (savers) pour une fraction $1 - lambda$. Les agents $H$ n’ont pas accès aux marchés financiers et tous leurs revenus proviennent du travail. Les agents $S$ (pour savers) peuvent lisser leur consommation par l’epargne. Ces derniers recoivent en plus de leur travail, les revenus du capital et les profits des firmes. Les différent revenus seront définis plus bas.

#block[
#set enum(numbering: "1.", start: 5)
+ #strong[On suppose que les fonctions de consommation des deux groupes sont données par:] #strong[où $overline(Y_H)$ (resp $overline(Y_S)$) est le revenu perçu à l’équilibre par les agents $H$ (resp $S$)]

+ #strong[Justifier #emph[intuitivement] les hypothèses sur $c_Y^H$ et $c_Y^S$. A-t-on assez d’infomations pour calculer la propension marginale à consommer agrégée#footnote[La propension marginale à consommer agrégée est l’augmentation de la consommation prévue totale, lorsque le revenu total augmente d’une unité.] comme dans la question 1?]
]

#block[
#callout(
body: 
[
#emph[On a déjà vu en cours pourquoi $c_Y^H approx 1$ (ménages keynésiens) et on a parlé des ménages ricardiens pour lesquels $c_H^Y approx 0$. On aura mentionné l’arbitrage consommation travail sans faire de calcul.]

- #emph[Un ménage ricardien place son revenu pour le transformer en revenu permanent et essentiellement en consommer les intérêts à chaque période.]
- #emph[Un ménage keynésien consomme tout ce qu’il peut. S’il reçoit un revenu additionnel ce revenu sera donc consommé intégralement.]

#emph[Pour calculer la propension marginale à consommer agrégée, il manque une information sur la façon dont le revenu marginal est distribué.]

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
On fait maintenant les hypothèses suivantes sur la répartition du revenu total:

- tous les agents travaillent au même salaire $W$
- une fraction $alpha_L$ des revenus totaux revient aux travailleurs, une fraction $alpha_K$ aux détenteurs du capital et une fraction $alpha_pi$ est payée sous forme de profits au détenteurs des firmes. On a bien sûr $alpha_L + alpha_K + alpha_pi = 1$
- le gouvernements taxe les profits et les revenus du capital à un taux $tau$, pour les redistribuer aux agents $H$

#block[
#set enum(numbering: "1.", start: 7)
+ #strong[Calculer la propension marginale à consommer agrégée. Peut-elle être plus grande que 1? Quel est le multiplicateur fiscal?]
]

#block[
#callout(
body: 
[
#emph[Les revenus du travail sont $alpha_L Y$. Les revenus du capital sont $(alpha_K + alpha_Pi) Y$.] #emph[Regardons comment se répartissent les dépenses prévues en réponse à une augmentation du revenu agégé $Delta Y$.Comme le salaire est le même pour tout le monde, le revenu du travail des agents H augmente de $alpha_L lambda Delta Y$. Ils reçoivent en plus les transferts $tau (alpha_K + alpha_Pi) Delta Y$ de sorte que leur propension marginale à consommer en fonction du revenu 'total' est $ frac(Delta C^H, Delta Y) = c_Y^H (alpha_L lambda + tau (alpha_K + alpha_pi)) $] #emph[De la même façon celle des agents $S$ est];:

$ frac(Delta C^S, Delta Y) = c_Y^S (alpha_L (1 - lambda) + (1 - tau) (alpha_K + alpha_pi)) $

#emph[La propension marginale à consommer totale est donc];: .

On voit que la propension marginale à consommer croît logiquement avec la proportion $lambda$ d’agents keynésiens et avec le degré de répartition des profits $tau$. En supposant à l’extrême que $lambda$ est proche de 1, pour que la MPC soit plus grande que 1, il faudrait avoir: $tau gt.eq frac(1 - alpha_L, alpha_K + alpha_pi) = 1$ ce qui est impossible.

Considérons maintenant un choc $Delta G$ sur les dépenses gouvernementales, associé à une modification du revenu $Delta Y$. L’equation du PIB donne $Delta Y = frac(Delta C^S, Delta Y) Delta Y + frac(Delta C^H, Delta Y) Delta Y + Delta G$ d’où le multiplicateur fiscal $frac(Delta Y, Delta G) = frac(1, 1 - frac(Delta C^S, Delta Y) - frac(Delta C^H, Delta Y)) = frac(1, 1 - (alpha_L lambda + tau (alpha_K + alpha_pi)))$ c’est à dire la même formule que dans la question 2 avec une formule spécifique pour la propension marginale à consommer agrégée. #footnote[Notons que si l’on considérait ici une dépense financée par des taxes comme à la question 3, la réponse dépendrait de la nature du choc de taxation, plus précisément de quels ménages sont mis à contribution pour financer les dépenses.]

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




