#import "pc_template.typ": pc, correction

#let correct = sys.inputs.at("correct", default: "false") == "true"

#show: doc => pc(
  3,
  [Coûts de catalogue],
  doc,
  correct: correct,

)

#let correction = correction.with(visible: correct)

On considère le modèle suivant de concurrence monopolistique avec rigidités nominales sur le marché des biens. Les firmes forment un continuum de longueur 1, indexé par $i in [0,1]$. Chaque firme maximise son profit réel et fait face à la fonction de demande

$
Y_i=Y ( frac(P_i,P) ) ^(-eta) eta >1
$<demande-relative> 

où $Y_(i)$ firme $i$, $P_(i)$ le prix de vente nominal du bien qu'elle produit, $P$ le niveau général de prix défini par $ P=(integral_i P_i^(1-eta) dif i)^(1/(1-eta)) $ et $Y$ la demande agrégée. Les firmes sont dotées de la fonction de production $Q_(i)=L_(i)$ où $L_i$ est le travail employé par la firme $i$. On note $L^d = integral_i L_i dif i$ la demande de travail totale.

Pour simplifier, on ne micro-fondera pas ici l'offre de travail. On suppose simplement qu'elle est donnée par:
$
L^o=A ( frac(W,P) ) ^(xi)
$

où $xi >0$ est l'élasticité de l'offre de travail au salaire, $W$ le salaire nominal et

$
A=( frac(eta,eta -1)) ^(xi) >0
$

une constante d'échelle. 



Enfin, on suppose que la demande agrégée, est donnée  par:

$
y=theta-p
$<demande-agregee>
où $theta$ est un choc de demande. 
Par convention, les lettres minuscules désignent le logarithme des lettres majuscules correspondantes. 

Dans cet exercice, on raisonnera toujours au voisinage de l'équilibre symétrique où toutes les firmes fixent le même prix de vente, ce qui implique que le log de l'indice des prix $p=ln P$ est en première approximation égal à la moyenne des prix de vente individuels en log $p_(i)=ln P_(i)$ de sorte que l'on a:

$
p tilde.eq integral_0^1 p_(i) dif i
$

et de même pour la demande de travail totale en log :

$
l^d tilde.eq integral_0^1 l_(i) dif i
$


=== Première partie : prix de vente optimal et équilibre naturel



+ Interpréter les équations du modèle.
#correction[
  L’équation @demande-relative est la demande relative adressée au secteur $i$ sur un marché de concurrence monopolistique ou les biens sont imparfaitement substituables. La demande relative pour le bien $i$ , $Y_i slash Y comma$ est décroissante de son prix relatif $P_i slash P$. L’impact d’une variation de prix relatif sur la demande relative dépend de $eta$, qui paramétrise l’élasticité de substitution entre les biens. L’équation
  de demande agrégée @demande-agregee est  une version simplifiée de la demande agrégée vu dans le cours, avec le niveau de  prix au lieu du taux d’inflation (mais rappelez-vous $pi_t approx p_t minus p_(t minus 1)$); la relation négative entre $p$ et $y$ est obtenue parce que la banque centrale augmente le taux d’intérêt réel lorsque les prix augmentent, ce qui déprime la production.
]

#set enum(numbering: "1.", start: 2)

+ Calculer le prix de vente optimal de la firme, $P^star$, en fonction du salaire nominal $W$, et interpréter.

#correction[
La firme $i$ choisit le prix de vente $P_i$ qui maximise son profit
  $Theta_i$ sous deux contraintes (sa fonction de production et la
  demande relative pour le bien $i paren.r$ et en prenant $Y$ et $P$
  comme donnés. Elle maximise donc
  $ Theta_i eq P_i / P Q_i minus W / P L_i $ sous les contraintes
  $ Q_i eq L_i upright(",   ") Q_i eq Y_i eq Y lr((P_i / P))^(minus eta) $
  Autrement dit, la firme résoud :
  $ max_(P_i) eq Y lr((P_i / P))^(minus eta) lr((P_i / P minus W / P)) $
  La CPO donne le prix réel optimal suivant :
  $ P^ast.basic / P eq lr((frac(eta, eta minus 1))) W / P $<prix-reel-optimal> où
  $eta slash lr((eta minus 1))$ est le facteur de marge. Soit, en log,
  $ p^ast.basic eq ln lr((frac(eta, eta minus 1))) plus w $

]
Dans ce qui suit, exprimez toutes les variables en logarithme.

#set enum(numbering: "1.", start: 3)

+ Utiliser l'équilibre sur le marché du travail pour exprimer le prix réel optimal $p^(star)-p$ en fonction de $y$ et expliquer le résultat  obtenu.


