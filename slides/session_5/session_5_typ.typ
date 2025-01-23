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

#import "@preview/touying:0.5.3": *
#import "@preview/fontawesome:0.3.0": *

#let new-section-slide(self: none, body)  = touying-slide-wrapper(self => {
  let main-body = {
    set align(left + horizon)
    set text(size: 2.5em, fill: self.colors.primary, weight: "bold")
    utils.display-current-heading(level: 1)
  }
  self = utils.merge-dicts(
    self,
    config-page(margin: (left: 2em, top: -0.25em)),
  ) 
  touying-slide(self: self, main-body)
})

#let slide(
  config: (:),
  repeat: auto,
  setting: body => body,
  composer: auto,
  ..bodies,
) = touying-slide-wrapper(self => {
  // set page
  let header(self) = {
    set align(top)
    show: components.cell.with(inset: (x: 2em, top: 1.5em))
    set text(
      size: 1.4em,
      fill: self.colors.neutral-darkest,
      weight: self.store.font-weight-heading,
      font: self.store.font-heading,
    )
    utils.call-or-display(self, self.store.header)
  }
  let footer(self) = {
    set align(bottom)
    show: pad.with(.4em)
    set text(fill: self.colors.neutral-darkest, size: .8em)
    utils.call-or-display(self, self.store.footer)
    h(1fr)
    context utils.slide-counter.display() + " / " + utils.last-slide-number
  }

  // Set the slide
  let self = utils.merge-dicts(
    self,
    config-page(
      header: header,
      footer: footer,
    ),
  )
  touying-slide(self: self, config: config, repeat: repeat, setting: setting, composer: composer, ..bodies)
})


#let clean-theme(
  aspect-ratio: "16-9",
  handout: false,
  header: utils.display-current-heading(level: 2),
  footer: [],
  font-size: 20pt,
  font-heading: ("Roboto"),
  font-body: ("Roboto"),
  font-weight-heading: "light",
  font-weight-body: "light",
  font-weight-title: "light",
  font-size-title: 1.4em,
  font-size-subtitle: 1em,
  color-jet: "131516",
  color-accent: "107895",
  color-accent2: "9a2515",
  ..args,
  body,
) = {
  set text(size: font-size, font: font-body, fill: rgb(color-jet),
           weight: font-weight-body)

  show: touying-slides.with(
    config-page(
      paper: "presentation-" + aspect-ratio,
      margin: (top: 4em, bottom: 1.5em, x: 2em),
    ),
    config-common(
      slide-fn: slide,
      new-section-slide-fn: new-section-slide,
      handout: handout,
      enable-frozen-states-and-counters: false, // https://github.com/touying-typ/touying/issues/72
      show-hide-set-list-marker-none: true
    ),
    config-methods(
      init: (self: none, body) => {
        show link: set text(fill: self.colors.primary)
        // Unordered List
        set list(
          indent: 1em,
          marker: (text(fill: self.colors.primary)[ #sym.triangle.filled ],
                    text(fill: self.colors.primary)[ #sym.arrow]),
        )
        // Ordered List
        set enum(
          indent: 1em,
          full: true, // necessary to receive all numbers at once, so we can know which level we are at
          numbering: (..nums) => {
            let nums = nums.pos()
            let num = nums.last()
            let level = nums.len()

            // format for current level
            let format = ("1.", "i.", "a.").at(calc.min(2, level - 1))
            let result = numbering(format, num)
            text(fill: self.colors.primary, result)
          }
        ) 
        // Slide Subtitle
        show heading.where(level: 3): title => {
          set text(
            size: 1.1em,
            fill: self.colors.primary,
            font: font-body,
            weight: "light",
            style: "italic",
          )
          block(inset: (top: -0.5em, bottom: 0.25em))[#title]
        }

        set bibliography(title: none)

        body
      },
      alert: (self: none, it) => text(fill: self.colors.secondary, it),
    ),
    config-colors(
      primary: rgb(color-accent),
      secondary: rgb(color-accent2),
      neutral-lightest: rgb("#ffffff"),
      neutral-darkest: rgb(color-jet),
    ),
    // save the variables for later use
    config-store(
      header: header,
      footer: footer,
      font-heading: font-heading,
      font-size-title: font-size-title,
      font-size-subtitle: font-size-subtitle,
      font-weight-title: font-weight-title,
      font-weight-heading: font-weight-heading,
      ..args,
    ),
  )

  body
}

#let title-slide(
  ..args,
) = touying-slide-wrapper(self => {
  let info = self.info + args.named()
  let body = {
    set align(left + horizon)
    block(
      inset: (y: 1em),
      [#text(size: self.store.font-size-title,
             fill: self.colors.neutral-darkest,
             weight: self.store.font-weight-title,
             info.title)
       #if info.subtitle != none {
        linebreak()
        v(-0.3em)
        text(size: self.store.font-size-subtitle,
             style: "italic",
             fill: self.colors.primary,
             info.subtitle)
      }]
    )

    set text(fill: self.colors.neutral-darkest)

    if info.authors != none {
      let count = info.authors.len()
      let ncols = calc.min(count, 3)
      grid(
        columns: (1fr,) * ncols,
        row-gutter: 1.5em,
        ..info.authors.map(author =>
            align(left)[
              #text(size: 1em, weight: "regular")[#author.name]
              #if author.orcid != [] {
                show link: set text(size: 0.7em, fill: rgb("a6ce39"))
                link("https://orcid.org/" + author.orcid.text)[#fa-orcid()]
              } \
              #text(size: 0.7em, style: "italic")[
                #show link: set text(size: 0.9em, fill: self.colors.neutral-darkest)
                #link("mailto:" + author.email.children.map(email => email.text).join())[#author.email]
              ] \
              #text(size: 0.8em, style: "italic")[#author.affiliation]
            ]
        )
      )
    }

    if info.date != none {
      block(if type(info.date) == datetime { info.date.display(self.datetime-format) } else { info.date })
    }
  }
  self = utils.merge-dicts(
    self,
    config-common(freeze-slide-counter: true)
  )
  touying-slide(self: self, body)
})



