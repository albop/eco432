#import "pc_template.typ": pc, correction

#let correct=false

#show: doc => pc(
  3,
  [Coûts de catalogue],
  doc,
  correct: correct,
)

#let correction = correction.with(visible: correct)

On considère le modèle suivant de concurrence monopolistique avec rigidités nominales sur le marché des biens. Les firmes forment un continuum de longueur 1. Chaque firme maximise son profit réel et fait face à la fonction de demande

$
Y_i=Y ( frac(P_i,P) ) ^(-eta) eta >1
$

où $Y_(i)$, $i in [ 0,1] $ est la demande adressée à la firme $i$, $P_(i)$ le prix de vente nominal du bien qu'elle produit, $P$ le niveau général de prix (qu'on déterminera plus loin) et $Y$ la demande agrégée. Les firmes sont dotées de la fonction de production $Q_(i)=L_(i)$.


$
L^o=A ( frac(W,P) ) ^(xi)
$

où $xi >0$ est l'élasticité de l'offre de travail au salaire, $W$ le salaire nominal et

$
A=( frac(eta,eta -1)) ^(xi) >0
$

une constante d'échelle. 



Enfin, on suppose que la demande agrégée est donnée par:

$
y=theta-p
$
où $theta$ est un choc de demande. 
Comme d'habitude, les lettres minuscules désignent le logarithme des lettres majuscules correspondantes. Par ailleurs, on raisonnera toujours au voisinage de l'équilibre symétrique où toutes les firmes fixent le même prix de vente, ce qui implique que le log du prix moyen $p=ln P$ est en première approximation égal à la moyenne des prix de vente individuels en log $p_(i)=ln P_(i)$:

$
p tilde.eq integral_0^1 p_(i) dif i
$

et de même pour la demande de travail totale en log :

$
l^d tilde.eq integral_0^1 l_(i) dif i
$


=== Première partie : prix de vente optimal et équilibre naturel



+ Interpréter les équations du modèle.

+ Calculer le prix de vente optimal de la firme, $P^star$, en fonction du salaire nominal $W$, et interpréter.

Dans ce qui suit, exprimez toutes les variables en logarithme.

#set enum(numbering: "1.", start: 3)

+ Utiliser l'équilibre sur le marché du travail pour exprimer le prix réel optimal $p^(star)-p$ en fonction de $y$ et expliquer le résultat  obtenu.

+ Calculer l'équilibre de prix flexibles ($y^n,p^n$) lorsque $theta=theta_0=0$.



=== Deuxième partie : coûts de catalogue hétérogènes et pente de l'arbitrage

On suppose dans cette partie que $xi =1$, et que l'économie est à l'équilibre naturel ($y^n,p^n$) avant un choc de demande de taille $Delta theta=theta_1-theta_0$ ($=theta_1$). Les firmes font face à des coûts fixes de changement de prix (coûts de catalogues), de sorte qu'elles peuvent rationnellement
choisir de maintenir leur prix de vente au niveau $p^n$ même après le choc. Les coûts de catalogue diffèrent d'une firme à l'autre : en classant les firmes $i in [ 0,1] $ par ordre croissant de coût de catalogue, on suppose que la firme $i$ fait face au coût :
$ z( i ) =overline(z) i $ où $overline(z)$ est une constante positive.

#set enum(numbering: "1.", start: 6)

+ Le choix d'un prix de vente $p_(i) eq.not p^star$ engendre une perte de profit. Au voisinage de l'équilibre symétrique (où $p^star tilde.eq p$) la perte est de second ordre et égale à $K (p_ (i) -p ^ star ) ^ 2 $, où $K> 0$ est une constante positive.#footnote[Il n'est pas nécessaire de dériver ce résultat.] Plus l'écart entre le prix courant  et le prix optimal  est important, plus la perte est importante.  Calculer la proportion $omega in [ 0,1] $ de firmes maintenant leur prix inchangé en fonction du nouveau prix optimal $p^star$ prévalant après le choc, et interpréter.

+ Calculer le niveau général des prix $p$ en fonction de $p^star$, et en déduire la relation entre $p$, $omega$ et $y$. Interpréter le résultat obtenu.

+ Utiliser les réponses aux questions 5 et 6 pour montrer que la courbe d'offre agrégée peut s'écrire $ y ( p ) = ((overline(z)/K)^frac(1,3) |p| ^(-frac(2,3))-1) p $ et représenter graphiquement cette fonction dans le plan ($y,p$). Commentez la pente de la courbe. 


=== Troisième partie (facultatif) : coûts de catalogue et multiplicité d'équilibres

On suppose maintenant que $xi >1$, et que toutes les firmes font face au même coût de catalogue $overline(z)$. Comme dans la deuxième partie, l'économie est initialement à l'équilibre naturel et on s'interroge sur les incitations qu'ont les firmes à changer leur prix suite au choc $Delta theta$.

#set enum(numbering: "1.", start: 9)

+ Exprimer $p$, $y$ et $p^star$ en fonction de $Delta theta$ et $1-omega$

+ Calculer $K (p^star)^2$ en fonction de $omega $, et interpréter le résultat obtenu.

+ Calculer les valeurs de $Delta theta $ pour lesquelles
  - $omega =0$ est le seul équilibre de Nash symétrique
  - $omega =1$ est le seul équilibre de Nash symétrique
  - les deux équilibres de Nash sont possibles.