#correction[
Comme la fonction de production en log s’écrit $q_i eq l_i$ et que la
  firme $i$ produit une quantité de bien égale à la demande qui lui est
  adressée ($q_i eq y_i$), la demande de travail de la firme $i$ en log est
  égale à $y_i$. La demande totale de travail dans l’économie est donc,
  en utilisant l’équation @demande-relative#footnote[La demande totale de travail est donnée par
  $L^d tilde.eq integral_0^1 L_i dif i$.
  Cependant, comme on raisonne au
  premier ordre et au voisinage de l’équilibre stationnaire, on a
  également :
  $ ln L^d tilde.eq integral_0^1 ln L_i upright("d") i dot.basic $] :
  $ l^d & tilde.eq & integral_0^1 l_i upright("d") i & eq &  integral_0^1 y_i upright("d") i eq y minus eta lr((integral_0^1 p_i upright("d") i minus p))\
   & eq  & y dot.basic  & $ Pour passer à la dernière ligne de ce calcul, on
  a utilisé le fait qu’on était (par hypothèse) au voisinage de
  l’équilibre symétrique, de sorte que le log de l'index des prix est en
  première approximation donné par la moyenne des prix en log :
  $ p tilde.eq integral_0^1 p_i upright("d") i dot.basic $ L’équilibre
  sur le marché du travail (en log) implique donc :
  $ underbrace(y, l^d) #h(0em) eq #h(0em) underbrace(xi ln lr((frac(eta, eta minus 1))) plus xi lr((w minus p)), l^o) $<lm>
  Par ailleurs, le prix optimal satisfait (cf. question 2) :
  $ p^ast.basic eq ln lr((frac(eta, eta minus 1))) plus w $ En utilisant
  la seconde équation pour éliminer $w$ de la premiere, on trouve
  $ p^ast.basic minus p eq 1 / xi y $ Un niveau de production ($y$) plus
  élevé fait augmenter la demande de travail ($l^d$), ce qui exerce une
  pression à la hausse sur les salaires réels (déplacement de la demande
  de travail, qui est verticale dans le plan
  $lr((l comma w minus p)) comma$ le long de la courbe d’offre de
  travail, qui est linéaire et croissante dans le plan
  $lr((l comma w minus p))$. Cette pression est d’autant
  plus élevée que l’élasticité de l’offre de travail, $xi$, est faible
  (dans le plan $lr((l comma w minus p)) comma$ la pente de $l^o$ est
  d’autant plus élevée que $xi$ est faible). La règle de marge implique
  que cette hausse du coût marginal se répercute sur le prix réel
  optimal $p^ast.basic minus p$.

  En utilisant la DA, nous obtenons:

  $ p^ast.basic eq p plus 1 / xi lr((theta minus p)) $

  Le prix optimal dépend du niveau de prix (sauf si $xi eq 1$). Lorsque
  p augmente, il y a deux effets. Premièrement, en utilisant l’équation
  du marché du travail @lm, nous obtenons que pour un
  y donné, un niveau de prix plus élevé $p$ conduit à un salaire plus
  élevé, ce qui augmente le prix optimal. Deuxièmement, un niveau de
  prix plus élevé $p$ baisse la demande globale ($y eq theta minus p$),
  ce qui diminue le prix optimal. Lorsque $xi eq 1$ les deux effets
  s’annulent et $p^ast.basic$ ne dépend pas du niveau de prix. Ce cas
  simplifiera l’analyse dans la deuxième partie de l’exercice.

]


#set enum(numbering: "1.", start: 4)

+ Calculer l'équilibre de prix flexibles ($y^n,p^n$) lorsque $theta=theta_0=0$.

#correction[Sur l’équilibre de prix flexibles on a $p_i eq p^ast.basic eq p$
  (toutes les firmes choisissent le prix optimal, qui est donc le prix
  moyen dans l’ économie). On a ainsi :
  $ y & eq & y^n eq 0 upright(" ") paren.l arrow.r.double Y^n eq e^(y^n) eq 1 upright(")")\
  p^n & eq & theta_0 minus y^n eq 0 upright(" ") paren.l arrow.r.double P^n eq e^(p^n) eq 1 upright(")") $]


=== Deuxième partie : coûts de catalogue hétérogènes et pente de l'arbitrage