// Custom Functions
#let fg = (fill: rgb("e64173"), it) => text(fill: fill, it)
#let bg = (fill: rgb("e64173"), it) => highlight(
    fill: fill,
    radius: 2pt,
    extent: 0.2em,
    it
  )
#let _button(self: none, it) = {
  box(inset: 5pt,
      radius: 3pt,
      fill: self.colors.primary)[
    #set text(size: 0.5em, fill: white)
    #sym.triangle.filled.r
    #it
  ]
}

#let button(it) = touying-fn-wrapper(_button.with(it))

#show: clean-theme.with(
  aspect-ratio: "16-9",
                        )

#title-slide(
  title: [Demande Agrégée],
  subtitle: [ECO432 - Macroéconomie],
  authors: (
                    ( name: [Pablo Winant],
            affiliation: [],
            email: [],
            orcid: []),
            ),
  date: [],
)

== Programme des séances
<programme-des-séances>
- Séance 5 : demande globale
- Séance 6 : offre globale
- Séance 7 : fluctuations macroéconomiques
- Séance 8 : politique monétaire

#horizontalrule

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

== Taux d’Intérêt Réel
<taux-dintérêt-réel>
Le #strong[taux d’intérêt réel] $r_t$ est défini par :

$ #box(stroke: black, inset: 3pt, [$ 1 + r_t = frac(1 + i_t, 1 + pi_(t + 1)) $]) $

Il mesure à quel point il est bénéfique d’échanger des biens de consommation actuels contre des biens de consommation futurs.

En logarithmes:

$ #box(stroke: black, inset: 3pt, [$ r_t = i_t - pi_(t + 1) $]) $

Cette relation est parfois appelée l’#strong[équation de Fisher];.

== Mini-check
<mini-check>
#block[
#block[
#box(image("assets/check.jpg"))

]
#block[
==== Quizz 1
<quizz-1>
Supposons que le taux d’intérêt nominal soit de 4% et l’inflation de 5%. Quel est le taux d’intérêt réel (en pourcentage) ?

+ 1
+ -1
+ 4/5
+ 5/6

. . .

==== Quizz 2
<quizz-2>
L’effet fishérien est la tendance de l’inflation à augmenter et à annuler toute hausse des taux nominaux par la banque centrale. Cela est plus susceptible de se produire si :

+ le taux réel est indépendant des variables nominales
+ les prix sont rigides
+ l’inflation est élevée
+ la dette est élevée

…

]
]
= Demande
<demande>
== Les composantes de la demande
<les-composantes-de-la-demande>
Dans une économie de marché, les décisions de dépenses sont prises par :