On suppose dans cette partie que $xi =1$, et que l'économie est à l'équilibre naturel ($y^n,p^n$) avant un choc de demande de taille $Delta theta=theta_1-theta_0$ ($=theta_1$). Les firmes font face à des coûts fixes de changement de prix (coûts de catalogues), de sorte qu'elles peuvent rationnellement
choisir de maintenir leur prix de vente au niveau $p^n$ même après le choc. Les coûts de catalogue diffèrent d'une firme à l'autre : en classant les firmes $i in [ 0,1] $ par ordre croissant de coût de catalogue, on suppose que la firme $i$ fait face au coût :
$ z( i ) =overline(z) i $ où $overline(z)$ est une constante positive.

#set enum(numbering: "1.", start: 5)

+ Le choix d'un prix de vente $p_(i) eq.not p^star$ engendre une perte de profit. Au voisinage de l'équilibre symétrique (où $p^star tilde.eq p$) la perte est de second ordre et égale à $K (p_ (i) -p ^ star ) ^ 2 $, où $K> 0$ est une constante positive.#footnote[Il n'est pas nécessaire de dériver ce résultat.] Plus l'écart entre le prix courant  et le prix optimal  est important, plus la perte est importante.  Calculer la proportion $omega in [ 0,1] $ de firmes maintenant leur prix inchangé en fonction du nouveau prix optimal $p^star$ prévalant après le choc, et interpréter.

#correction[

  Puisqu’on était à l’équilibre naturel avant le choc $Delta theta$, la
  perte de profit associée au maintien de l’ancien prix alors que le
  nouveaux prix optimal est $p^ast.basic$ est donnée par
  $K lr((p^n minus p^ast.basic))^2 eq K (p^(ast.basic))^2$. La firme $i$
  ne change son prix de vente que si cette perte dépasse le cût de
  catalogue $overline(z) i$. Si on suppose qu’une firme indifférente change
  son prix de vente, la règle de décision est donc donnée par :

$
cases(
  K (p^(ast.basic))^2 & gt.eq & overline(z) i arrow.r.double & #box[la firme ajuste son prix de vente à $p^ast.basic$] ,
  K (p^(ast.basic))^2 & lt & overline(z) i arrow.r.double & upright("la firme maintient son prix à ") p^n upright(" ") lr((eq 0))
)
$

Puisque toute les firmes telles que $K (p^(ast.basic))^2 gt.eq overline(z) i$
ajustent leur prix, la proportion de ces firmes satisfait (voir
graphique) : $ K (p^(ast.basic))^2 eq overline(z) lr((1 minus omega)) $ soit
$ 1 minus omega eq lr((K / overline(z))) (p^(ast.basic))^2 $<ome> Plus le nouveau
prix optimal $p^ast.basic$ s’écarte du prix naturel $p^n eq 0$, que ce
soit à la hausse ou à la baisse, plus la proportion de firmes à prix
flexibles, $1 minus omega comma$ augmente.

  Comme nous l'avons vu plus haut, lorsque $xi eq 1$, $p^ast.basic$ est
  indépendant de $p$ (donc de $omega$). Cela simplifie notre analyse car
  la partie droite de @ome n'est pas elle-même une
  fonction de $omega$ (via $p$). En conséquence, l'équilibre $omega$
  sera unique. Nous verrons dans la troisième partie que lorsque
  $xi gt 1$ il peut y avoir plusieurs équilibres pour $omega$.

  #import "@preview/cetz:0.4.2"
  #align(center)[

  #cetz.canvas(length: 1cm, {

    import cetz.draw: *
    
    set-style(
      stroke: (thickness: 0.5pt),
      content: (padding: 2pt)
    )
    
    // Axes
    line((0, 0), (6, 0), mark: (end: "stealth"))
    line((0, 0), (0, 4), mark: (end: "stealth"))
    
    // Axis labels
    content((6.2, -0.2), $i$)
    // content((-0.3, 4.2), $z(i)$)
    
    // Linear cost function z(i) = z̄·i (blue line)
    line((0, 0), (5.5, 3.85), stroke: (paint: blue, thickness: 1.5pt))
    content((5.2, 4.2), text(fill: blue, size: 11pt, $z(i) = overline(z) i$), anchor: "south-west")
    
    // Horizontal line at K(p*)² (red dashed)
    line((0, 2.2), (6, 2.2), stroke: (paint: red, dash: "dashed", thickness: 1.5pt))
    content((-0., 2.5), text(fill: red, size: 11pt, $overline(z)(1-omega)$), anchor: "east")
    content((7, 2.5), text(fill: red, size: 11pt, $K(p^*)^2$), anchor: "east")
    
    // Intersection point at omega
    let omega-x = 3.14
    let omega-y = 2.2
    
    // Vertical line from omega point to x-axis (dotted)
    line((omega-x, 0), (omega-x, omega-y), stroke: (paint: gray, dash: "dotted", thickness: 0.5pt))
    
    // Shaded region for firms with flexible prices
    line((omega-x, 0), (5.5, 0), (5.5, 3.85), (omega-x, omega-y), close: true, 
         fill: rgb(100, 150, 255, 100), stroke: none)
    
    // X-axis ticks and labels
    line((0, -0.1), (0, 0.1), stroke: black + 0.3pt)
    content((0, -0.35), $0$, anchor: "north")
    
    line((omega-x, -0.1), (omega-x, 0.1), stroke: black + 0.3pt)
    // content((omega-x, -0.35), $omega$, anchor: "north")
    
    line((5.5, -0.1), (5.5, 0.1), stroke: black + 0.3pt)
    content((5.5, -0.35), $1$, anchor: "north")
    
    // Y-axis tick for z̄
    line((-0.1, 3.85), (0.1, 3.85), stroke: black + 0.3pt)
    // content((-0.4, 3.85), $overline(z)$, anchor: "east")
    
    line((0, 0.2), (3.14, 0.2), mark: (start:">", end: ">"))
    
    line((3.14, 0.2), (5.5, 0.2), mark: (start:">", end: ">"))
    

    content((2.0, 0.4), text(size: 9pt, [$(1-omega)$]))
    content((4.5, 0.4), text(size: 9pt, [$omega$]))

    // Region labels
    content((1.5, 2.5), text(size: 9pt, [Ajuste]))
    content((4.5, 2.5), text(size: 9pt, [Maintient]))
  })

  ]

]

#set enum(numbering: "1.", start: 6)

+ Calculer le niveau général des prix $p$ en fonction de $p^star$, et en déduire la relation entre $p$, $omega$ et $y$. Interpréter le résultat obtenu.

#correction[
  On rappelle qu’on est au voisinage de l’équilibre symétrique, de sorte que le og ldu prix moyen est en première approximation égal à la moyenne des prix en log. Avec $p^n eq 0$ on a donc :
  $ p eq integral_0^1 p_i upright("d") i eq omega p^n plus lr((1 minus omega)) p^ast.basic eq lr((1 minus omega)) p^ast.basic $
  où $ p^ast.basic eq 1 / xi y plus p eq y plus p $ On obtient ainsi :
  $ p eq lr((1 minus omega)) lr((y plus p)) eq lr((frac(1 minus omega, omega))) y $
  #strong[Interprétation] : un niveau de production ($y$) élevé est associé à des coûts salariaux ($w minus p$) élevés, ce qui fait monter le prix de vente des firmes qui ajustent leur prix ($p^ast.basic$) et donc le niveau général des prix ($p$). L’impact sur le niveau g énéral des prix est d’autant plus important que le nombre de firmes à prix
  fixes ($omega$) est faible.
]

#set enum(numbering: "1.", start: 7)

+ Utiliser les réponses aux questions 5 et 6 pour montrer que la courbe d'offre agrégée peut s'écrire $ y ( p ) = ((overline(z)/K)^frac(1,3) |p| ^(-frac(2,3))-1) p $ et représenter graphiquement cette fonction dans le plan ($y,p$). Commentez la pente de la courbe. 


#correction[
  

On part des relations
  $ 1 minus omega & eq & lr((K / overline(z))) (p^(ast.basic))^2\
  p & eq & lr((1 minus omega)) p^ast.basic\
  p & eq & lr((frac(1 minus omega, omega))) y $ 
  On peut éliminer $p^ast.basic$ dans ces équations :
  $ 1 minus omega eq lr((K / overline(z))) lr((frac(p, 1 minus omega)))^2 arrow.r.double lr((1 minus omega))^3 eq lr((K / overline(z))) p^2 $
  soit
  $ 1 minus omega lr((p)) eq lr((K / overline(z)))^(1 / 3) lr(|p|)^(2 / 3) upright("   et   ") omega lr((p)) eq 1 minus lr((K / overline(z)))^(1 / 3) lr(|p|)^(2 / 3) $
On peut enfin réécrire
  $ y lr((p)) eq lr((frac(omega lr((p)), 1 minus omega lr((p))))) p eq lr((lr((overline(z) slash K))^(1 / 3) lr(|p|)^(minus 2 / 3) minus 1)) p $
  Avec $overline(z) slash K eq 1$ on obtient par exemple, dans le plan
  ($p comma y$) :


#import "@preview/cetz:0.4.2": canvas, draw
#import "@preview/cetz-plot:0.1.3": plot


// #let style = (stroke: black, fill: rgb(0, 0, 200, 75))