- Les consommateurs
- Les entreprises
- Les exportateurs et les importateurs
- Le gouvernement

Les dépenses du gouvernement sont décidées par les décideurs politiques. Parce qu’elles peuvent être choisies indépendamment du niveau de revenu général, elles sont entièrement #strong[autonomes];.

Dans ce cours, nous considérerons également les décisions des exportateurs et des importateurs comme exogènes afin de nous concentrer sur les consommateurs et les entreprises.#footnote[Pour nos besoins, nous pourrions également faire l’hypothèse plus forte que l’économie est #strong[fermée];, c’est-à-dire que les exportations et les importations sont nulles.]

#horizontalrule

== Notre objectif principal aujourd’hui
<notre-objectif-principal-aujourdhui>
Établir pourquoi et comment chacune des composantes de la demande dépend du $Y$ et du $r$.”

= Consommateurs
<consommateurs>
== Décisions de Consommation
<décisions-de-consommation>
#block[
#block[
#box(image("assets/why_do_save_today.png", height: 25%))

#box(image("assets/why_do_save.png", height: 50%))

#box(image("assets/why_do_save_r.png", height: 50%))

]
#block[
Pourquoi les consommateurs épargnent-ils ?

. . .

Pour substituer les biens présents par les biens futurs.

. . .

Qu’est-ce qui détermine la substitution ?

. . .

Le taux d’intérêt (réel)

. . .

Qu’est-ce qui détermine également la substitution ?

. . .

Le revenu aujourd’hui et demain

]
]
== Décisions de consommation
<décisions-de-consommation-1>
=== Intuition
<intuition>
Selon leurs préférences, le montant que les consommateurs décident de dépenser est déterminé par :

Leur revenu aujourd’hui ( $Y_t$ ) Leur revenu attendu dans le futur ( $Y_(t + 1) , Y_(t + 2) , . . .$ )

~~~

Étant donné leur profil de revenu attendu, la décision de consommer peut être vue comme un arbitrage entre la consommation aujourd’hui et la consommation demain.

Cet arbitrage dépend du taux d’intérêt intertemporel réel ( $r_t$ ).

Les deux déterminants à court terme de la consommation devraient donc être $Y_t$ et $r_t$.

== Consumers: Ricardian and Keynesian households
<consumers-ricardian-and-keynesian-households>
Classiquement, on distingue :

~~~

#block[
#block[
#strong[Ménages Ricardiens]

~~

Des agents qui peuvent librement réaffecter la consommation intertemporelle.

~ \

Les ménages Ricardiens choisissent de ne pas consommer davantage aujourd’hui, afin de consommer davantage demain.

]
#block[
#strong[Ménages Keynésiens]

~~

Des agents dont la consommation dans la période actuelle est limitée par une contrainte de crédit contraignante.

Soit ils ne peuvent pas du tout emprunter, soit le montant qu’ils peuvent emprunter aujourd’hui est limité.

~ \

Les ménages Keynésiens consomment aujourd’hui autant qu’ils le peuvent.

]
]
. . .

Nous étudierons les deux types d’agents tour à tour, en commençant par les agents Ricardiens.

#horizontalrule

=== Consommateurs Ricardiens
<consommateurs-ricardiens>
==== Consommateurs Ricardiens
<consommateurs-ricardiens-1>
Modélisons le choix intertemporel d’un ménage Ricardien. Ce sont des décideurs rationnels, mais ils ont une préférence pour le présent. Pour des raisons d’exposition, nous supposons qu’ils vivent seulement pendant deux périodes.

Désignons par $C_1$ and $C_2$ la consommation aujourd’hui et demain.

Un consommateur représentatif maximise : $ U (C_1 , C_2) = log (C_1) + beta log (C_2) $

où $beta < 1$ est un facteur d’actualisation, indiquant que la consommation aujourd’hui est préférée. $beta$ est généralement proche de 1.

Cette optimisation n’est pas libre, elle est soumise à une contrainte budgétaire.

#horizontalrule

=== Consommateurs Ricardiens
<consommateurs-ricardiens-2>
==== Détermination de la contrainte budgétaire (1)
<détermination-de-la-contrainte-budgétaire-1>
Notons $P_1 = 1$ le niveau actuel des prix, at $P_2$ le niveau futur.

Notons $P_1 Y_1$ le revenu nominal présent et $P_2 Y_2$ le revenu nominal futur.