#let f1(x) = calc.sin((calc.pow(calc.abs(x),(-2/3)) - 1)*x)

#align(center)[

#canvas({

  import draw: *

  // Set-up a thin axis style
  set-style(axes: (stroke: .5pt, tick: (stroke: .5pt)),
            legend: (stroke: none, orientation: ttb, item: (spacing: .3), scale: 80%))

  plot.plot(size: (8, 4),
    x-label: $p$,
    x-tick-step: 0.02,
    y-tick-step: 0.1, y-min: -0.5, y-max: 0.5,
    y-label: "",
    x-grid: true,
    y-grid: true,
    grid: (stroke: rgb("#604646"), thickness: 0.3pt),
    legend: "inner-north-west",
    {
      let domain = (-0.1, 0.1)
      plot.add(f1, domain: domain, label: $y(p)$,
        style: (stroke: blue))
    })
})

]


et donc l’inverse dans le plan ($y comma p$).
Quand les chocs ($Delta theta$) sont faibles, la pente moyenne observée de la courbe (OA) (telle que mesurée par la droite des moindres carrés, par exemple) est faible, car peu de firmes ajustent leur prix suite à un
choc. 

A la limite, quand $Delta theta arrow.r 0$ on a $y arrow.r 0$ et
la pente de (OA) devient nulle (la proportion de firmes changeant ses
prix tend vers zero). Inversement, lorsque les chocs sont importants,
la pente moyenne observée est élevée car un plus grand nombre de
firmes ajuste ses prix suite à un choc.


#block[
#import "@preview/cetz:0.4.2"
#import "@preview/cetz-plot:0.1.3": plot

#cetz.canvas({
  import cetz.draw: *

  // Common S-shaped curve
  let s = (x) => 0.5 + 2.4 * calc.pow((x - 0.5)*3, 3)

  // Common axis style
  set-style(
    axes: (
      stroke: (thickness: 0.6pt),
      tick: (length: 0pt),
      padding: 0pt,
      overshoot: 5pt,
    ),
  )

  // ================= LEFT PANEL: Δm faible =================
  group({
    // position of left plot (at origin)
    translate((0, 0))

    plot.plot(
      size: (6, 4),
      axis-style: "school-book",
      x-min: 0, x-max: 1,
      y-min: 0, y-max: 1,
      x-tick-step: none,
      y-tick-step: none,
      x-label: [y],
      y-label: none,
      {
        // dashed upward line
        plot.add(
          domain: (0, 1),
          x => 0.25 * (x - 0.5) + 0.5,
          style: (stroke: (paint: black, dash: "dashed", thickness: 0.7pt)),
        )

        // OA and DA (small shift)
        let og = (x) => 0.8 - 0.55 * x
        let dg = 0.05

        plot.add(
          ((0, og(0)), (1, og(1))),
          style: (stroke: (paint: green, thickness: 0.8pt)),
        )

        plot.add(
          ((0, og(0) - dg), (1, og(1) - dg)),
          style: (stroke: (paint: green, thickness: 0.8pt)),
        )

        // red S curve
        plot.add(
          s,
          domain: (0.05, 0.95),
          samples: 200,
          style: (stroke: (paint: red, thickness: 0.9pt)),
        )

        // equilibrium + dotted guides
        let x0 = 0.52
        let y0 = s(x0)

        plot.add(
          ((x0, 0), (x0, y0)),
          style: (stroke: (paint: gray, dash: "dotted", thickness: 0.5pt)),
        )

        plot.add(
          ((0, y0), (x0, y0)),
          style: (stroke: (paint: gray, dash: "dotted", thickness: 0.5pt)),
        )
      },
    )

    // panel title
    content((3, 4.6),$Δ theta "faible"$, anchor: "center")

    // OA / DG labels + small DG arrow
    content((5.8, 3.8), "(OA)", anchor: "north-east")
    content((5.9, 0.7), "(DA)", anchor: "south-east")

    // line(
    //   (4.9, 1.6),
    //   (5.4, 0.9),
    //   stroke: (paint: gray, thickness: 0.5pt),
    //   mark: (end: ">"),
    // )
  })

  // ================= RIGHT PANEL: Δm élevé =================
  group({
    // shift right by 6 (plot width) + 1.5 (gap)
    translate((7.5, 0))

    plot.plot(
      size: (6, 4),
      axis-style: "school-book",
      x-min: 0, x-max: 1,
      y-min: 0, y-max: 1,
      x-tick-step: none,
      y-tick-step: none,
      x-label: none,
      y-label: [p],
      {
        // dashed upward line
        plot.add(
          domain: (0, 1),
          x => 0.5 + 1 * (x - 0.5),
          style: (stroke: (paint: black, dash: "dashed", thickness: 0.7pt)),
        )

        // OA and DA (larger shift)
        let dg = 0.36
        let og = (x) => 0.5 - 0.55 * (x - 0.5) + dg/2

        plot.add(
          ((0, og(0)), (1, og(1))),
          style: (stroke: (paint: green, thickness: 0.8pt)),
        )

        plot.add(
          ((0, og(0) - dg), (1, og(1) - dg)),
          style: (stroke: (paint: green, thickness: 0.8pt)),
        )

        // red S curve
        plot.add(
          s,
          domain: (0.05, 0.95),
          samples: 200,
          style: (stroke: (paint: red, thickness: 0.9pt)),
        )

        // shifted equilibrium + dotted guides
        let x1 = 0.68
        let y1 = s(x1)

        plot.add(
          ((x1, 0), (x1, y1)),
          style: (stroke: (paint: gray, dash: "dotted", thickness: 0.5pt)),
        )

        plot.add(
          ((0, y1), (x1, y1)),
          style: (stroke: (paint: gray, dash: "dotted", thickness: 0.5pt)),
        )
      },
    )

    // panel title
    content((3, 4.6), $Δ theta "élevé"$, anchor: "center")

    // OA / DA labels + big DA arrow
    content((5.8, 3.8), "(OA)", anchor: "north-east")
    content((5.9, 0.7), "(DA)", anchor: "south-east")

    // line(
    //   (4.4, 0.6),
    //   (5.6, 2.1),
    //   stroke: (paint: gray, thickness: 0.5pt),
    //   mark: (end: ">"),
    // )
  })

  // Global horizontal axis label under both panels
  content((6.75, -0.8), "y", anchor: "center")
})

]