On suppose que notre consommateur consomme $C_1$ au prix .$P_1$ pour un montant $C_1 P_1$

Ce qui reste#footnote[Remarquons que la formule est exactement la même selon que le consommateur épargne $(C_1 P_1 < Y_1 P_1)$ ou emprunte $(C_1 P_1 > Y_1 P_1)$ en période 1.];, i.e.~$Y_1 P_1 - C_1 P_1$ est épargné au taux nominal $1 + i$ et ajouté au revenu futur.

La contrainte de budget en période 2 s’écrit:

$ C_2 P_2 lt.eq (underbrace(Y_1 P_1 - C_1 P_1, upright("Savings"))) (1 + i) + Y_2 P_2 $

== Consommateurs
<consommateurs-1>
==== Détermination de la contrainte budgétaire (2)
<détermination-de-la-contrainte-budgétaire-2>
La dernière équation peut être réorganisée comme suit :

$ C_1 P_1 (1 + i) + C_2 P_2 lt.eq Y_1 P_1 (1 + i) + Y_2 P_2 $

Divisons par $P_2$

$ C_1 P_1 / P_2 (1 + i) + C_2 lt.eq Y_1 P_1 / P_2 (1 + i) + Y_2 $

Et reconnaissons $1 + pi = P_2 / P_1$

$ C_1 frac(1 + i, 1 + pi) + C_2 lt.eq Y_1 frac(1 + i, 1 + pi) + Y_2 $

== Consommateurs
<consommateurs-2>
\#\#\#\#{Contrainte budgétaire intertemporelle}

Finalement, la contrainte budgétaire intertemporelle se lit comme suit :

$ C_1 (1 + r) + C_2 lt.eq Y_1 (1 + r) + Y_2 $

Le #emph[côté droit] est le revenu et est donné dans l’optimisation. Il correspond à la richesse totale.

Dans le #emph[côté gauche] : $(1 + r)$ peut être compris comme le prix des biens de consommation d’aujourd’hui.

Quel est l’effet d’un taux d’intérêt réel plus élevé ?

- La consommation aujourd’hui est plus chère : effet de substitution -\> plus de consommation de biens futurs, moins de consommation dans le présent
- Le revenu d’aujourd’hui est plus précieux : il détend la contrainte budgétaire créant un effet de richesse direct -\> plus de consommation des deux biens

== Consommateurs
<consommateurs-3>
Un consommateur résout $ max_(C_1 , C_2) &  & U (C_1 , C_2)\
s . t . &  & C_1 (1 + r) + C_2 lt.eq Y_1 (1 + r) + Y_2 $

Il s’agit d’un problème d’optimisation sous contrainte, identique à ceux rencontrés en microéconomie.

On obtient facilement la consommation optimale (consommation souhaitée) en période $1$:

$ #box(stroke: black, inset: 3pt, [$ C_1 = frac(1, 1 + beta) (Y_1 + frac(1, 1 + r) Y_2) $]) $

== Ménages Ricardiens
<ménages-ricardiens>
Comment interprétons-nous cette formule optimale ? $ C_1 = frac(1, 1 + beta) underbrace((Y_1 + frac(1, 1 + r) Y_2), upright("Revenu Permanent")) $

Le revenu permanent est la valeur actualisée de tous les revenus perçus par le consommateur sur son horizon d’optimisation. il s’agit essentiellement de la valeur du revenu sur toute la vie similaire à l’évaluation d’un flux de dividendes

Un ménage Ricardien dépense en période 1 une fraction de son revenu permanent.

~

Cela découle d’un motif de lissage de la consommation dans le temps, qui provient de la concavité de la fonction d’utilité.

~

Dans le cas à deux périodes, la fraction est $frac(1, 1 + beta) approx 1 / 2$. S’il y avait plus de deux périodes, la fraction serait encore plus petite.

== Réponse au taux d’intérêt
<réponse-au-taux-dintérêt>
À partir de la dernière formule, nous pouvons voir comment les ménages Ricardiens modifient leur consommation en réponse à un changement $Delta r$ dans les taux d’intérêt réels. Alors la consommation augmente de $Delta C$ de telle sorte que : $ C_1 + Delta C = frac(1, 1 + beta) (Y_1 + frac(1, 1 + r + Delta r) Y_2) $

Cela conduit à la formule approximative :

$ #box(stroke: black, inset: 3pt, [$ frac(Delta C, Delta r) = - frac(1, 1 + beta) 1 / (1 + r)^2 Y_2 $]) $

En accord avec l’intuition : la consommation aujourd’hui est plus faible lorsque le taux d’intérêt réel est plus élevé.

== Choc de revenu temporaire
<choc-de-revenu-temporaire>
Comment réagissent les ménages Ricardiens aux chocs de revenu ?

Supposons que le revenu augmente temporairement (en période $1$) de $Delta Y$. Alors la consommation augmente de $Delta C$ de telle sorte que : $ C_1 + Delta C = frac(1, 1 + beta) underbrace((Y_1 + Delta Y + frac(1, 1 + r) Y_2), upright("Revenu Permanent")) $

Nous obtenons une propension marginale à consommer (à partir d’un choc temporaire) égale à#footnote[Nous avons utilisé deux périodes pour simplifier l’exposition. Dans les modèles NK pratiques, le revenu permanent est $sum_t 1 / (1 + r)^t Y_t$ et la fraction consommée en première période serait $(1 - beta) approx 0$, ce qui est très proche de 0.] :

$ M P C^(upright("ricardian")) = frac(Delta C, Delta Y) = frac(1, 1 + beta) < < 1 $

== Ménages Keynésiens
<ménages-keynésiens>
Intrinsèquement, les agents keynésiens ont les mêmes préférences en matière de consommation que les ménages ricardiens.

#block[
#block[
]
#block[
Idéalement, ils aimeraient dépenser une fraction de leur revenu permanent, mais ils sont confrontés à une limite quant à la somme qu’ils peuvent emprunter.

]
#block[
#box(image("assets/../bank_no.jpg", width: 0.52083333333333in))

]
]
Un agent keynésien pur (qui ne peut pas emprunter du tout) est soumis à la contrainte simple $C_1 lt.eq Y_1$ et puisqu’elle consomme autant que possible, sa consommation est simplement : $ C_1 = Y_1 $

Sa propension marginale à consommer est :

$ P M C^(upright("keynésien")) = 1 $

==== Quiz 3
<quiz-3>
Parmi les agents suivants, lequel est le plus susceptible d’être keynésien ?

+ un étudiant qui envisage une offre de prêt de la banque pour couvrir les frais universitaires
+ un ménage de classe moyenne réduisant les dépenses alimentaires pour rembourser un prêt en cours
+ un travailleur à faible revenu aux États-Unis, qui n’a pas de carte de crédit
+ un trader boursier

== Consommation Agrégée
<consommation-agrégée>
Pour connaître le comportement de la consommation agrégée, en particulier la propension marginale à consommer agrégée, nous devons connaître la proportion de ménages ricardiens et keynésiens.#footnote[Vous verrez lors du PC5, que le comportement de la consommation agrégée dépend crucialement de la nature redistributive des chocs.]

#block[
#block[
#figure([
#box(image("assets/keynesian_dog.png", width: 60%))
], caption: figure.caption(
position: bottom, 
[
Un chien keynésien, lors de la récession de 1929
]), 
kind: "quarto-float-fig", 
supplement: "Figure", 
)


]
#block[
#figure([
#box(image("assets/ricardian_cat.png", width: 60%))
], caption: figure.caption(
position: bottom, 
[
Un chat ricardien, jouant avec de l’argent.
]), 
kind: "quarto-float-fig", 
supplement: "Figure", 
)


]
]

#horizontalrule

Jetons un coup d’œil à la distribution de la PMC pour la France.#footnote[Tiré de Politique Budgétaire et Hétérogénéité de la PMC, Tullio Jappelli et Luigi Pistaferri, American Economic Journal: Macroeconomics, 2014]

#figure([
#box(image("assets/mpc_1.png", width: 60%))
], caption: figure.caption(
position: bottom, 
[
PMC en Réponse à un Choc de Revenu Temporaire (Autodéclarée)
]), 
kind: "quarto-float-fig", 
supplement: "Figure", 
)

#horizontalrule

#figure([
#box(image("assets/mpc_2.png", width: 60%))
], caption: figure.caption(
position: bottom, 
[
PMC Moyenne par Percentiles de Trésorerie
]), 
kind: "quarto-float-fig", 
supplement: "Figure", 
)


. . .

Apparemment, la PMC est bien prédite par la Trésorerie (montant d’argent restant au ménage après avoir effectué tous les paiements obligatoires).

#horizontalrule