La pente moyenne observée de (OA) est donc une fonction croissante de la volatilité de la demande agrégée. Une valeur de $overline(z)$ élevée est associée à des coûts de catalogue plus importants pour toutes les firmes, ce qui réduit la pente de (OA) pour toute valeur de $Delta theta$. De la
même manière, une valeur de $K$ élevée augmente le coût d’opportunité
associé au maintien d’un prix constant, ce qui réduit la pente de
(OA) pour toute valeur de $Delta theta$.

#align(center)[

#import "@preview/cetz:0.4.2"
#import "@preview/cetz-plot:0.1.3": plot

#cetz.canvas({

  import cetz.draw: *
    
    let s1 = (x) => 0.5 + 2.4 * calc.pow((x - 0.5)*2, 3)
    let s2 = (x) => 0.5 + 2.4 * calc.pow((x - 0.5)*3, 3)

    plot.plot(

      size: (6, 4),
      axis-style: "school-book",
      x-min: 0, x-max: 1,
      y-min: 0, y-max: 1,
      x-tick-step: none,
      y-tick-step: none,
      x-label: [y],
      y-label: none,
      
      {
        // dashed upward line
        plot.add(
          domain: (0, 1),
          x => 0.25 * (x - 0.5) + 0.5,
          style: (stroke: (paint: black, dash: "dashed", thickness: 0.7pt)),
        )

        // OA and DA (small shift)
        let og = (x) => 0.5 - 0.5 * (x - 0.5)
        let dg = 0.00

        plot.add(
          ((0, og(0)), (1, og(1))),
          style: (stroke: (paint: green, thickness: 0.8pt)),
        )


        // equilibrium + dotted guides
        let x0 = 0.52
        let y0 = 0.8

        plot.add(
          ((x0, 0), (x0, y0)),
          style: (stroke: (paint: gray, dash: "dotted", thickness: 0.5pt)),
        )

        plot.add(
          ((0, y0), (x0, y0)),
          style: (stroke: (paint: gray, dash: "dotted", thickness: 0.5pt)),
        )

        plot.add(
          s1,
          domain: (0.05, 0.95),
          samples: 200,
          style: (stroke: (paint: red, thickness: 0.9pt)),
        )
                plot.add(
          s2,
          domain: (0.05, 0.95),
          samples: 200,
          style: (stroke: (paint: red, thickness: 0.9pt, dash: "dashed")),
        )

      },
    )

    // panel title

    // OA / DG labels + small DG arrow
    content((3.8, 3.8), $z "faible /" K "élevé"$, anchor: "north-east")
    content((7.5, 3.), $z "élevé /" K "faible"$, anchor: "north-east")})

]