#figure([
#box(image("assets/mpc_3.png", width: 60%))
], caption: figure.caption(
position: bottom, 
[
Distribution de la Richesse
]), 
kind: "quarto-float-fig", 
supplement: "Figure", 
)

#horizontalrule

#figure([
#box(image("assets/mpc_4.png", width: 60%))
], caption: figure.caption(
position: bottom, 
[
Décomposition de la Richesse
]), 
kind: "quarto-float-fig", 
supplement: "Figure", 
)


. . .

Les agents au milieu de la distribution de la richesse ont une hypothèque, dont les intérêts laissent très peu à dépenser après les paiements. Ils ont une trésorerie plus faible, donc une propension marginale à consommer plus élevée (que les agents riches).

#horizontalrule

== Agents Fortunés Vivant au Jour le Jour (Hand to Mouth)
<agents-fortunés-vivant-au-jour-le-jour-hand-to-mouth>
Nous venons de voir que les agents au milieu de la distribution de la richesse détiennent une plus grande proportion de richesse sous forme d’actifs illiquides (logements)

- Leur trésorerie (disponible pour des achats immédiats) est réduite. Une fraction importante de leurs revenus est consacrée au remboursement de leur prêt…).
- Ils ont une PMC plus élevée
- Ils réagissent également aux variations des taux d’intérêt (notamment ceux qui ont des taux d’intérêt variables)
- Dans un article très influent, "Monetary Policy According to HANK", 2018, Kaplan, Moll and Violante, mettent en évidence le rôle des agents Hand-to-Mouth et la nécessité de prendre en compte leur existence pour évaluer l’influence des politiques monétaires.

= Producteurs
<producteurs>
== Producteurs
<producteurs-1>
Comment la demande des producteurs en biens d’investissement dépend-elle du taux d’intérêt ?

. . .

Prenons une entreprise hypothétique.

. . .

Elle a besoin de capital pour produire.

. . .

Pour acheter plus de capital, l’entreprise peut emprunter à un taux réel $r$. Elle devra rembourser le prêt une fois la production terminée. Le taux réel est appelé le coût externe des fonds.

. . .

Intuitivement, plus le coût des fonds est faible, plus il est facile d’emprunter, et plus l’entreprise cherchera à acheter des biens de capital.

Ainsi, #strong[la demande d’investissement des entreprises diminue avec le taux d’intérêt];.

== Producteurs
<producteurs-2>
Une entreprise produit $f (K)$ en utilisant du capital K. Nous supposons des rendements marginaux décroissants dans la production, c’est-à-dire $f^('') (K) < 0$ (et bien sûr $f^(') (K) > 0$).

Supposons que l’entreprise emprunte une quantité I pour financer K, c’est-à-dire $K = I$. Après la production, elle doit rembourser I(1+r) dans la période suivante.

Le programme de maximisation des bénéfices se lit comme suit : $ max pi = f (I) - I (1 + r) $

Lorsque l’entreprise est libre d’emprunter autant qu’elle le souhaite, la condition d’optimalité est:$ f^(') (I) = 1 + r $

Cela définit implicitement $I (r)$. Étant donné que $f^(') (I)$ décroît en fonction de $I$, #strong[$I (.)$ est une fonction décroissante de r];.

== Reality Check
<reality-check>
#box(image("assets/investment.png"))

== Reality Check
<reality-check-1>
#block[
#block[
#box(image("assets/investment.png"))

]
#block[
- Ces dernières années, il semble que le canal de l’investissement n’ait pas très bien fonctionné.

- Au cours des deux dernières crises, et après, les taux d’intérêt étaient très bas. Et l’investissement était également faible.

]
]
. . .

Il y a de nombreuses raisons à cela :

- Incertitude concernant les résultats économiques
  - Les entreprises averses au risque qui font face à une valeur incertaine de la production produisent moins
- Même si le taux réel est bas, les conditions de financement auxquelles les entreprises sont confrontées peuvent être différentes
  - Les banques sont également averses au risque

== Producteurs
<producteurs-3>
Au-delà du coût de financement, pouvez-vous penser à d’autres raisons pour lesquelles l’investissement pourrait être réduit par les entreprises ?

- Une partie du capital préexistant appartient à l’entreprise, ce qui signifie qu’il n’est pas toujours nécessaire d’emprunter
- Tous les emprunts ne sont pas à court terme (et ne doivent pas être remboursés immédiatement après la production)
- De nombreuses entreprises ont des contraintes de crédit
  - En pratique, leur capacité à emprunter est limitée par le capital préexistant qu’elles ont et qu’elles utilisent comme "collatéral"

= Dérivation de la Demande Agrégée
<dérivation-de-la-demande-agrégée>
== La Courbe IS
<la-courbe-is>
Notre travail sur le comportement des consommateurs et des entreprises nous permet d’écrire. $ C (Y , r) & = & C_0 + C_Y Y + C_r r\
I (r) & = & I_0 + I_r r $

où $I_r < 0$ et où les valeurs $C_Y > 0$ et $C_r < 0$ dépendent de la proportion de ménages ricardiens et keynésiens.

Donc, si nous prenons $G$ et $N X$ comme exogènes, la somme de toutes les composantes de dépenses est :

est : $ C (Y , r) + I (r) + G + N X $

. . .

Est-ce que cela représente la Demande Agrégée ? #strong[Non !]

== Courbe IS
<courbe-is>
En macroéconomie, le côté demande de toute l’économie est caractérisé par la relation :

$ Y = C (Y , r) + I (r) + G + N X $

qui lie #emph[implicitement] la production et le taux d’intérêt réel.

Cette relation est appelée équilibre #strong[Investissement-Épargne] (courbe IS) car elle traduit un compromis intertemporel (à travers le taux d’intérêt réel).

Elle correspond à un équilibre sur le marché des biens et services, déterminé par les préférences de dépenses, avec une production parfaitement élastique.

== Courbe IS
<courbe-is-1>
Quelques remarques :

- la relation IS microfondée n’implique que des quantités réelles
- elle implique uniquement des décisions rationnelles des consommateurs et des entreprises
- la demande peut être microfondée sans nécessiter de monnaie ou de prix

Fait intéressant, la microfondation de la demande montre qu’elle est parfaitement cohérente avec l’approche néoclassique.

Il n’y a pas de controverse dans la profession concernant l’existence de la courbe de demande. Il y a des désaccords concernant :

- la propension marginale à consommer agrégée et le multiplicateur fiscal
- la courbe d’offre…

== Courbe IS
<courbe-is-2>
Jusqu’à présent, nous avons justifié les dépendances suivantes pour les composantes des dépenses du PIB : $ C (Y , r) + I (r) + G + N X $

À l’équilibre du PIB et du taux d’intérêt, nous avons : $ Y_0 = C_0 + I_0 + G_0 + N X_0 $

On peut différentier l’équation ci-dessus pour obtenir :

$ Y_0 + Delta Y = C_0 + C_Y Delta Y + C_r Delta r + I_r Delta r + G_0 + N X_0 + Delta S $

Où $Delta S = Delta G + Delta N X$ capture le choc à la demande. Après soustraction des constantes, on obtient une approximation linéaire : $ Delta Y = C_Y Delta Y + C_r Delta r + I_r Delta r + Delta S $

== Courbe IS
<courbe-is-3>
On peut différencier la courbe IS pour obtenir : $ Delta Y = C_Y Delta Y + C_r Delta r + I_r Delta r $

En logarithmes:

$ frac(Delta Y, Y) = C_Y frac(Delta Y, Y) + C_r / Y Delta r + I_r / Y Delta r $

Avec $y = frac(Delta Y, Y)$ et $Delta r = r - r^star.op$ on obtien l’équation décrivant la courbe IS: $ y = - sigma (r - r^star.op) $

où $ sigma = frac(- (C_r / Y + I_r / Y), 1 - C_Y) > 0 $.

#horizontalrule

== Courbe IS
<courbe-is-4>
Dans ce qui suit, nous considérerons une version légèrement modifiée de la courbe IS

$ #box(stroke: black, inset: 3pt, [$ y_t = - sigma (r_r - r^star.op) + theta_t $]) $

où $sigma = frac(- (C_r / Y + I_r / Y), 1 - C_y) > 0$ et $theta_t$ est un choc de demande, qui capture tous les chocs externes au modèle ou que nous avons négligés pour simplifier.

Par exemple, les revenus futurs des consommateurs ont été exclus de toutes les équations. Si les attentes des consommateurs changent positivement (optimisme), nous le considérerions comme un changement dans $theta_t$.

De la même manière, une augmentation des dépenses publiques est un déplacement autonome de la courbe IS, que nous capturons par un déplacement de $theta_t$.

== Exercice pour interpéter $sigma$
<exercice-pour-interpéter-sigma>
#block[
#block[
]
#block[
==== Quizz 4
<quizz-4>
Trouvez l’affirmation incorrecte parmi les suivantes :