On note que  $K eq eta lr((eta minus 1)) slash 2$ est lié au degré substituabilité   entre les biens ($eta$) et donc à l’intensité de la concurrence sur ce marché. Une concurrence plus forte tend à élever la pente de OA, et   donc à réduire l’impact des chocs de demande sur le produit.


]

=== Troisième partie (facultatif) : coûts de catalogue et multiplicité d'équilibres

On suppose maintenant que $xi >1$, et que toutes les firmes font face au même coût de catalogue $overline(z)$. Comme dans la deuxième partie, l'économie est initialement à l'équilibre naturel et on s'interroge sur les incitations qu'ont les firmes à changer leur prix suite au choc $Delta theta$.


#set enum(numbering: "1.", start: 8)

+ Exprimer $p$, $y$ et $p^star$ en fonction de $Delta theta$ et $1-omega$

#correction[

L’équilibre après le choc est caractérisé par les équations suivantes
  :
  $ p & eq & lr((1 minus omega)) p^ast.basic upright(" (prix moyen, avec ") p^n eq 0 )\
  p^ast.basic & eq & 1 / xi y plus p upright(" (prix optimal, cf. question 3)")\
  y & eq & Delta theta minus p upright("  (demande agrégée avec ") theta_1 eq Delta theta upright(")") $<price>
  Ce qui donne :
  $ p & eq & lr((frac(1 minus omega, 1 minus omega lr((1 minus xi))))) Delta theta\
  y & eq & lr((frac(omega xi, 1 minus omega lr((1 minus xi))))) Delta theta\
  p^ast.basic & eq & lr((frac(1, 1 minus omega lr((1 minus xi))))) Delta theta $

]

#set enum(numbering: "1.", start: 9)




+ Calculer $K (p^star)^2$ en fonction de $omega $, et interpréter le résultat obtenu.

#correction[

La perte proportionnelle de profit $K (p^(ast.basic))^2$ est donnée par
  :
  $ K (p^(ast.basic))^2 eq K lr((frac(Delta theta, 1 minus omega lr((1 minus xi)))))^2 $

  Il est important de noter que $p^ast.basic$ (et donc la perte de ne pas  ajuster le prix) dépend de ce que font les autres entreprises lorsque
  $xi gt 1$. Avec $xi gt 1$ (offre de travail relativement élastique),
  une hausse de $omega$ diminue la perte liée au fait de maintenir un
  prix constant; il y a donc des complémentarités stratégiques dans les
  décisions de prix. On dit qu’il y a des complémentarités stratégiques
  dans un jeu si l’incitation du joueur à entreprendre une certaine
  action est renforcée lorsque les autres joueurs font la même action.

Dans ce modèle, les décisions des firmes de modifier
  les prix (ou de les maintenir inchangés) peuvent se renforcer
  mutuellement. Pour voir cela, utilisez @price pour
  obtenir

  $ p^ast.basic eq p lr((frac(xi minus 1, xi))) plus frac(Delta theta, xi) $

  Cette équation montre que lorsque $xi gt 1$, nous avons que
  $p^ast.basic$ doit augmenter davantage si $p$ augmente davantage.
  Autrement dit, si plus d’entreprises augmentent les prix après un choc
  $Delta theta$, $p$ croîtra davantage, de sorte que $p^ast.basic$ devra
  croître davantage, poussant les entreprises à modifier les prix


]

#set enum(numbering: "1.", start: 10)

+ Calculer les valeurs de $Delta theta $ pour lesquelles
  - $omega =0$ est le seul équilibre de Nash symétrique
  - $omega =1$ est le seul équilibre de Nash symétrique
  - les deux équilibres de Nash sont possibles.

#correction[

Contrairement à la deuxième partie, puisque le coût $overline(z)$ est le
  même pour toutes les firmes, l’équilibre sera symétrique: soit toutes
  les firmes changent de prix, soit toutes les firmes gardent le même
  prix. Considérons les deux équilibres potientiels tour à tour.

- Supposons que chaque firme anticipe $omega eq 1$. Cet équilibre est
  auto-réalisé si la perte individuelle de profit (en niveau) associ ée
  au maintien d’un prix constant est inférieure au coût de catalogue :
  $ K (p^star)^2 =K ( (Delta theta)/ xi )^2 < overline(z) <=> (Delta theta)^2 < xi^2 overline(z)/K $

- Supposons que chaque firme anticipe $omega eq 0$. Cet équilibre est
  auto-réalisé si la perte individuelle de profit associée au maintien
  d’un prix constant est supérieure au coût de catalogue :
  $ K (p^(ast.basic))^2 eq K lr((Delta theta))^2 gt overline(z) arrow.l.r.double lr((Delta theta))^2 gt overline(z) / K $

- Comme $xi gt 1$, une multiplicité d’équilibres est possible pour des
  valeurs intérmédiaires de $lr((Delta theta))^2$.



#align(center)[

#block[
#import "@preview/cetz:0.4.2"
#import "@preview/cetz-plot:0.1.3": plot

#cetz.canvas({
  import cetz.draw: *

  // Common S-shaped curve
  let s = (x) => 0.5 + 2.4 * calc.pow((x - 0.5)*3, 3)

  // Common axis style
  set-style(
    axes: (
      stroke: (thickness: 0.6pt),
      tick: (length: 0pt),
      padding: 0pt,
      overshoot: 5pt,
    ),
  )

  // ================= LEFT PANEL: Δm faible =================
  group({
    // position of left plot (at origin)
    translate((0, 0))

    plot.plot(
      size: (6, 4),
      axis-style: "school-book",
      x-min: 0, x-max: 1,
      y-min: 0, y-max: 1,
      x-tick-step: none,
      y-tick-step: none,
      x-label: [y],
      y-label: none,
      {


        plot.add(
          ((0, 0.6), (1, 0.6)),
          style: (stroke: (paint: green, thickness: 0.8pt)),
        )
        plot.add(
          ((0, 0.4), (1, 0.4)),
          style: (stroke: (paint: red, thickness: 0.8pt)),
        )

      },
    )
 // OA / DA labels + big DA arrow
    content((5.8, 2.8), $overline(z)$, anchor: "north-east")
    content((5.9, 1.1), $"K" (p^star)^2$, anchor: "south-east")


    // line(
    //   (4.9, 1.6),
    //   (5.4, 0.9),
    //   stroke: (paint: gray, thickness: 0.5pt),
    //   mark: (end: ">"),
    // )
  })

  // ================= RIGHT PANEL: Δm élevé =================
  group({
    // shift right by 6 (plot width) + 1.5 (gap)
    translate((7.5, 0))

    plot.plot(
      size: (6, 4),
      axis-style: "school-book",
      x-min: 0, x-max: 1,
      y-min: 0, y-max: 1,
      x-tick-step: none,
      y-tick-step: none,
      x-label: none,
      y-label: [p],
      {
      

        plot.add(
          ((0, 0.4), (1, 0.4)),
          style: (stroke: (paint: green, thickness: 0.8pt)),
        )
        plot.add(
          ((0, 0.5), (1, 0.5)),
          style: (stroke: (paint: red, thickness: 0.8pt)),
        )

      },
    )

    // OA / DA labels + big DA arrow
    content((5.8, 2.5), $"K" (p^star)^2$, anchor: "north-east")
    content((5.9, 1.1), $overline(z)$, anchor: "south-east")

    // line(
    //   (4.4, 0.6),
    //   (5.6, 2.1),
    //   stroke: (paint: gray, thickness: 0.5pt),
    //   mark: (end: ">"),
    // )
  })

  // Global horizontal axis label under both panels
  content((6.75, -0.8), "y", anchor: "center")
})

]
]


Dans la figure de gauche, nous avons que lorsque les entreprises s’attendent à
ce que $omega eq 0$ (c’est-à-dire qu’aucune entreprise ne garde les prix
inchangés), la perte de ne pas changer les prix (la ligne rouge) est
supérieure à $overline(z)$ (ligne verte ): les anticipations sont confirmées et il est
en effet optimal de modifier les prix pour toutes les entreprises. Dans
la figure de droite, nous woyons  que lorsque les entreprises s’attendent à ce que
$omega eq 1$ (c’est-à-dire qu’aucune entreprise ne change de prix), la
perte de ne pas changer les prix est inférieure à $overline(z)$: il est
optimal de maintenir les prix inchangés.

La multiplicité des équilibres
implique que le cas keynésien ($omega eq 1$) ou le cas classique
($omega eq 0$) sont tous deux possibles dans la même économie: le
résultat dépend des anticipations.

Les anticipations auto-réalisatrices
ont des conséquences sur la production: dans le cas keynésien, le choc de demande agrégée a un effet potentiellement important sur la production car les
entreprises ne changent pas de prix. Dans le cas classique, le choc n’a
aucun effet sur la production, car les entreprises réagissent en
modifiant les prix et non les quantités. Enfin, notez que les équilibres
multiples ne se produisent pas lorsque les chocs $Delta theta$ sont soit
très élevés, soit très faibles. Dans le premier cas, toutes les
entreprises changent de prix indépendamment des attentes. Dans le second
cas, toutes les entreprises maintiennent les prix inchangés quelles que
soient leurs attentes.

]