~

- Une PMC plus élevée implique une élasticité plus élevée de la demande aux chocs de revenu pour les ménages keynésiens
- Une élasticité plus élevée de la deamnde au taux d’intérêt signifie une réponse plus élevée de la demande à la politique monétaire pour les ménages et les entreprises ricardiens

]
]
= Le rôle de la Banque Centrale
<le-rôle-de-la-banque-centrale>
== Politique Monétaire
<politique-monétaire>
L’objectif principal de la banque centrale consiste à #emph[stabiliser l’inflation] $pi$ autour de sa cible $pi^star.op$

. . .

- Elle atteint cet objectif en #emph[influençant la demande] en réponse aux fluctuations des cycles économiques

. . .

- La demande est affectée par le taux d’intérêt #emph[réel] $r$
  - plus précisément, les ménages et les entreprises ricardiens réagissent au taux d’intérêt réel

== Politique Monétaire
<politique-monétaire-1>
- En pratique, la banque centrale fixe le taux d’intérêt #emph[nominal] $i$

  - Comme l’inflation ne suit pas le taux d’intérêt 1 pour 1, la banque centrale est capable d’influencer le taux d’intérêt réel#footnote[on rappelle l’équation de Fisher $r_t = i_t - pi_(t + 1)$}]

- Pour simplifier, on suppose que la banque centrale choisit indirectement le taux d’intérêt réel à n’importe quel niveau qu’elle souhaite

- On peut alors décrire la fonction de réponse de la banque centrale#footnote[on suit ici l’approche de Romer 2002.] comme suit : $ #box(stroke: black, inset: 3pt, [$ r_r = r^star.op + gamma (pi_t - pi^star.op) $]) $

. . .

- En général, les banques centrales augmentent le taux d’intérêt pour réduire l’inflation, donc $gamma > 0$

= Demande Agrégée
<demande-agrégée>
== Demande Agrégée
<demande-agrégée-1>
Maintenant que nous disposons de la courbe (IS) : $ y_t = - sigma (r_t - r^star.op) + theta_t $

Et de la réponse de la politique de la banque centrale (MP) : $ r_t = r^star.op + gamma (pi_t - pi) $

On peut substituer le taux d’intérêt réel pour obtenir une équation de demande agrégée (AD) : $ #box(stroke: black, inset: 3pt, [$ y_t = - sigma gamma (pi_t - pi^star.op) + theta_t $]) $

où $theta_t$ est le choc de demande.

Cette courbe représente l’équilibre sur les marchés des biens et des services, en tenant compte de la règle de décision de la banque centrale.

== Courbe de Demande Agrégée#footnote[Dans certains manuels, vous trouverez les prix agrégés $P_t$ sur l’axe des ordonnées au lieu de l’inflation. Parce que $P_(t - 1)$ est donné et que l’inflation est $pi_t = P_t \/ P_(t - 1)$, c’est en fait équivalent.]
<courbe-de-demande-agrégéefootnote13>
#block[
#block[
#box(image("assets/as_ad.png"))

]
#block[
Demande Agrégée (AD) : $ y_t = theta_t - sigma gamma (pi_t - overline(pi)) $

Notez que la demande agrégée $y_t$ est une fonction décroissante de l’inflation (et des prix).

]
]
== Résumé Exécutif
<résumé-exécutif>
- La demande agrégée peut être fondée sur la micro-optimisation rationnelle des consommateurs et des entreprises
  - Les ménages keynésiens ont une propension marginale à consommer élevée
  - Les ménages ricardiens ont une propension marginale à consommer faible et réagissent (négativement) au taux d’intérêt réel
  - Les entreprises investissent moins lorsque le taux d’intérêt réel est plus élevé

~

- La demande agrégée est décroissante (en l’inflation)

- Pour stabiliser l’inflation, la banque centrale stimule la demande en modifiant le taux d’intérêt réel. Elle le fait indirectement en fixant le taux d’intérêt nominal.

  - …on verra dans la dernière session #emph[comment] la BC influence le taux nominal

== À Suivre
<à-suivre>
#strong[Offre Agrégée] : pourquoi est-elle croissante à court terme ?
